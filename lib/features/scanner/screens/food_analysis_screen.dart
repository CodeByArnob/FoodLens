import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/health_score_indicator.dart';
import '../../../shared/widgets/nutrient_badge.dart';
import '../../../shared/widgets/disclaimer_banner.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/food_image_view.dart';
import '../models/food_analysis_result.dart';
import '../providers/scanner_provider.dart';
import '../../nutrition_tracking/models/meal_log_item.dart';
import '../../nutrition_tracking/providers/nutrition_tracker_provider.dart';
import '../../history_favorites/providers/history_favorites_provider.dart';
import '../../comparison/providers/food_comparison_provider.dart';

class FoodAnalysisScreen extends ConsumerWidget {
  final FoodAnalysisResult? passedResult;

  const FoodAnalysisScreen({super.key, this.passedResult});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scannerState = ref.watch(scannerProvider);
    final historyState = ref.watch(historyFavoritesProvider);
    final historyNotifier = ref.read(historyFavoritesProvider.notifier);

    // Prefer passedResult or lastFoodResult from scanner
    final FoodAnalysisResult? item = passedResult ?? scannerState.lastFoodResult;

    if (item == null) {
      return Scaffold(
        backgroundColor: AppColors.darkBackground,
        appBar: AppBar(title: const Text('Analysis Result')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline_rounded, size: 48, color: AppColors.textMutedDark),
              const SizedBox(height: 12),
              const Text('No scan data available.', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Back to Scanner',
                width: 200,
                onPressed: () => context.pop(),
              ),
            ],
          ),
        ),
      );
    }

    final isFav = historyState.favorites.any((f) => f.id == item.id || f.foodName == item.foodName);

    void showLogMealSheet() {
      HapticHelper.mediumImpact();
      showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.darkSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (ctx) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Log to Today\'s Meals',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
              ),
              const SizedBox(height: 16),
              ...MealType.values.map((type) {
                return ListTile(
                  title: Text(
                    type.name.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  trailing: const Icon(Icons.add_circle_outline_rounded, color: AppColors.primary),
                  onTap: () async {
                    HapticHelper.lightImpact();
                    await ref.read(nutritionTrackerProvider.notifier).logFoodItem(item, type);
                    if (ctx.mounted) Navigator.pop(ctx);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Logged ${item.foodName} to ${type.name}!'),
                          backgroundColor: AppColors.primaryDark,
                        ),
                      );
                    }
                  },
                );
              }),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: CustomScrollView(
        slivers: [
          // Collapsible Image Hero App Bar
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: AppColors.darkSurface,
            leading: const BackButton(color: Colors.white),
            actions: [
              IconButton(
                icon: Icon(
                  isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: isFav ? AppColors.accentRose : Colors.white,
                ),
                onPressed: () {
                  HapticHelper.lightImpact();
                  historyNotifier.toggleFavorite(item);
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  FoodImageView(
                    imagePath: item.imagePath,
                    foodName: item.foodName,
                    height: 250,
                    borderRadius: 0,
                    fit: BoxFit.cover,
                  ),
                  // Dark gradient overlay
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, AppColors.darkBackground],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Body Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Cuisine Tag
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.foodName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${item.cuisine} • ${item.portionSize}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textMutedDark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Calorie Highlight Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '${item.calories}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: AppColors.primaryLight,
                                height: 1.1,
                              ),
                            ),
                            const Text(
                              'KCAL',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Health Score & Verified Distinction
                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: HealthScoreIndicator(
                      score: item.healthScore,
                      confidenceScore: item.confidenceScore,
                      isVerified: item.isVerifiedLabel,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Macronutrients Grid
                  const Text(
                    'Macronutrients Breakdown',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: NutrientBadge(
                          label: 'PROTEIN',
                          value: '${item.protein.toStringAsFixed(1)}g',
                          color: AppColors.protein,
                          icon: Icons.fitness_center_rounded,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: NutrientBadge(
                          label: 'CARBS',
                          value: '${item.carbohydrates.toStringAsFixed(1)}g',
                          color: AppColors.carbs,
                          icon: Icons.grain_rounded,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: NutrientBadge(
                          label: 'FAT',
                          value: '${item.fat.toStringAsFixed(1)}g',
                          color: AppColors.fat,
                          icon: Icons.opacity_rounded,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: NutrientBadge(
                          label: 'FIBER',
                          value: '${item.fiber.toStringAsFixed(1)}g',
                          color: AppColors.fiber,
                          icon: Icons.eco_rounded,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Micronutrients Table
                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Micronutrients & Electrolytes',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        const SizedBox(height: 12),
                        _NutrientDetailRow('Sugar', '${item.sugar.toStringAsFixed(1)} g'),
                        _NutrientDetailRow('Saturated Fat', '${item.saturatedFat.toStringAsFixed(1)} g'),
                        _NutrientDetailRow('Sodium', '${item.sodium.toStringAsFixed(0)} mg'),
                        _NutrientDetailRow('Potassium', '${item.potassium.toStringAsFixed(0)} mg'),
                        _NutrientDetailRow('Calcium', '${item.calcium.toStringAsFixed(0)} mg'),
                        _NutrientDetailRow('Iron', '${item.iron.toStringAsFixed(1)} mg'),
                        _NutrientDetailRow('Vitamin C', '${item.vitaminC.toStringAsFixed(1)} mg'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Detected Ingredients
                  if (item.ingredients.isNotEmpty) ...[
                    const Text(
                      'Detected Ingredients',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: item.ingredients.map((ing) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.darkSurfaceCard,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.darkBorder),
                          ),
                          child: Text(
                            ing,
                            style: const TextStyle(fontSize: 12, color: AppColors.textSecondaryDark),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 18),
                  ],

                  // Allergen Warnings
                  if (item.allergenWarnings.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Potential Allergen Risk',
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.error),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          ...item.allergenWarnings.map((all) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Text('• $all', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],

                  // Healthier Alternatives
                  if (item.healthierAlternatives.isNotEmpty) ...[
                    const Text(
                      'Smart Healthier Alternatives',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    ...item.healthierAlternatives.map((alt) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: GlassCard(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.swap_horiz_rounded, color: AppColors.primary, size: 22),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      alt.name,
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      alt.reason,
                                      style: const TextStyle(fontSize: 11, color: AppColors.textMutedDark),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${alt.calorieDifference} kcal',
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primaryLight),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 18),
                  ],

                  // Disclaimer Banner
                  DisclaimerBanner(customText: item.disclaimer),
                  const SizedBox(height: 24),

                  // Bottom Action Buttons
                  CustomButton(
                    text: 'Log to Daily Tracker',
                    icon: Icons.add_task_rounded,
                    onPressed: showLogMealSheet,
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: 'Compare with Another Dish',
                    isSecondary: true,
                    icon: Icons.compare_arrows_rounded,
                    onPressed: () {
                      ref.read(foodComparisonProvider.notifier).selectFoodA(item);
                      context.push('/comparison');
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NutrientDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _NutrientDetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondaryDark)),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
        ],
      ),
    );
  }
}
