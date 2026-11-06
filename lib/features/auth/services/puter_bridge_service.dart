import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/errors/app_exception.dart';
import '../models/puter_user.dart';
import '../models/puter_usage.dart';
import '../../scanner/models/food_analysis_result.dart';
import '../../scanner/models/menu_analysis_result.dart';
import '../../scanner/models/label_analysis_result.dart';
import '../../meal_planner/models/meal_plan.dart';
import '../../comparison/models/comparison_result.dart';
import '../../../shared/services/local_storage_service.dart';

class PuterBridgeService {
  final LocalStorageService _storageService;
  WebViewController? _webViewController;
  bool _isBridgeReady = false;
  Completer<void>? _bridgeReadyCompleter;

  final Map<String, Completer<dynamic>> _pendingRequests = {};
  final StreamController<PuterUsage> _usageStreamController =
      StreamController<PuterUsage>.broadcast();
  final StreamController<PuterInsufficientFundsException>
  _insufficientFundsStreamController =
      StreamController<PuterInsufficientFundsException>.broadcast();
  final StreamController<Map<String, dynamic>> _aiChunkStreamController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Map<String, dynamic>> _aiStageStreamController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<bool> _authModalStateStreamController =
      StreamController<bool>.broadcast();

  Stream<PuterUsage> get usageStream => _usageStreamController.stream;
  Stream<PuterInsufficientFundsException> get insufficientFundsStream =>
      _insufficientFundsStreamController.stream;
  Stream<Map<String, dynamic>> get aiChunkStream =>
      _aiChunkStreamController.stream;
  Stream<Map<String, dynamic>> get aiStageStream =>
      _aiStageStreamController.stream;
  Stream<bool> get authModalStateStream =>
      _authModalStateStreamController.stream;

  bool get isBridgeReady => _isBridgeReady;
  WebViewController? get webViewController => _webViewController;

  PuterBridgeService(this._storageService);

  Future<void> initializeBridge() async {
    if (_webViewController != null && _isBridgeReady) return;
    if (_bridgeReadyCompleter != null && !_bridgeReadyCompleter!.isCompleted) {
      return _bridgeReadyCompleter!.future;
    }

    _bridgeReadyCompleter = Completer<void>();

    try {
      final controller = WebViewController();
      await controller.setJavaScriptMode(JavaScriptMode.unrestricted);
      await controller.setBackgroundColor(const Color(0xFF0C121E));
      await controller.setUserAgent(
        'Mozilla/5.0 (Linux; Android 13; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Mobile Safari/537.36',
      );

      await controller.addJavaScriptChannel(
        'FlutterBridge',
        onMessageReceived: (JavaScriptMessage message) {
          _handleJavaScriptMessage(message.message);
        },
      );

      controller.setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) async {
            debugPrint('[PuterBridge] Page finished loading: $url');
            final cachedToken = _storageService.getPuterToken();
            if (cachedToken != null && cachedToken.isNotEmpty) {
              setAuthToken(cachedToken).catchError((e) {
                debugPrint(
                  '[PuterBridge] Non-blocking initial token set error: $e',
                );
                return false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('[PuterBridge] Resource error: ${error.description}');
          },
        ),
      );

      final htmlString = await rootBundle.loadString(
        'assets/html/puter_bridge.html',
      );
      await controller.loadHtmlString(htmlString, baseUrl: 'https://puter.com');
      _webViewController = controller;

      // Wait up to 3.5 seconds for bridge readiness
      await _bridgeReadyCompleter!.future.timeout(
        const Duration(milliseconds: 3500),
        onTimeout: () {
          debugPrint(
            '[PuterBridge] Bridge initialization timed out, marking ready anyway.',
          );
          _isBridgeReady = true;
        },
      );
    } catch (e) {
      debugPrint('[PuterBridge] Error initializing controller: $e');
      _isBridgeReady = true;
    }
  }

