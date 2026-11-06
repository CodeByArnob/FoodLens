import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/food_image_view.dart';
import '../providers/food_comparison_provider.dart';
import '../../history_favorites/providers/history_favorites_provider.dart';

class FoodComparisonScreen extends ConsumerWidget {
  const FoodComparisonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comparisonState = ref.watch(foodComparisonProvider);
    final comparisonNotifier = ref.read(foodComparisonProvider.notifier);
    final historyState = ref.watch(historyFavoritesProvider);

    final foodA = comparisonState.foodA;
    final foodB = comparisonState.foodB;
    final result = comparisonState.result;

    void pickFood(bool isFoodA) {
      showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.darkSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (ctx) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select ${isFoodA ? 'First' : 'Second'} Dish',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: historyState.history.length,
                  separatorBuilder: (context, index) =>
                      const Divider(color: AppColors.darkBorder),
                  itemBuilder: (context, idx) {
                    final item = historyState.history[idx];
                    return ListTile(
                      leading: FoodImageView(
                        imagePath: item.imagePath,
                        foodName: item.foodName,
                        width: 40,
                        height: 40,
                        borderRadius: 8,
                      ),
                      title: Text(
                        item.foodName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        '${item.calories} kcal • ${item.cuisine}',
                        style: const TextStyle(color: AppColors.textMutedDark),
                      ),
                      onTap: () {
                        HapticHelper.lightImpact();
                        if (isFoodA) {
                          comparisonNotifier.selectFoodA(item);
                        } else {
                          comparisonNotifier.selectFoodB(item);
                        }
                        Navigator.pop(ctx);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Food Comparison'),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            // Side-by-side Selectors
            Row(
              children: [
                Expanded(
                  child: _FoodSelectorCard(
                    label: 'Dish 1',
                    foodName: foodA?.foodName ?? 'Select Dish',
                    calories: foodA?.calories,
                    onTap: () => pickFood(true),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.darkSurfaceHighlight,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    'VS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _FoodSelectorCard(
                    label: 'Dish 2',
                    foodName: foodB?.foodName ?? 'Select Dish',
                    calories: foodB?.calories,
                    onTap: () => pickFood(false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Compare Button
            CustomButton(
              text: 'Run AI Comparison',
              icon: Icons.auto_awesome,
              isLoading: comparisonState.isComparing,
              onPressed: comparisonState.canCompare
                  ? () => comparisonNotifier.runComparison()
                  : null,
            ),
            const SizedBox(height: 20),

            // Comparison Metrics Table (if both selected)
            if (foodA != null && foodB != null) ...[
              GlassCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    _ComparisonHeader(
                      foodAName: foodA.foodName,
                      foodBName: foodB.foodName,
                    ),
                    const Divider(color: AppColors.darkBorder, height: 24),
                    _MetricCompareRow(
                      label: 'Calories',
                      valA: '${foodA.calories} kcal',
                      valB: '${foodB.calories} kcal',
                      isBetterA: foodA.calories < foodB.calories,
                    ),
                    _MetricCompareRow(
                      label: 'Protein',
                      valA: '${foodA.protein.toStringAsFixed(1)}g',
                      valB: '${foodB.protein.toStringAsFixed(1)}g',
                      isBetterA: foodA.protein > foodB.protein,
                    ),
                    _MetricCompareRow(
                      label: 'Carbohydrates',
                      valA: '${foodA.carbohydrates.toStringAsFixed(1)}g',
                      valB: '${foodB.carbohydrates.toStringAsFixed(1)}g',
                      isBetterA: foodA.carbohydrates < foodB.carbohydrates,
                    ),
                    _MetricCompareRow(
                      label: 'Fat',
                      valA: '${foodA.fat.toStringAsFixed(1)}g',
                      valB: '${foodB.fat.toStringAsFixed(1)}g',
                      isBetterA: foodA.fat < foodB.fat,
                    ),
                    _MetricCompareRow(
                      label: 'Fiber',
                      valA: '${foodA.fiber.toStringAsFixed(1)}g',
                      valB: '${foodB.fiber.toStringAsFixed(1)}g',
                      isBetterA: foodA.fiber > foodB.fiber,
                    ),
                    _MetricCompareRow(
                      label: 'Health Score',
                      valA: '${foodA.healthScore} / 100',
                      valB: '${foodB.healthScore} / 100',
                      isBetterA: foodA.healthScore > foodB.healthScore,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],

            // AI Verdict Card (if run)
            if (result != null) ...[
              GlassCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.emoji_events_rounded,
                          color: AppColors.tertiary,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'AI Verdict: ${result.winner} Wins',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      result.verdictSummary,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondaryDark,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Goal-Specific Recommendations:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...result.recommendationByGoal.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.primary,
                              size: 14,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${entry.key}: ',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                entry.value,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primaryLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }
}

class _FoodSelectorCard extends StatelessWidget {
  final String label;
  final String foodName;
  final int? calories;
  final VoidCallback onTap;

  const _FoodSelectorCard({
    required this.label,
    required this.foodName,
    this.calories,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      onTap: () {
        HapticHelper.lightImpact();
        onTap();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textMutedDark,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          if (calories != null) ...[
            FoodImageView(
              foodName: foodName,
              height: 52,
              width: double.infinity,
              borderRadius: 8,
            ),
            const SizedBox(height: 6),
          ],
          Text(
            foodName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            calories != null ? '$calories kcal' : 'Tap to choose',
            style: TextStyle(
              fontSize: 11,
              color: calories != null
                  ? AppColors.primaryLight
                  : AppColors.secondaryLight,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonHeader extends StatelessWidget {
  final String foodAName;
  final String foodBName;

  const _ComparisonHeader({required this.foodAName, required this.foodBName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'METRIC',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.textMutedDark,
            ),
          ),
        ),
        Expanded(
          child: Text(
            foodAName,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryLight,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Text(
            foodBName,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppColors.secondaryLight,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _MetricCompareRow extends StatelessWidget {
  final String label;
  final String valA;
  final String valB;
  final bool isBetterA;

  const _MetricCompareRow({
    required this.label,
    required this.valA,
    required this.valB,
    required this.isBetterA,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryDark,
              ),
            ),
          ),
          Expanded(
            child: Text(
              valA,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isBetterA ? FontWeight.w800 : FontWeight.w500,
                color: isBetterA ? Colors.white : AppColors.textMutedDark,
              ),
            ),
          ),
          Expanded(
            child: Text(
              valB,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: !isBetterA ? FontWeight.w800 : FontWeight.w500,
                color: !isBetterA ? Colors.white : AppColors.textMutedDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
