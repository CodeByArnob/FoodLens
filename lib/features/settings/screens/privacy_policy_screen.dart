import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/glass_card.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Privacy & Food Sovereignty',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Effective Date: November 2026 • FoodLens Platform',
              style: TextStyle(fontSize: 11, color: AppColors.textMutedDark),
            ),
            const SizedBox(height: 16),
            GlassCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '1. Decentralized Architecture',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'FoodLens connects directly to Puter.js using a sandboxed browser bridge. We do not store your credentials on any proprietary FoodLens server. All authentication tokens and storage remain under your own Puter account identity.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryDark,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    '2. Image & Photo Processing',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Food photos captured via your camera or chosen from your gallery are encoded on-device and transmitted over encrypted HTTPS to Puter AI multimodal inference models. They are never indexed or sold for advertising.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryDark,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    '3. Local Device Storage',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Your scan history, dietary filters, and meal logs are stored locally on your Android device. You can erase all data at any time via Settings.',
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
          ],
        ),
      ),
    );
  }
}
