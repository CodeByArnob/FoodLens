import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/haptic_helper.dart';
import 'custom_button.dart';
import 'glass_card.dart';

class PuterAuthRequiredModal extends StatelessWidget {
  final String? message;

  const PuterAuthRequiredModal({super.key, this.message});

  static void show(BuildContext context, {String? message}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => PuterAuthRequiredModal(message: message),
    );
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

          // Puter Cloud Emblem
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.puterBlue.withValues(alpha: 0.15),
              border: Border.all(color: AppColors.puterBlue, width: 2),
            ),
            child: const Icon(
              Icons.cloud_sync_rounded,
              color: AppColors.puterBlue,
              size: 34,
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'Puter Account Required',
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
                'FoodLens utilizes official Puter.js cloud intelligence for vision scanning and nutrition estimation. Please connect or create your free Puter account to continue.',
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondaryDark,
              height: 1.45,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),

          // Trust & Security Card
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
                        '100% Free Monthly Allowance',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Puter accounts include free monthly AI credits. FoodLens never requires developer subscription keys.',
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
          const SizedBox(height: 22),

          // Primary: Connect Puter
          CustomButton(
            text: 'Connect Puter Account',
            icon: Icons.login_rounded,
            onPressed: () {
              HapticHelper.mediumImpact();
              Navigator.pop(context);
              context.push('/auth');
            },
          ),
          const SizedBox(height: 10),

          // Secondary: Cancel
          CustomButton(
            text: 'Cancel',
            isSecondary: true,
            onPressed: () {
              HapticHelper.lightImpact();
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
