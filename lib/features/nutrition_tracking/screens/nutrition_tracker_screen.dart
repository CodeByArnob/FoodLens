import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' hide TextDirection;
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/calorie_gauge.dart';
import '../providers/nutrition_tracker_provider.dart';
import '../models/meal_log_item.dart';
import '../../settings/providers/settings_provider.dart';

class NutritionTrackerScreen extends ConsumerWidget {
  const NutritionTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackerState = ref.watch(nutritionTrackerProvider);
    final trackerNotifier = ref.read(nutritionTrackerProvider.notifier);
    final settings = ref.watch(settingsProvider);
    final todayLog = trackerState.todayLog;

    final targetCalories = settings.dailyCalorieTarget;
    final targetProtein = 130.0;
    final targetCarbs = 220.0;
    final targetFat = 65.0;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Daily Nutrition Tracker'),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Selector Bar
            _DateSelectorRow(
              selectedDate: trackerState.selectedDate,
              onSelectDate: (d) => trackerNotifier.selectDate(d),
            ),
            const SizedBox(height: 18),

            // Hero Gauge Card
            GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CalorieGauge(
                    consumedCalories: todayLog.totalCalories,
                    targetCalories: targetCalories,
                    size: 160,
                  ),
                  const SizedBox(height: 18),
                  // Macro Linear Bars
                  _MacroProgressBar(
                    label: 'Protein',
                    current: todayLog.totalProtein,
                    target: targetProtein,
                    color: AppColors.protein,
                  ),
                  const SizedBox(height: 10),
                  _MacroProgressBar(
                    label: 'Carbohydrates',
                    current: todayLog.totalCarbs,
                    target: targetCarbs,
                    color: AppColors.carbs,
                  ),
                  const SizedBox(height: 10),
                  _MacroProgressBar(
                    label: 'Fat',
                    current: todayLog.totalFat,
                    target: targetFat,
                    color: AppColors.fat,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Water Intake Card
            GlassCard(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.water_drop_rounded,
                      color: AppColors.secondary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Water Hydration',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${todayLog.waterIntakeMl} ml / 2500 ml Goal',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMutedDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          HapticHelper.lightImpact();
                          trackerNotifier.addWater(250);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: AppColors.secondaryLight,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.secondary.withValues(
                            alpha: 0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // Meal Categories List
            const Text(
              'Logged Meals',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),

            _MealSection(
              title: 'Breakfast',
              meals: todayLog.breakfastMeals,
              icon: Icons.wb_sunny_outlined,
              onAddTap: () => context.push('/scanner'),
              onDelete: (id) => trackerNotifier.removeMealItem(id),
            ),
            const SizedBox(height: 12),
            _MealSection(
              title: 'Lunch',
              meals: todayLog.lunchMeals,
              icon: Icons.restaurant_rounded,
              onAddTap: () => context.push('/scanner'),
              onDelete: (id) => trackerNotifier.removeMealItem(id),
            ),
            const SizedBox(height: 12),
            _MealSection(
              title: 'Dinner',
              meals: todayLog.dinnerMeals,
              icon: Icons.nights_stay_outlined,
              onAddTap: () => context.push('/scanner'),
              onDelete: (id) => trackerNotifier.removeMealItem(id),
            ),
            const SizedBox(height: 12),
            _MealSection(
              title: 'Snacks',
              meals: todayLog.snackMeals,
              icon: Icons.cookie_outlined,
              onAddTap: () => context.push('/scanner'),
              onDelete: (id) => trackerNotifier.removeMealItem(id),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _DateSelectorRow extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelectDate;

  const _DateSelectorRow({
    required this.selectedDate,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            isRtl ? Icons.chevron_right : Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () {
            HapticHelper.lightImpact();
            onSelectDate(selectedDate.subtract(const Duration(days: 1)));
          },
        ),
        Text(
          DateFormat('EEEE, MMM d').format(selectedDate),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        IconButton(
          icon: Icon(
            isRtl ? Icons.chevron_left : Icons.chevron_right,
            color: Colors.white,
          ),
          onPressed: () {
            HapticHelper.lightImpact();
            onSelectDate(selectedDate.add(const Duration(days: 1)));
          },
        ),
      ],
    );
  }
}

class _MacroProgressBar extends StatelessWidget {
  final String label;
  final double current;
  final double target;
  final Color color;

  const _MacroProgressBar({
    required this.label,
    required this.current,
    required this.target,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final percent = target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondaryDark,
              ),
            ),
            Text(
              '${current.toStringAsFixed(1)} / ${target.toStringAsFixed(0)}g',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: 6,
            backgroundColor: AppColors.darkSurfaceHighlight,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

class _MealSection extends StatelessWidget {
  final String title;
  final List<MealLogItem> meals;
  final IconData icon;
  final VoidCallback onAddTap;
  final ValueChanged<String> onDelete;

  const _MealSection({
    required this.title,
    required this.meals,
    required this.icon,
    required this.onAddTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final int sectionCalories = meals.fold(0, (sum, m) => sum + m.calories);

    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 18, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '$sectionCalories kcal',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryLight,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      size: 18,
                      color: AppColors.primaryLight,
                    ),
                    onPressed: onAddTap,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
          if (meals.isNotEmpty) ...[
            const Divider(color: AppColors.darkBorder, height: 16),
            ...meals.map((m) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        m.foodName,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      '${m.calories} kcal',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMutedDark,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 14,
                        color: AppColors.textMutedDark,
                      ),
                      onPressed: () => onDelete(m.id),
                      padding: const EdgeInsets.only(left: 8),
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}
