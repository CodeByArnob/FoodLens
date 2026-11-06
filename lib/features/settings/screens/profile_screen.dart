import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/directional_chevron.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/settings_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final settings = ref.watch(settingsProvider);
    final user = authState.user;
    final usage = authState.usage;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            // User Avatar & Cloud Tag
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: authState.isAuthenticated
                    ? const LinearGradient(
                        colors: [Color(0xFF0055FF), Color(0xFF10B981)],
                      )
                    : const LinearGradient(
                        colors: [Color(0xFF334155), Color(0xFF1E293B)],
                      ),
                boxShadow: [
                  BoxShadow(
                    color: authState.isAuthenticated
                        ? AppColors.primary.withValues(alpha: 0.3)
                        : Colors.black26,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Icon(
                authState.isAuthenticated ? Icons.person : Icons.person_outline_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              authState.isAuthenticated
                  ? (user?.username ?? 'Puter Food Explorer')
                  : 'Not Connected',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: authState.isAuthenticated ? AppColors.primary : AppColors.textMutedDark,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  authState.isAuthenticated
                      ? 'Puter.js Authenticated Cloud'
                      : 'Puter Account Not Connected',
                  style: TextStyle(
                    fontSize: 12,
                    color: authState.isAuthenticated ? AppColors.primaryLight : AppColors.textMutedDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Puter Allowance Card
            GlassCard(
              padding: const EdgeInsets.all(18),
              onTap: () {
                HapticHelper.lightImpact();
                if (authState.isAuthenticated) {
                  context.push('/usage');
                } else {
                  context.push('/auth');
                }
              },
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.puterBlue.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.bolt_rounded, color: AppColors.puterBlue, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Puter AI Allowance',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        Text(
                          authState.isAuthenticated
                              ? (usage != null
                                  ? 'Remaining: ${usage.remainingCreditsFormatted} of ${usage.totalCreditsFormatted}'
                                  : 'Active Personal Puter Account')
                              : 'Tap to connect Puter account for AI scanning',
                          style: const TextStyle(fontSize: 12, color: AppColors.textMutedDark),
                        ),
                      ],
                    ),
                  ),
                  const DirectionalChevron(),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Nutrition Profile Card
            GlassCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Daily Calorie Target',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${settings.dailyCalorieTarget} kcal/day',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primaryLight),
                  ),
                  const Divider(color: AppColors.darkBorder, height: 20),
                  const Text(
                    'Active Dietary Filters',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  if (settings.dietaryFilters.isEmpty)
                    const Text('No dietary filters enabled.', style: TextStyle(fontSize: 12, color: AppColors.textMutedDark))
                  else
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: settings.dietaryFilters.map((f) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            f,
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primaryLight),
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Navigation Links
            _ProfileLinkItem(
              icon: Icons.settings_rounded,
              title: 'Settings & Preferences',
              onTap: () => context.push('/settings'),
            ),
            const SizedBox(height: 10),
            _ProfileLinkItem(
              icon: Icons.info_outline_rounded,
              title: 'About FoodLens (CodeByArnob)',
              onTap: () => context.push('/about'),
            ),
            const SizedBox(height: 10),
            _ProfileLinkItem(
              icon: Icons.help_outline_rounded,
              title: 'Help Center & Documentation',
              onTap: () => context.push('/help'),
            ),
            const SizedBox(height: 10),
            _ProfileLinkItem(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              onTap: () => context.push('/privacy'),
            ),
            const SizedBox(height: 10),
            _ProfileLinkItem(
              icon: Icons.gavel_rounded,
              title: 'Terms of Service',
              onTap: () => context.push('/terms'),
            ),
            const SizedBox(height: 24),

            // Sign Out / Reconnect Button
            CustomButton(
              text: authState.isAuthenticated ? 'Sign Out of Puter' : 'Connect Puter Account',
              isSecondary: true,
              icon: authState.isAuthenticated ? Icons.logout_rounded : Icons.login_rounded,
              onPressed: () async {
                HapticHelper.mediumImpact();
                if (authState.isAuthenticated) {
                  final bool? confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: AppColors.darkSurface,
                      title: const Text('Sign Out', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      content: const Text(
                        'Are you sure you want to sign out and disconnect your Puter account?',
                        style: TextStyle(color: AppColors.textSecondaryDark),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: const Text('Cancel', style: TextStyle(color: AppColors.textMutedDark)),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: const Text('Sign Out', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    await ref.read(authProvider.notifier).signOut();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Successfully signed out of Puter.')),
                      );
                      context.go('/auth');
                    }
                  }
                } else {
                  context.push('/auth');
                }
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _ProfileLinkItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileLinkItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      onTap: () {
        HapticHelper.lightImpact();
        onTap();
      },
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondaryDark),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
          const DirectionalChevron(),
        ],
      ),
    );
  }
}
