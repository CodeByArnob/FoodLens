import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/disclaimer_banner.dart';
import '../../../shared/widgets/food_image_view.dart';
import '../models/menu_analysis_result.dart';
import '../models/food_analysis_result.dart';
import '../providers/scanner_provider.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/services/currency_service.dart';
import '../../settings/providers/settings_provider.dart';

class MenuAnalysisScreen extends ConsumerStatefulWidget {
  final MenuAnalysisResult? passedResult;

  const MenuAnalysisScreen({super.key, this.passedResult});

  @override
  ConsumerState<MenuAnalysisScreen> createState() => _MenuAnalysisScreenState();
}

class _MenuAnalysisScreenState extends ConsumerState<MenuAnalysisScreen> {
  String? _selectedFilter;

  @override
  Widget build(BuildContext context) {
    final scannerState = ref.watch(scannerProvider);
    final settings = ref.watch(settingsProvider);

    final MenuAnalysisResult? menu =
        widget.passedResult ?? scannerState.lastMenuResult;

    if (menu == null) {
      return Scaffold(
        backgroundColor: AppColors.darkBackground,
        appBar: AppBar(title: const Text('Menu Analysis')),
        body: const Center(
          child: Text(
            'No menu data scanned yet.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final filteredDishes = menu.dishes.where((dish) {
      if (_selectedFilter == null) return true;
      if (_selectedFilter == 'Veg') {
        return dish.dietaryTags.any((t) => t.toLowerCase().contains('veg'));
      }
      if (_selectedFilter == 'High Protein') return dish.protein >= 25;
      if (_selectedFilter == 'Low Cal') return dish.estimatedCalories <= 500;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: Text(menu.restaurantName),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Header Card
            GlassCard(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.tertiary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.restaurant_rounded,
                      color: AppColors.tertiary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menu.restaurantName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${menu.cuisineType} • ${menu.dishes.length} Items Detected',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMutedDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Dietary Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChipPill(
                    label: 'All Items (${menu.dishes.length})',
                    isSelected: _selectedFilter == null,
                    onTap: () => setState(() => _selectedFilter = null),
                  ),
                  const SizedBox(width: 8),
                  _FilterChipPill(
                    label: 'Vegetarian',
                    isSelected: _selectedFilter == 'Veg',
                    onTap: () => setState(() => _selectedFilter = 'Veg'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChipPill(
                    label: 'High Protein (25g+)',
                    isSelected: _selectedFilter == 'High Protein',
                    onTap: () =>
                        setState(() => _selectedFilter = 'High Protein'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChipPill(
                    label: 'Low Calorie (<500 kcal)',
                    isSelected: _selectedFilter == 'Low Cal',
                    onTap: () => setState(() => _selectedFilter = 'Low Cal'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Currency Exchange Conversion Notice
            if (settings.currencyCode != 'USD')
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.currency_exchange_rounded,
                      size: 18,
                      color: AppColors.primaryLight,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Live Currency Conversion: ${settings.currencyCode} (${settings.currencySymbol})',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryLight,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Rates via ${CurrencyService.providerName}. Original USD prices in parentheses.',
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.textMutedDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Dishes List
            const Text(
              'Detected Dishes & Nutrition',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            ...filteredDishes.map((dish) {
              final formattedPrice = CurrencyFormatter.format(
                dish.priceValue > 0 ? dish.priceValue : 14.50,
                currencyCode: settings.currencyCode,
                symbol: settings.currencySymbol,
                showOriginal: true,
              );

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GlassCard(
                  padding: const EdgeInsets.all(16),
                  onTap: () {
                    HapticHelper.lightImpact();
                    final food = FoodAnalysisResult(
                      foodName: dish.name,
                      calories: dish.estimatedCalories,
                      protein: dish.protein,
                      carbohydrates: dish.carbs,
                      fat: dish.fat,
                      portionSize: '1 restaurant portion',
                      cuisine: menu.cuisineType,
                      dietaryTags: dish.dietaryTags,
                      allergenWarnings: dish.allergens,
                      disclaimer:
                          'AI estimated from menu text and culinary database.',
                    );
                    context.push('/analysis-result', extra: food);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FoodImageView(
                        foodName: dish.name,
                        width: 54,
                        height: 54,
                        borderRadius: 10,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    dish.name,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.15,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    formattedPrice,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.primaryLight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (dish.description.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                dish.description,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondaryDark,
                                ),
                              ),
                            ],
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.darkSurfaceHighlight,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Grade ${dish.healthRating}',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '~${dish.estimatedCalories} kcal',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryLight,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'P: ${dish.protein.toStringAsFixed(0)}g | C: ${dish.carbs.toStringAsFixed(0)}g | F: ${dish.fat.toStringAsFixed(0)}g',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textMutedDark,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            const DisclaimerBanner(
              customText:
                  'Restaurant menu nutritional estimations are calculated using standard preparation models. Actual kitchen ingredients, sauces, and cooking oils may vary.',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _FilterChipPill extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChipPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticHelper.selectionClick();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.darkSurfaceCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.darkBorder,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textSecondaryDark,
          ),
        ),
      ),
    );
  }
}
