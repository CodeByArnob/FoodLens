import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/glass_card.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Terms of Service'),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Terms of Service & Health Disclaimer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
            ),
            const SizedBox(height: 6),
            const Text(
              'FoodLens Global Food Intelligence Platform',
              style: TextStyle(fontSize: 11, color: AppColors.textMutedDark),
            ),
            const SizedBox(height: 16),
            GlassCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '1. Not Medical or Dietary Advice',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'FoodLens provides informational estimates powered by visual artificial intelligence and publicly available nutritional data. Content is not intended to replace certified medical advice, clinical diagnosis, or prescribed dietetic treatments.',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondaryDark, height: 1.5),
                  ),
                  SizedBox(height: 14),
                  Text(
                    '2. Allergen Safety Uncertainty',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Visual AI cannot detect hidden ingredients, trace cross-contamination, cooking oils, or microscopic allergenic particles. Users with severe allergies must independently verify all food with restaurant staff or food packaging.',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondaryDark, height: 1.5),
                  ),
                  SizedBox(height: 14),
                  Text(
                    '3. Puter User-Pays Model',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'AI queries are billed to the user\'s individual Puter cloud allowance. FoodLens does not guarantee continuous free AI access once the official Puter quota is exhausted.',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondaryDark, height: 1.5),
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
