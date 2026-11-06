import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/puter_upgrade_modal.dart';
import '../../../shared/widgets/food_image_view.dart';
import '../providers/meal_planner_provider.dart';
import '../models/meal_plan.dart';
import '../../nutrition_tracking/providers/nutrition_tracker_provider.dart';
import '../../nutrition_tracking/models/meal_log_item.dart';
import '../../scanner/models/food_analysis_result.dart';

class MealPlannerScreen extends ConsumerWidget {
  const MealPlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planState = ref.watch(mealPlannerProvider);
    final planNotifier = ref.read(mealPlannerProvider.notifier);
    final currentPlan = planState.currentPlan;

    Future<void> handleGenerate() async {
      HapticHelper.mediumImpact();
      final success = await planNotifier.generateNewPlan();
      if (!success && planState.errorMessage != null && context.mounted) {
        if (planState.errorMessage!.contains('insufficient_funds')) {
          PuterUpgradeModal.show(context, message: planState.errorMessage);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(planState.errorMessage!), backgroundColor: AppColors.error),
          );
        }
      }
    }

    void logMealToTracker(PlannedMeal meal) {
      HapticHelper.lightImpact();
      MealType type = MealType.lunch;
      final mTypeLower = meal.mealType.toLowerCase();
      if (mTypeLower.contains('break')) type = MealType.breakfast;
      if (mTypeLower.contains('din')) type = MealType.dinner;
      if (mTypeLower.contains('snack')) type = MealType.snack;

      final food = FoodAnalysisResult(
        foodName: meal.dishName,
        calories: meal.calories,
        protein: meal.protein,
        carbohydrates: meal.carbs,
        fat: meal.fat,
        portionSize: meal.portion,
        ingredients: meal.ingredients,
        disclaimer: 'Generated from Puter AI Meal Plan.',
      );

      ref.read(nutritionTrackerProvider.notifier).logFoodItem(food, type);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logged ${meal.dishName} to ${type.name}!'),
          backgroundColor: AppColors.primaryDark,
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('AI Meal Planner'),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Controls Card
            GlassCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Target Calories',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      Text(
                        '${planState.targetCalories} kcal',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primaryLight),
                      ),
                    ],
                  ),
                  Slider(
                    value: planState.targetCalories.toDouble(),
                    min: 1200,
                    max: 3800,
                    divisions: 26,
                    activeColor: AppColors.primary,
                    inactiveColor: AppColors.darkSurfaceHighlight,
                    onChanged: (val) {
                      planNotifier.updateTargetCalories(val.round());
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text('Diet Style', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textMutedDark)),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ['Balanced', 'High-Protein', 'Keto', 'Vegan', 'Mediterranean'].map((diet) {
                        final isSel = planState.selectedDiet == diet;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(diet),
                            selected: isSel,
                            onSelected: (_) {
                              HapticHelper.selectionClick();
                              planNotifier.updateSelectedDiet(diet);
                            },
                            selectedColor: AppColors.primary,
                            labelStyle: TextStyle(
                              fontSize: 11,
                              fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                              color: isSel ? Colors.white : AppColors.textSecondaryDark,
                            ),
                            backgroundColor: AppColors.darkSurfaceCard,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Generate Personalized Plan',
                    icon: Icons.auto_awesome,
                    isLoading: planState.isGenerating,
                    onPressed: handleGenerate,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Generated Plan Section
            if (currentPlan != null) ...[
              Text(
                currentPlan.planTitle,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                'Total: ${currentPlan.totalCalories} kcal | Protein: ${currentPlan.totalProtein.toStringAsFixed(0)}g | Carbs: ${currentPlan.totalCarbs.toStringAsFixed(0)}g | Fat: ${currentPlan.totalFat.toStringAsFixed(0)}g',
                style: const TextStyle(fontSize: 12, color: AppColors.primaryLight, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 14),

              ...currentPlan.meals.map((meal) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                meal.mealType.toUpperCase(),
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.primaryLight),
                              ),
                            ),
                            Text(
                              '${meal.calories} kcal',
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FoodImageView(
                              foodName: meal.dishName,
                              width: 60,
                              height: 60,
                              borderRadius: 12,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    meal.dishName,
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Portion: ${meal.portion} • Prep: ${meal.prepTimeMinutes} mins',
                                    style: const TextStyle(fontSize: 11, color: AppColors.textMutedDark),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (meal.ingredients.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Ingredients: ${meal.ingredients.join(', ')}',
                            style: const TextStyle(fontSize: 11, color: AppColors.textSecondaryDark),
                          ),
                        ],
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'P: ${meal.protein}g | C: ${meal.carbs}g | F: ${meal.fat}g',
                              style: const TextStyle(fontSize: 11, color: AppColors.textMutedDark),
                            ),
                            TextButton.icon(
                              onPressed: () => logMealToTracker(meal),
                              icon: const Icon(Icons.add, size: 14, color: AppColors.primaryLight),
                              label: const Text('Log Dish', style: TextStyle(fontSize: 11, color: AppColors.primaryLight)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
              if (currentPlan.nutritionalSummary.isNotEmpty)
                GlassCard(
                  padding: const EdgeInsets.all(14),
                  child: Text(
                    currentPlan.nutritionalSummary,
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondaryDark, height: 1.45),
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
