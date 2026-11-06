import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import 'custom_button.dart';
import 'glass_card.dart';

class PuterUpgradeModal extends StatelessWidget {
  final String? message;
  final String upgradeUrl;

  const PuterUpgradeModal({
    super.key,
    this.message,
    this.upgradeUrl = AppConstants.puterAccountUrl,
  });

  static void show(
    BuildContext context, {
    String? message,
    String? upgradeUrl,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => PuterUpgradeModal(
        message: message,
        upgradeUrl: upgradeUrl ?? AppConstants.puterAccountUrl,
      ),
    );
  }

  Future<void> _launchUpgradeUrl() async {
    final uri = Uri.parse(upgradeUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.darkSurfaceHighlight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          // Puter Icon Badge
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.puterBlue.withValues(alpha: 0.15),
              border: Border.all(color: AppColors.puterBlue, width: 2),
            ),
            child: const Icon(
              Icons.account_balance_wallet_outlined,
              color: AppColors.puterBlue,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Puter Allowance Exhausted',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimaryDark,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message ??
                'Your free monthly Puter AI compute allowance has reached its limit. Under Puter\'s User-Pays model, you can add credits or upgrade your plan directly via your official Puter account.',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondaryDark,
              height: 1.45,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          GlassCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                const Icon(
                  Icons.shield_outlined,
                  color: AppColors.primary,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Decentralized & Direct',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '100% of payments go directly to your personal Puter account. FoodLens never stores payment credentials.',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textMutedDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Manage Puter Credits & Upgrade',
            icon: Icons.open_in_new,
            onPressed: () {
              Navigator.pop(context);
              _launchUpgradeUrl();
            },
          ),
          const SizedBox(height: 12),
          CustomButton(
            text: 'Continue in Offline / Demo Mode',
            isSecondary: true,
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
