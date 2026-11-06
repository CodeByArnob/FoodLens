import 'dart:convert';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meal_plan.dart';
import '../../auth/providers/auth_provider.dart';
import '../../settings/providers/settings_provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/errors/app_exception.dart';

class MealPlannerState {
  final MealPlan? currentPlan;
  final bool isGenerating;
  final String? errorMessage;
  final int targetCalories;
  final String selectedDiet;
  final String selectedCuisine;

  const MealPlannerState({
    this.currentPlan,
    this.isGenerating = false,
    this.errorMessage,
    this.targetCalories = 2000,
    this.selectedDiet = 'Balanced',
    this.selectedCuisine = 'Global / Diverse',
  });

  MealPlannerState copyWith({
    MealPlan? currentPlan,
    bool? isGenerating,
    String? errorMessage,
    int? targetCalories,
    String? selectedDiet,
    String? selectedCuisine,
  }) {
    return MealPlannerState(
      currentPlan: currentPlan ?? this.currentPlan,
      isGenerating: isGenerating ?? this.isGenerating,
      errorMessage: errorMessage,
      targetCalories: targetCalories ?? this.targetCalories,
      selectedDiet: selectedDiet ?? this.selectedDiet,
      selectedCuisine: selectedCuisine ?? this.selectedCuisine,
    );
  }
}

final mealPlannerProvider =
    StateNotifierProvider<MealPlannerNotifier, MealPlannerState>((ref) {
      final bridge = ref.watch(puterBridgeServiceProvider);
      final settings = ref.watch(settingsProvider);
      return MealPlannerNotifier(bridge, settings);
    });

class MealPlannerNotifier extends StateNotifier<MealPlannerState> {
  final dynamic _bridge;
  final SettingsState _settings;

  MealPlannerNotifier(this._bridge, this._settings)
    : super(MealPlannerState(targetCalories: _settings.dailyCalorieTarget)) {
    _loadCachedPlan();
  }

  Future<void> _loadCachedPlan() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedJson = prefs.getString(AppConstants.keyActiveMealPlan);
      if (cachedJson != null && cachedJson.isNotEmpty) {
        final Map<String, dynamic> map = jsonDecode(cachedJson);
        state = state.copyWith(currentPlan: MealPlan.fromJson(map));
      } else {
        final defaultPlan = MealPlan(
          planTitle: 'High-Protein Metabolic Boost Plan',
          totalCalories: 2050,
          totalProtein: 135.0,
          totalCarbs: 190.0,
          totalFat: 68.0,
          nutritionalSummary:
              'A nutrient-dense plan engineered for stable blood sugar, lean mass preservation, and sustained mental focus.',
          meals: [
            PlannedMeal(
              mealType: 'Breakfast',
              dishName: 'Spinach & Feta Egg White Omelette with Sourdough',
              portion: '3 egg whites, 1 slice bread',
              calories: 380,
              protein: 26.0,
              carbs: 32.0,
              fat: 11.0,
              prepTimeMinutes: 12,
              ingredients: [
                'Egg whites',
                'Baby spinach',
                'Feta cheese',
                'Sourdough toast',
              ],
              instructions:
                  'Whisk egg whites with spinach and cook on olive oil spray. Top with crumbled feta.',
            ),
            PlannedMeal(
              mealType: 'Lunch',
              dishName: 'Quinoa Salmon Power Bowl',
              portion: '1 medium bowl (350g)',
              calories: 620,
              protein: 42.0,
              carbs: 58.0,
              fat: 22.0,
              prepTimeMinutes: 20,
              ingredients: [
                'Salmon fillet',
                'Cooked quinoa',
                'Avocado',
                'Steamed broccoli',
                'Tahini dressing',
              ],
              instructions:
                  'Pan-sear salmon 4 mins each side. Assemble bowl with warm quinoa and drizzle tahini.',
            ),
            PlannedMeal(
              mealType: 'Dinner',
              dishName: 'Spiced Chicken Breast & Sweet Potato Mash',
              portion: '1 plate',
              calories: 550,
              protein: 48.0,
              carbs: 52.0,
              fat: 14.0,
              prepTimeMinutes: 25,
              ingredients: [
                'Chicken breast',
                'Sweet potato',
                'Green beans',
                'Paprika',
                'Olive oil',
              ],
              instructions:
                  'Bake seasoned chicken at 200°C for 22 mins. Mash steamed sweet potato with olive oil.',
            ),
            PlannedMeal(
              mealType: 'Snacks',
              dishName: 'Greek Yogurt with Blueberries & Chia Seeds',
              portion: '1 bowl (200g)',
              calories: 260,
              protein: 19.0,
              carbs: 26.0,
              fat: 6.0,
              prepTimeMinutes: 3,
              ingredients: [
                '0% Greek yogurt',
                'Fresh blueberries',
                'Chia seeds',
                'Honey drizzle',
              ],
              instructions: 'Stir together and enjoy chilled.',
            ),
          ],
        );
        state = state.copyWith(currentPlan: defaultPlan);
      }
    } catch (_) {}
  }

  void updateTargetCalories(int cals) {
    state = state.copyWith(targetCalories: cals);
  }

  void updateSelectedDiet(String diet) {
    state = state.copyWith(selectedDiet: diet);
  }

  void updateSelectedCuisine(String cuisine) {
    state = state.copyWith(selectedCuisine: cuisine);
  }

  Future<bool> generateNewPlan() async {
    state = state.copyWith(isGenerating: true, errorMessage: null);
    try {
      final restrictions = _settings.dietaryFilters.isEmpty
          ? 'None'
          : _settings.dietaryFilters.join(', ');

      final plan = await _bridge.generateMealPlan(
        targetCalories: state.targetCalories,
        dietType: state.selectedDiet,
        restrictions: restrictions,
        cuisine: state.selectedCuisine,
        languageCode: _settings.language,
        languageName: _settings.languageNativeName,
      );

      state = state.copyWith(currentPlan: plan, isGenerating: false);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        AppConstants.keyActiveMealPlan,
        jsonEncode(plan.toJson()),
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isGenerating: false,
        errorMessage: e is AppException ? e.message : e.toString(),
      );
      return false;
    }
  }
}
