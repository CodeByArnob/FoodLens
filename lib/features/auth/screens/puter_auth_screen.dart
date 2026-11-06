import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/glass_card.dart';
import '../providers/auth_provider.dart';

class PuterAuthScreen extends ConsumerStatefulWidget {
  const PuterAuthScreen({super.key});

  @override
  ConsumerState<PuterAuthScreen> createState() => _PuterAuthScreenState();
}

class _PuterAuthScreenState extends ConsumerState<PuterAuthScreen> {
  final TextEditingController _tokenController = TextEditingController();
  bool _showTokenField = false;

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
  }

  Future<void> _launchExternalBrowser(String url) async {
    final uri = Uri.parse(url);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not open your default browser. Please try again.',
            ),
          ),
        );
      }
    } catch (error) {
      debugPrint('[PuterAuth] External browser launch failed: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not open your default browser. Please try again.',
            ),
          ),
        );
      }
    }
  }

  Future<void> _handleOfficialSignIn() async {
    HapticHelper.mediumImpact();
    await _launchExternalBrowser('https://puter.com/login');
  }

  Future<void> _handleOfficialSignUp() async {
    HapticHelper.mediumImpact();
    await _launchExternalBrowser('https://puter.com/signup');
  }

  Future<void> _pasteToken() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null && data.text!.isNotEmpty) {
      _tokenController.text = data.text!.trim();
      HapticHelper.lightImpact();
    }
  }

  Future<void> _handleTokenSignIn() async {
    final token = _tokenController.text.trim();
    if (token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your Puter account token.')),
      );
      return;
    }
    HapticHelper.mediumImpact();
    final success = await ref
        .read(authProvider.notifier)
        .signInWithToken(token);
    if (success && mounted) {
      HapticHelper.vibrateSuccess();
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Connect Puter Account'),
        actions: [
          TextButton(
            onPressed: () {
              HapticHelper.lightImpact();
              context.go('/home');
            },
            child: const Text(
              'Offline Mode',
              style: TextStyle(color: AppColors.primaryLight),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Puter Cloud Emblem
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.puterBlue.withValues(alpha: 0.15),
                  border: Border.all(color: AppColors.puterBlue, width: 2),
                ),
                child: const Icon(
                  Icons.cloud_sync_rounded,
                  color: AppColors.puterBlue,
                  size: 36,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Personal Food Intelligence Cloud',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'FoodLens uses Puter.js User-Pays architecture. Connect with your official Puter account, consuming your free monthly AI compute with complete privacy.',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondaryDark,
                  height: 1.45,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              if (authState.isAuthenticated) ...[
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.account_circle_rounded,
                        color: AppColors.primary,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Signed in as ${authState.user?.username ?? "Puter User"}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                            const Text(
                              'Personal Puter account active',
                              style: TextStyle(
                                color: AppColors.textMutedDark,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          HapticHelper.mediumImpact();
                          await ref.read(authProvider.notifier).signOut();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Signed out successfully.'),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Sign Out',
                          style: TextStyle(
                            color: AppColors.error,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Error display
              if (authState.errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.error.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.error,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          authState.errorMessage == '[object Object]'
                              ? 'Puter authentication was canceled or requires login.'
                              : authState.errorMessage!,
                          style: const TextStyle(
                            color: AppColors.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Card: How Puter Works
              GlassCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _FeatureRow(
                      icon: Icons.check_circle_outline,
                      title: '100% Free Monthly Quota',
                      description:
                          'Every Puter account comes with free monthly AI tokens.',
                    ),
                    const Divider(height: 20, color: AppColors.darkBorder),
                    _FeatureRow(
                      icon: Icons.lock_outline,
                      title: 'Strict User-Pays Sovereignty',
                      description:
                          'FoodLens never uses shared developer keys or stores billing details.',
                    ),
                    const Divider(height: 20, color: AppColors.darkBorder),
                    _FeatureRow(
                      icon: Icons.auto_awesome_outlined,
                      title: 'Multimodal GPT-4o & Vision',
                      description:
                          'Access state-of-the-art vision models directly from your personal account.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Action 1: Official Puter Authorization (Account Select / Login / Register)
              CustomButton(
                text: 'Sign In with Puter',
                icon: Icons.login_rounded,
                isLoading: authState.isLoading && !_showTokenField,
                gradient: const LinearGradient(
                  colors: [Color(0xFF0055FF), Color(0xFF0038A8)],
                ),
                onPressed: _handleOfficialSignIn,
              ),
              const SizedBox(height: 12),

              // Create a new Puter account in the device default browser.
              CustomButton(
                text: 'Sign Up with Puter',
                isSecondary: true,
                icon: Icons.person_add_alt_1_rounded,
                onPressed: _handleOfficialSignUp,
              ),
              const SizedBox(height: 12),

              // Action 3: Continue as Guest / Offline
              TextButton.icon(
                onPressed: () {
                  HapticHelper.lightImpact();
                  context.go('/home');
                },
                icon: const Icon(
                  Icons.explore_outlined,
                  size: 16,
                  color: AppColors.primaryLight,
                ),
                label: const Text(
                  'Continue as Guest (Explore App Offline)',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Action 4: Token field toggle
              TextButton.icon(
                onPressed: () {
                  setState(() => _showTokenField = !_showTokenField);
                  HapticHelper.lightImpact();
                },
                icon: Icon(
                  _showTokenField
                      ? Icons.keyboard_arrow_up
                      : Icons.key_outlined,
                  size: 16,
                  color: AppColors.textMutedDark,
                ),
                label: Text(
                  _showTokenField
                      ? 'Hide Token Login'
                      : 'Sign in using Puter API Token',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMutedDark,
                  ),
                ),
              ),

              if (_showTokenField) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.darkSurfaceCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.darkBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Puter Account Token',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: _pasteToken,
                                child: const Text(
                                  'Paste',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.primaryLight,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: () => _launchExternalBrowser(
                                  AppConstants.puterDashboardUrl,
                                ),
                                child: const Text(
                                  'Get Token ↗',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.secondaryLight,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _tokenController,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontFamily: 'monospace',
                        ),
                        decoration: InputDecoration(
                          hintText: 'Paste token from puter.com/dashboard',
                          hintStyle: const TextStyle(
                            color: AppColors.textMutedDark,
                            fontSize: 12,
                          ),
                          filled: true,
                          fillColor: AppColors.darkBackground,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColors.darkBorder,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColors.darkBorder,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomButton(
                        text: 'Connect with Token',
                        height: 44,
                        isLoading: authState.isLoading && _showTokenField,
                        onPressed: _handleTokenSignIn,
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondaryDark,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
