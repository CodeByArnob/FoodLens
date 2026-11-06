import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../settings/providers/settings_provider.dart';
import '../../scanner/providers/scanner_provider.dart';
import '../../scanner/services/scanner_service.dart';
import '../../scanner/models/menu_analysis_result.dart';

class MenuExplorerScreen extends ConsumerWidget {
  const MenuExplorerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final currencySymbol = settings.currencySymbol;

    final sampleMenus = [
      MenuAnalysisResult(
        restaurantName: 'Osteria Del Sole',
        cuisineType: 'Authentic Italian',
        currency: currencySymbol,
        dishes: [
          MenuItemDish(
            id: 'm1',
            name: 'Penne all\'Arrabbiata',
            description: 'San Marzano tomatoes, garlic, extra virgin olive oil, fresh chili',
            priceRaw: '$currencySymbol 14.50',
            priceValue: 14.50,
            estimatedCalories: 480,
            protein: 14.0,
            carbs: 72.0,
            fat: 12.0,
            dietaryTags: ['Vegetarian', 'Vegan'],
            healthRating: 'A',
          ),
          MenuItemDish(
            id: 'm2',
            name: 'Grilled Branzino with Herbs',
            description: 'Fresh sea bass, charred lemon, wild oregano, roasted zucchini',
            priceRaw: '$currencySymbol 26.00',
            priceValue: 26.00,
            estimatedCalories: 380,
            protein: 42.0,
            carbs: 6.0,
            fat: 16.0,
            dietaryTags: ['High-Protein', 'Keto', 'Gluten-Free'],
            healthRating: 'A+',
          ),
          MenuItemDish(
            id: 'm3',
            name: 'Tiramisu Tradizionale',
            description: 'Espresso-soaked savoiardi, mascarpone cream, dark cocoa dust',
            priceRaw: '$currencySymbol 9.00',
            priceValue: 9.00,
            estimatedCalories: 420,
            protein: 7.0,
            carbs: 48.0,
            fat: 22.0,
            dietaryTags: ['Vegetarian'],
            healthRating: 'C',
          ),
        ],
      ),
      MenuAnalysisResult(
        restaurantName: 'Kyoto Zen Garden',
        cuisineType: 'Japanese Izakaya & Sushi',
        currency: currencySymbol,
        dishes: [
          MenuItemDish(
            id: 'k1',
            name: 'Salmon & Avocado Chirashi Bowl',
            description: 'Sashimi-grade salmon, Haas avocado, nori, seasoned brown rice',
            priceRaw: '$currencySymbol 18.50',
            priceValue: 18.50,
            estimatedCalories: 510,
            protein: 34.0,
            carbs: 52.0,
            fat: 18.0,
            dietaryTags: ['Pescatarian', 'Dairy-Free'],
            healthRating: 'A',
          ),
          MenuItemDish(
            id: 'k2',
            name: 'Steamed Edamame with Sea Salt',
            description: 'Young organic soybeans in pods with Maldon sea salt',
            priceRaw: '$currencySymbol 6.50',
            priceValue: 6.50,
            estimatedCalories: 140,
            protein: 12.0,
            carbs: 10.0,
            fat: 4.0,
            dietaryTags: ['Vegan', 'Gluten-Free', 'High-Protein'],
            healthRating: 'A+',
          ),
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Restaurant Menu Explorer'),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Scan Camera Action Card
            GlassCard(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                    ),
                    child: const Icon(Icons.document_scanner_rounded, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Scan a Physical Menu',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Point at any paper menu or wine list to extract dishes & nutritional estimates.',
                          style: TextStyle(fontSize: 11, color: AppColors.textMutedDark),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Scan Restaurant Menu with Camera',
              icon: Icons.camera_alt_rounded,
              onPressed: () async {
                HapticHelper.mediumImpact();
                ref.read(scannerProvider.notifier).setMode(ScanMode.menu);
                final success = await ref.read(scannerProvider.notifier).captureAndScan(ImageSource.camera);
                if (success && context.mounted) {
                  context.push('/menu-analysis');
                }
              },
            ),
            const SizedBox(height: 24),

            const Text(
              'Curated Menus & OCR Demos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 12),

            ...sampleMenus.map((menu) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: GlassCard(
                  padding: const EdgeInsets.all(16),
                  onTap: () {
                    HapticHelper.lightImpact();
                    context.push('/menu-analysis', extra: menu);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              menu.restaurantName,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${menu.dishes.length} Dishes',
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primaryLight),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        menu.cuisineType,
                        style: const TextStyle(fontSize: 12, color: AppColors.textMutedDark),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Directionality.of(context) == TextDirection.rtl
                                ? Icons.arrow_back_rounded
                                : Icons.arrow_forward_rounded,
                            color: AppColors.primaryLight,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'Explore full menu & nutrition breakdown',
                            style: TextStyle(fontSize: 12, color: AppColors.primaryLight, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
