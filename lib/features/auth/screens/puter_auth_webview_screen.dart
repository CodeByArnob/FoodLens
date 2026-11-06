import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/haptic_helper.dart';
import '../providers/auth_provider.dart';

class PuterAuthWebViewScreen extends ConsumerStatefulWidget {
  final String mode; // 'login' or 'signup'

  const PuterAuthWebViewScreen({super.key, this.mode = 'login'});

  @override
  ConsumerState<PuterAuthWebViewScreen> createState() => _PuterAuthWebViewScreenState();
}

class _PuterAuthWebViewScreenState extends ConsumerState<PuterAuthWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  double _progress = 0.0;
  Timer? _authPoller;
  bool _hasDetectedToken = false;

  String get _targetUrl => widget.mode == 'signup'
      ? 'https://puter.com/signup'
      : 'https://puter.com/login';

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  @override
  void dispose() {
    _authPoller?.cancel();
    super.dispose();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent('Mozilla/5.0 (Linux; Android 13; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36')
      ..setBackgroundColor(const Color(0xFF0C121E))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (mounted) {
              setState(() {
                _progress = progress / 100.0;
              });
            }
          },
          onPageStarted: (url) {
            if (mounted) {
              setState(() {
                _isLoading = true;
              });
            }
          },
          onPageFinished: (url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
              _checkAuthToken();
            }
          },
          onWebResourceError: (error) {
            debugPrint('[PuterAuthWebView] WebResourceError: ${error.description}');
          },
          onNavigationRequest: (request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_targetUrl));

    // Poll every 1.5 seconds to detect when user finishes auth form
    _authPoller = Timer.periodic(const Duration(milliseconds: 1500), (_) {
      if (!_hasDetectedToken && mounted) {
        _checkAuthToken();
      }
    });
  }

  Future<void> _checkAuthToken() async {
    if (_hasDetectedToken) return;

    // 1. Check cookies via CookieManager
    try {
      final cookieManager = WebViewCookieManager();
      final cookies = await cookieManager.getCookies(domain: Uri.parse('https://puter.com'));
      for (final cookie in cookies) {
        if (cookie.name == 'auth_token' ||
            cookie.name == 'token' ||
            cookie.name == 'puter_auth_token' ||
            cookie.name == 'puter.auth.token') {
          if (cookie.value.isNotEmpty && cookie.value.length > 10) {
            await _onTokenDetected(cookie.value);
            return;
          }
        }
      }
    } catch (cookieErr) {
      debugPrint('[PuterAuthWebView] Cookie check: $cookieErr');
    }

    // 2. Comprehensive Javascript Extraction
    const String extractScript = r'''
      (function() {
        try {
          var token = null;

          if (window.auth_token) token = window.auth_token;
          if (!token && window.puter && window.puter.authToken) token = window.puter.authToken;
          if (!token) token = localStorage.getItem('auth_token_v2');
          if (!token) token = localStorage.getItem('auth_token');
          if (!token) token = localStorage.getItem('token');
          if (!token) token = localStorage.getItem('puter.auth.token');

          if (!token) {
            try {
              var loggedIn = JSON.parse(localStorage.getItem('logged_in_users') || '[]');
              if (Array.isArray(loggedIn) && loggedIn.length > 0 && loggedIn[0].token) {
                token = loggedIn[0].token;
              }
            } catch(e) {}
          }

          // Scan all localStorage items
          if (!token) {
            for (var i = 0; i < localStorage.length; i++) {
              var k = localStorage.key(i);
              if (k && (k.toLowerCase().indexOf('token') !== -1 || k.toLowerCase().indexOf('auth') !== -1)) {
                var v = localStorage.getItem(k);
                if (v && v.length > 10) {
                  try {
                    var parsed = JSON.parse(v);
                    if (typeof parsed === 'string') token = parsed;
                    else if (parsed && parsed.token) token = parsed.token;
                    else if (parsed && parsed.authToken) token = parsed.authToken;
                  } catch(e) {
                    token = v.replace(/^"|"$/g, '');
                  }
                }
              }
            }
          }

          // Check document.cookie
          if (!token && document.cookie) {
            var match = document.cookie.match(/(?:auth_token|token|puter_token)=([^;]+)/);
            if (match) token = match[1];
          }

          if (token && token.length > 10) {
            return JSON.stringify({ token: token });
          }
        } catch(e) {}
        return null;
      })();
    ''';

    try {
      final result = await _controller.runJavaScriptReturningResult(extractScript);
      final String raw = result.toString();

      if (raw.isNotEmpty && raw != 'null' && raw != '""') {
        String cleanJson = raw;
        if (cleanJson.startsWith('"') && cleanJson.endsWith('"')) {
          cleanJson = jsonDecode(cleanJson);
        }

        final data = jsonDecode(cleanJson);
        if (data is Map<String, dynamic> && data['token'] != null) {
          final String token = data['token'] as String;
          if (token.isNotEmpty) {
            await _onTokenDetected(token);
          }
        }
      }
    } catch (e) {
      debugPrint('[PuterAuthWebView] Check error: $e');
    }
  }

  Future<void> _onTokenDetected(String token) async {
    if (_hasDetectedToken) return;
    _hasDetectedToken = true;
    _authPoller?.cancel();
    HapticHelper.vibrateSuccess();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Puter account connected successfully!'),
        backgroundColor: AppColors.primaryLight,
      ),
    );

    final success = await ref.read(authProvider.notifier).signInWithToken(token);
    if (success && mounted) {
      context.go('/home');
    } else if (mounted) {
      setState(() {
        _hasDetectedToken = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.mode == 'signup' ? 'Create Puter Account' : 'Puter Official Sign In';

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.lock_outline, color: AppColors.primaryLight, size: 18),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.textSecondaryDark),
            onPressed: () => _controller.reload(),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.textPrimaryDark),
            onPressed: () => context.pop(),
          ),
        ],
        bottom: _isLoading
            ? PreferredSize(
                preferredSize: const Size.fromHeight(2.0),
                child: LinearProgressIndicator(
                  value: _progress > 0 ? _progress : null,
                  backgroundColor: AppColors.darkSurfaceCard,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryLight),
                ),
              )
            : null,
      ),
      body: SafeArea(
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