  void _handleJavaScriptMessage(String messageText) {
    try {
      final Map<String, dynamic> payload = jsonDecode(messageText);
      final String type = payload['type'] as String? ?? 'unknown';
      final String? requestId = payload['requestId'] as String?;
      final dynamic data = payload['data'];

      // debugPrint('[PuterBridge Recv] Type: $type, RequestId: $requestId');

      if (type == 'bridge_ready') {
        _isBridgeReady = true;
        if (_bridgeReadyCompleter != null &&
            !_bridgeReadyCompleter!.isCompleted) {
          _bridgeReadyCompleter!.complete();
        }
        return;
      }

      if (type == 'auth_modal_state') {
        final bool isOpen =
            data is Map<String, dynamic> && data['open'] == true;
        _authModalStateStreamController.add(isOpen);
        return;
      }

      if (type == 'ai_chunk') {
        if (data is Map<String, dynamic>) {
          _aiChunkStreamController.add({...data, 'requestId': requestId});
        }
        return;
      }

      if (type == 'ai_stage') {
        if (data is Map<String, dynamic>) {
          _aiStageStreamController.add({...data, 'requestId': requestId});
        }
        return;
      }

      if (type == 'error') {
        final Map<String, dynamic> errData = data is Map<String, dynamic>
            ? data
            : {};
        final bool isInsufficientFunds =
            errData['isInsufficientFunds'] == true ||
            errData['code'] == 'insufficient_funds' ||
            errData['code'] == 402;

        if (isInsufficientFunds) {
          final exc = PuterInsufficientFundsException(
            message:
                errData['message'] as String? ??
                'Monthly Puter AI allowance exhausted.',
            upgradeUrl:
                errData['upgradeUrl'] as String? ?? 'https://puter.com/account',
          );
          _insufficientFundsStreamController.add(exc);
          if (requestId != null && _pendingRequests.containsKey(requestId)) {
            _pendingRequests.remove(requestId)!.completeError(exc);
          }
          return;
        }

        final bool isAuthError =
            errData['isAuthError'] == true ||
            errData['code'] == 'auth_required' ||
            errData['code'] == 401 ||
            errData['code'] == 403 ||
            (errData['message'] as String? ?? '').toLowerCase().contains(
              'unauthorized',
            ) ||
            (errData['message'] as String? ?? '').toLowerCase().contains(
              'auth_required',
            ) ||
            (errData['message'] as String? ?? '').toLowerCase().contains(
              'authentication required',
            );

        if (isAuthError) {
          final exc = PuterAuthException(
            errData['message'] as String? ??
                'Puter authentication required. Please connect your Puter account.',
            code: 'auth_required',
          );
          if (requestId != null && _pendingRequests.containsKey(requestId)) {
            _pendingRequests.remove(requestId)!.completeError(exc);
          }
          return;
        }

        if (requestId != null && _pendingRequests.containsKey(requestId)) {
          _pendingRequests
              .remove(requestId)!
              .completeError(
                AppException(
                  errData['message'] as String? ?? 'Puter Bridge error',
                  code: errData['code']?.toString(),
                ),
              );
        }
        return;
      }

      if (requestId != null && _pendingRequests.containsKey(requestId)) {
        _pendingRequests.remove(requestId)!.complete(data);
      }
    } catch (e) {
      debugPrint('[PuterBridge] Failed to parse message from JS: $e');
    }
  }

  bool get hasToken =>
      _storageService.getPuterToken() != null &&
      _storageService.getPuterToken()!.trim().isNotEmpty;

