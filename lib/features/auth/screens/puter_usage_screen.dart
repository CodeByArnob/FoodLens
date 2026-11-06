import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/glass_card.dart';
import '../providers/auth_provider.dart';

class PuterUsageScreen extends ConsumerStatefulWidget {
  const PuterUsageScreen({super.key});

  @override
  ConsumerState<PuterUsageScreen> createState() => _PuterUsageScreenState();
}

class _PuterUsageScreenState extends ConsumerState<PuterUsageScreen> {
  bool _isRefreshing = false;

  Future<void> _refresh() async {
    HapticHelper.lightImpact();
    setState(() => _isRefreshing = true);
    await ref.read(authProvider.notifier).refreshUsage();
    if (mounted) setState(() => _isRefreshing = false);
  }

  Future<void> _launchAccountUrl() async {
    HapticHelper.mediumImpact();
    final uri = Uri.parse(AppConstants.puterAccountUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final usage = authState.usage;
    final user = authState.user;

    final percent = usage?.percentUsed ?? 0.125;
    final isExhausted =
        authState.hasExhaustedAllowance ||
        (usage?.hasExhaustedAllowance ?? false);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Puter Usage & Allowance'),
        actions: [
          IconButton(
            icon: _isRefreshing
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.refresh_rounded),
            onPressed: _isRefreshing ? null : _refresh,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // User Card
            GlassCard(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0055FF), Color(0xFF00B4D8)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.puterBlue.withValues(alpha: 0.35),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.username ?? 'Puter Connected User',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          user?.uuid != null
                              ? 'UUID: ${user!.uuid!.substring(0, 8)}...'
                              : 'Puter.js User-Pays Mode',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMutedDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isExhausted
                          ? AppColors.error.withValues(alpha: 0.15)
                          : AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isExhausted
                            ? AppColors.error.withValues(alpha: 0.4)
                            : AppColors.primary.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      isExhausted ? 'EXHAUSTED' : 'ACTIVE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: isExhausted
                            ? AppColors.error
                            : AppColors.primaryLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Allowance Gauge Card
            GlassCard(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Monthly AI Compute Quota',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${(percent * 100).toStringAsFixed(1)}% Used',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isExhausted
                              ? AppColors.error
                              : AppColors.primaryLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: percent,
                      minHeight: 12,
                      backgroundColor: AppColors.darkSurfaceHighlight,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isExhausted
                            ? AppColors.error
                            : percent > 0.8
                            ? AppColors.warning
                            : AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _AllowanceMetricBox(
                          label: 'Remaining',
                          value: usage?.remainingCreditsFormatted ?? '\$8.75',
                          color: isExhausted
                              ? AppColors.error
                              : AppColors.primaryLight,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _AllowanceMetricBox(
                          label: 'Consumed',
                          value: usage?.usedCreditsFormatted ?? '\$1.25',
                          color: AppColors.secondaryLight,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _AllowanceMetricBox(
                          label: 'Total Free Limit',
                          value: usage?.totalCreditsFormatted ?? '\$10.00',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // User-Pays Billing Explanation
            GlassCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.verified_user_outlined,
                        color: AppColors.puterBlue,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'About Puter User-Pays Model',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Puter provides every user with a free monthly allowance for AI vision queries, OCR, and storage. FoodLens connects directly to your Puter cloud without intermediary markup or developer API keys.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryDark,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'When your free monthly allowance runs out, you can purchase additional microcredits or subscribe on Puter.com to continue uninterrupted.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryDark,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Top up action button
            CustomButton(
              text: 'Manage Allowance & Add Credits',
              icon: Icons.open_in_new_rounded,
              gradient: const LinearGradient(
                colors: [Color(0xFF0055FF), Color(0xFF0038A8)],
              ),
              onPressed: _launchAccountUrl,
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Sign Out of Puter',
              isSecondary: true,
              icon: Icons.logout_rounded,
              onPressed: () async {
                HapticHelper.mediumImpact();
                await ref.read(authProvider.notifier).signOut();
                if (context.mounted) context.go('/auth');
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _AllowanceMetricBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _AllowanceMetricBox({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textMutedDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