  Future<dynamic> _executeCommand(
    String action, {
    Map<String, dynamic>? params,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    if (_webViewController == null || !_isBridgeReady) {
      await initializeBridge();
    }

    final isAiAction =
        action.startsWith('analyze_') ||
        action.startsWith('generate_') ||
        action == 'compare_foods';
    if (isAiAction) {
      final cachedToken = _storageService.getPuterToken();
      if (cachedToken == null || cachedToken.trim().isEmpty) {
        throw PuterAuthException(
          'Please log in with your Puter account to scan food and analyze nutrition.',
        );
      }
      final safeToken = cachedToken
          .trim()
          .replaceAll(r'\', r'\\')
          .replaceAll("'", r"\'")
          .replaceAll('"', r'\"');
      await _webViewController?.runJavaScript('''
        try {
          if (!puter.authToken || puter.authToken !== '$safeToken') {
            if (typeof puter.setAuthToken === 'function') {
              puter.setAuthToken('$safeToken');
            }
            puter.authToken = '$safeToken';
            if (puter.auth) puter.auth.token = '$safeToken';
          }
        } catch (_) {}
      ''');
    }

    final String requestId = const Uuid().v4();
    final completer = Completer<dynamic>();
    _pendingRequests[requestId] = completer;

    final paramsJson = jsonEncode(params ?? {});
    final paramsStringEscaped = jsonEncode(paramsJson);

    final jsCall =
        '''
      (function() {
        try {
          if (window.FoodLensBridge && typeof window.FoodLensBridge.executeCommand === 'function') {
            window.FoodLensBridge.executeCommand('$action', $paramsStringEscaped, '$requestId');
          } else if (window.FoodLensPuterBridge && typeof window.FoodLensPuterBridge.handleCommand === 'function') {
            window.FoodLensPuterBridge.handleCommand({
              action: '$action',
              params: $paramsJson,
              requestId: '$requestId'
            });
          } else {
            console.error('[PuterBridge] No bridge object found');
          }
        } catch(err) {
          console.error('[PuterBridge execute error]', err);
        }
      })();
    ''';

    try {
      await _webViewController!.runJavaScript(jsCall);
    } catch (e) {
      _pendingRequests.remove(requestId);
      throw AppException('Failed to execute JavaScript command: $e');
    }

    return completer.future.timeout(
      timeout,
      onTimeout: () {
        _pendingRequests.remove(requestId);
        throw AppException(
          'Operation timed out. Please check your internet connection.',
        );
      },
    );
  }

  Future<void> cancelRequest(String requestId) async {
    if (_pendingRequests.containsKey(requestId)) {
      _pendingRequests.remove(requestId);
    }
    try {
      await _webViewController?.runJavaScript(
        "window.FoodLensBridge && window.FoodLensBridge.executeCommand('cancel_request', JSON.stringify({targetRequestId: '$requestId'}), '$requestId');",
      );
    } catch (_) {}
  }

  // --- Auth & Session ---

  Future<Map<String, dynamic>> checkSession({
    Duration timeout = const Duration(seconds: 4),
  }) async {
    try {
      final res = await _executeCommand('get_session', timeout: timeout);
      return res is Map<String, dynamic>
          ? res
          : {'isSignedIn': false, 'user': null, 'usage': null};
    } catch (e) {
      debugPrint('[PuterBridge] checkSession non-blocking fallback: $e');
      return {'isSignedIn': false, 'user': null, 'usage': null};
    }
  }

  Future<PuterUser?> getUser({
    Duration timeout = const Duration(seconds: 5),
  }) async {
    try {
      final res = await _executeCommand('get_user', timeout: timeout);
      if (res is Map<String, dynamic> && res['user'] != null) {
        return PuterUser.fromJson(res['user'] as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint('[PuterBridge] getUser error: $e');
    }
    return null;
  }

  Future<PuterUsage> getMonthlyUsage({
    Duration timeout = const Duration(seconds: 6),
  }) async {
    try {
      final res = await _executeCommand('get_monthly_usage', timeout: timeout);
      if (res is Map<String, dynamic>) {
        final usage = PuterUsage.fromJson(res);
        _usageStreamController.add(usage);
        return usage;
      }
    } catch (e) {
      if (e is PuterInsufficientFundsException) rethrow;
      debugPrint('[PuterBridge] getMonthlyUsage error: $e');
    }
    return PuterUsage.defaultFreeTier();
  }

  Future<bool> setAuthToken(
    String token, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    try {
      final res = await _executeCommand(
        'set_token',
        params: {'token': token},
        timeout: timeout,
      );
      await _storageService.setPuterToken(token);
      if (res is Map<String, dynamic> && res['user'] != null) {
        final user = PuterUser.fromJson(res['user'] as Map<String, dynamic>);
        await _storageService.setPuterUsername(user.username);
        await _storageService.setPuterUuid(user.uuid);
      }
      return true;
    } catch (e) {
      debugPrint('[PuterBridge] setAuthToken error: $e');
      return false;
    }
  }

  Future<PuterUser?> signIn({
    Duration timeout = const Duration(minutes: 3),
  }) async {
    try {
      final res = await _executeCommand('sign_in', timeout: timeout);
      if (res is Map<String, dynamic> && res['user'] != null) {
        final user = PuterUser.fromJson(res['user'] as Map<String, dynamic>);
        await _storageService.setPuterUsername(user.username);
        await _storageService.setPuterUuid(user.uuid);
        return user;
      }
    } catch (e) {
      debugPrint('[PuterBridge] signIn error: $e');
      rethrow;
    }
    return null;
  }

  Future<void> signOut() async {
    // 1. Immediately wipe stored tokens and credentials from local storage
    try {
      await _storageService.clearAuth();
    } catch (e) {
      debugPrint('[PuterBridge] Error clearing local auth: $e');
    }

    // 2. Clear WebView cookies
    try {
      await WebViewCookieManager().clearCookies();
    } catch (e) {
      debugPrint('[PuterBridge] Error clearing cookies: $e');
    }

    // 3. Clear bridge JS session (with non-blocking timeout)
    try {
      if (_webViewController != null && _isBridgeReady) {
        await _executeCommand('sign_out', timeout: const Duration(seconds: 3));
      }
    } catch (e) {
      debugPrint('[PuterBridge] Non-critical sign_out command error: $e');
    }

    // 4. Force reset in WebView JS context directly to guarantee token revocation
    try {
      await _webViewController?.runJavaScript('''
        try {
          if (typeof puter !== 'undefined') {
            if (typeof puter.resetAuthToken === 'function') {
              puter.resetAuthToken();
            }
            puter.authToken = null;
            if (puter.auth) puter.auth.token = null;
          }
          localStorage.clear();
          sessionStorage.clear();
          if (window.indexedDB) {
            try { indexedDB.deleteDatabase('puter'); } catch (_) {}
          }
        } catch (_) {}
      ''');
    } catch (_) {}
  }

  // Direct REST token validation fallback
  Future<PuterUser?> validatePuterTokenViaRest(String token) async {
    final cleanToken = token
        .trim()
        .replaceFirst(RegExp(r'^Bearer\s+', caseSensitive: false), '')
        .replaceAll('"', '')
        .replaceAll("'", "");

    try {
      final response = await http
          .get(
            Uri.parse('https://api.puter.com/whoami'),
            headers: {
              'Authorization': 'Bearer $cleanToken',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = PuterUser.fromJson(data);
        await setAuthToken(cleanToken);
        return user;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        throw PuterAuthException(
          'Invalid Puter authorization token. Please check your credentials.',
        );
      }
    } catch (e) {
      if (e is AppException) rethrow;
      debugPrint('[PuterBridge] REST validation error: $e');
    }

    try {
      await setAuthToken(cleanToken);
      final user = await getUser();
      if (user != null) return user;
    } catch (bridgeErr) {
      debugPrint('[PuterBridge] Bridge fallback error: $bridgeErr');
    }

    return null;
  }

  // --- AI Operations ---

  Future<FoodAnalysisResult> analyzeFoodImage({
    required String base64Image,
    String? dietaryPreferences,
    String languageCode = 'en',
    String languageName = 'English',
    String? model,
  }) async {
    try {
      final res = await _executeCommand(
        'analyze_food',
        params: {
          'image': base64Image,
          'preferences': dietaryPreferences ?? '',
          'languageCode': languageCode,
          'languageName': languageName,
          'model': model ?? 'gpt-4o-mini',
        },
        timeout: const Duration(seconds: 45),
      );

      if (res is Map<String, dynamic>) {
        return FoodAnalysisResult.fromJson(res);
      }
      throw AppException('Unexpected AI response format');
    } catch (e) {
      if (e is PuterInsufficientFundsException) rethrow;
      debugPrint('[PuterBridge] analyzeFoodImage error: $e');
      rethrow;
    }
  }

  Future<MenuAnalysisResult> analyzeMenuImage({
    required String base64Image,
    required String currencySymbol,
    String languageCode = 'en',
    String? model,
  }) async {
    try {
      final res = await _executeCommand(
        'analyze_menu',
        params: {
          'image': base64Image,
          'currency': currencySymbol,
          'languageCode': languageCode,
          'model': model ?? 'gpt-4o-mini',
        },
        timeout: const Duration(seconds: 45),
      );

      if (res is Map<String, dynamic>) {
        return MenuAnalysisResult.fromJson(res);
      }
      throw AppException('Unexpected AI menu response format');
    } catch (e) {
      if (e is PuterInsufficientFundsException) rethrow;
      debugPrint('[PuterBridge] analyzeMenuImage error: $e');
      rethrow;
    }
  }

  Future<LabelAnalysisResult> analyzeNutritionLabel({
    required String base64Image,
    String languageCode = 'en',
    String? model,
  }) async {
    try {
      final res = await _executeCommand(
        'analyze_label',
        params: {
          'image': base64Image,
          'languageCode': languageCode,
          'model': model ?? 'gpt-4o-mini',
        },
        timeout: const Duration(seconds: 45),
      );

      if (res is Map<String, dynamic>) {
        return LabelAnalysisResult.fromJson(res);
      }
      throw AppException('Unexpected AI label response format');
    } catch (e) {
      if (e is PuterInsufficientFundsException) rethrow;
      debugPrint('[PuterBridge] analyzeNutritionLabel error: $e');
      rethrow;
    }
  }

  Future<MealPlan> generateMealPlan({
    required int targetCalories,
    required String dietType,
    required String restrictions,
    required String cuisine,
    String languageCode = 'en',
    String languageName = 'English',
    String? model,
  }) async {
    try {
      final res = await _executeCommand(
        'generate_meal_plan',
        params: {
          'targetCalories': targetCalories,
          'dietType': dietType,
          'restrictions': restrictions,
          'cuisine': cuisine,
          'languageCode': languageCode,
          'languageName': languageName,
          'model': model ?? 'gpt-4o-mini',
        },
        timeout: const Duration(seconds: 40),
      );

      if (res is Map<String, dynamic>) {
        return MealPlan.fromJson(res);
      }
      throw AppException('Unexpected AI meal plan response format');
    } catch (e) {
      if (e is PuterInsufficientFundsException) rethrow;
      debugPrint('[PuterBridge] generateMealPlan error: $e');
      rethrow;
    }
  }

  Future<ComparisonResult> compareFoods({
    required Map<String, dynamic> foodA,
    required Map<String, dynamic> foodB,
    String languageCode = 'en',
    String languageName = 'English',
    String? model,
  }) async {
    try {
      final res = await _executeCommand(
        'compare_foods',
        params: {
          'foodA': foodA,
          'foodB': foodB,
          'languageCode': languageCode,
          'languageName': languageName,
          'model': model ?? 'gpt-4o-mini',
        },
        timeout: const Duration(seconds: 35),
      );

      if (res is Map<String, dynamic>) {
        return ComparisonResult.fromJson(res);
      }
      throw AppException('Unexpected AI food comparison format');
    } catch (e) {
      if (e is PuterInsufficientFundsException) rethrow;
      debugPrint('[PuterBridge] compareFoods error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> translateFoodData({
    required Map<String, dynamic> content,
    required String languageCode,
    required String languageName,
  }) async {
    try {
      final res = await _executeCommand(
        'translate_food_data',
        params: {
          'content': content,
          'languageCode': languageCode,
          'languageName': languageName,
        },
        timeout: const Duration(seconds: 25),
      );
      if (res is Map<String, dynamic>) {
        return res;
      }
      return content;
    } catch (e) {
      debugPrint('[PuterBridge] translateFoodData error: $e');
      return content;
    }
  }

  void dispose() {
    _usageStreamController.close();
    _insufficientFundsStreamController.close();
    _aiChunkStreamController.close();
    _aiStageStreamController.close();
    _authModalStateStreamController.close();
  }
}
