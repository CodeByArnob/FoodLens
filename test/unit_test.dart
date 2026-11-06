import 'package:flutter_test/flutter_test.dart' hide ComparisonResult;
import 'package:foodlens/core/utils/unit_converter.dart';
import 'package:foodlens/features/auth/models/puter_usage.dart';
import 'package:foodlens/features/auth/models/puter_user.dart';
import 'package:foodlens/features/auth/providers/auth_provider.dart';
import 'package:foodlens/features/scanner/providers/scanner_provider.dart';
import 'package:foodlens/features/scanner/models/food_analysis_result.dart';
import 'package:foodlens/features/scanner/models/menu_analysis_result.dart';
import 'package:foodlens/features/meal_planner/models/meal_plan.dart';
import 'package:foodlens/features/comparison/models/comparison_result.dart';
import 'package:foodlens/features/nutrition_tracking/models/daily_log.dart';
import 'package:foodlens/features/nutrition_tracking/models/meal_log_item.dart';
import 'package:foodlens/core/utils/currency_formatter.dart';
import 'package:foodlens/core/utils/dashboard_localization_helper.dart';
import 'package:foodlens/core/errors/app_exception.dart';
import 'package:foodlens/l10n/app_localizations_en.dart';
import 'package:foodlens/l10n/app_localizations_bn.dart';

void main() {
  group('UnitConverter Tests', () {
    test('gramsToOunces correctly converts', () {
      final oz = UnitConverter.gramsToOunces(100);
      expect(oz, closeTo(3.527, 0.01));
    });

    test('formatWeight formats metric and imperial', () {
      expect(UnitConverter.formatWeight(350, isMetric: true), '350 g');
      expect(UnitConverter.formatWeight(1500, isMetric: true), '1.5 kg');
      expect(UnitConverter.formatWeight(100, isMetric: false), '3.5 oz');
    });

    test('formatVolume formats ml and fl oz', () {
      expect(UnitConverter.formatVolume(250, isMetric: true), '250 ml');
      expect(UnitConverter.formatVolume(1000, isMetric: true), '1.0 L');
    });
  });

  group('Puter Models Tests', () {
    test('PuterUsage default free tier values', () {
      final usage = PuterUsage.defaultFreeTier();
      expect(usage.totalAllowance, 10000000.0);
      expect(usage.hasExhaustedAllowance, false);
      expect(usage.remainingCreditsFormatted, '\$8.75');
      expect(usage.totalCreditsFormatted, '\$10.00');
    });

    test('PuterUsage exhausted state', () {
      final exhausted = PuterUsage.exhausted();
      expect(exhausted.hasExhaustedAllowance, true);
      expect(exhausted.remainingAllowance, 0.0);
      expect(exhausted.remainingCreditsFormatted, '\$0.00');
    });

    test('PuterUser parsing from JSON', () {
      final user = PuterUser.fromJson({
        'username': 'chefalice',
        'uuid': 'puter-uuid-1234',
        'email': 'alice@example.com',
      });
      expect(user.username, 'chefalice');
      expect(user.uuid, 'puter-uuid-1234');
      expect(user.email, 'alice@example.com');
    });
  });

  group('Food Analysis & Intelligence Models', () {
    test('FoodAnalysisResult parses correctly with all nutrients', () {
      final json = {
        'food_name': 'Grilled Salmon Quinoa Bowl',
        'confidence_score': 0.98,
        'calories': 520,
        'protein': 38.0,
        'carbohydrates': 44.0,
        'fat': 20.0,
        'fiber': 7.0,
        'health_score': 92,
        'ingredients': ['Salmon', 'Quinoa', 'Olive Oil'],
        'allergen_warnings': ['Fish'],
        'dietary_tags': ['high-protein', 'gluten-free'],
        'is_food_related': true,
      };

      final result = FoodAnalysisResult.fromJson(json);
      expect(result.foodName, 'Grilled Salmon Quinoa Bowl');
      expect(result.calories, 520);
      expect(result.protein, 38.0);
      expect(result.fiber, 7.0);
      expect(result.healthScore, 92);
      expect(result.isFoodRelated, true);
      expect(result.allergenWarnings, contains('Fish'));
      expect(result.dietaryTags, contains('high-protein'));
    });

    test('NonFoodImageException and non-food validation fields work properly', () {
      final nonFoodJson = {
        'is_food_related': false,
        'detected_category': 'household_object',
        'rejection_reason': 'The uploaded image contains a laptop keyboard, not consumable food.',
        'food_name': 'Non-Food Object',
        'confidence_score': 0.0,
        'calories': 0,
      };

      final result = FoodAnalysisResult.fromJson(nonFoodJson);
      expect(result.isFoodRelated, false);
      expect(result.detectedCategory, 'household_object');
      expect(result.rejectionReason, contains('laptop keyboard'));
      expect(result.calories, 0);

      // Verify NonFoodImageException
      final exception = NonFoodImageException(
        result.rejectionReason ?? 'No food detected',
        category: result.detectedCategory,
      );
      expect(exception.message, contains('laptop keyboard'));
      expect(exception.category, 'household_object');
      expect(exception.code, 'NON_FOOD_IMAGE');
      expect(exception.toString(), contains('laptop keyboard'));
    });

    test('MenuAnalysisResult parses restaurant dishes', () {
      final json = {
        'restaurant_name': 'Bistro Roma',
        'cuisine_type': 'Italian',
        'currency': '€',
        'dishes': [
          {
            'name': 'Margherita Pizza',
            'price_raw': '€12.50',
            'price_value': 12.50,
            'estimated_calories': 680,
            'protein': 22.0,
            'dietary_tags': ['vegetarian'],
            'health_rating': 'B',
          }
        ]
      };

      final menu = MenuAnalysisResult.fromJson(json);
      expect(menu.restaurantName, 'Bistro Roma');
      expect(menu.dishes.length, 1);
      expect(menu.dishes.first.name, 'Margherita Pizza');
      expect(menu.dishes.first.priceValue, 12.50);
    });

    test('MealPlan parses meals and calculate totals', () {
      final plan = MealPlan(
        planTitle: 'Custom Plan',
        totalCalories: 2000,
        totalProtein: 140,
        totalCarbs: 200,
        totalFat: 60,
        meals: [
          PlannedMeal(
            mealType: 'Breakfast',
            dishName: 'Oats with Whey and Berries',
            portion: '1 bowl',
            calories: 450,
            protein: 35,
            carbs: 55,
            fat: 8,
          ),
        ],
      );

      expect(plan.meals.length, 1);
      expect(plan.meals.first.calories, 450);
      expect(plan.totalCalories, 2000);
    });

    test('DailyLog totals calculation', () {
      final log = DailyLog(
        dateKey: '2026-11-05',
        waterIntakeMl: 1500,
        meals: [
          MealLogItem(
            foodName: 'Avocado Toast',
            mealType: MealType.breakfast,
            calories: 340,
            protein: 14,
            carbohydrates: 28,
            fat: 19,
          ),
          MealLogItem(
            foodName: 'Grilled Chicken Salad',
            mealType: MealType.lunch,
            calories: 410,
            protein: 38,
            carbohydrates: 12,
            fat: 22,
          ),
        ],
      );

      expect(log.totalCalories, 750);
      expect(log.totalProtein, 52.0);
      expect(log.totalCarbs, 40.0);
      expect(log.totalFat, 41.0);
      expect(log.breakfastMeals.length, 1);
      expect(log.lunchMeals.length, 1);
      expect(log.dinnerMeals.length, 0);
    });

    test('ComparisonResult winner and verdict check', () {
      final comp = ComparisonResult(
        winner: 'Salmon Bowl',
        verdictSummary: 'Salmon Bowl has 2x higher protein.',
        calorieDiff: -60,
        proteinDiff: 18.0,
      );

      expect(comp.winner, 'Salmon Bowl');
      expect(comp.calorieDiff, -60);
      expect(comp.proteinDiff, 18.0);
    });
  });

  group('CurrencyFormatter Tests', () {
    test('converts USD amount to BDT with symbol ৳ and original USD reference', () {
      final bdtFormatted = CurrencyFormatter.format(14.50, currencyCode: 'BDT', showOriginal: true);
      expect(bdtFormatted, contains('৳'));
      expect(bdtFormatted, contains('1,776'));
      expect(bdtFormatted, contains('(\$ 14.50)'));
    });

    test('formats pure USD without redundant USD parenthesis', () {
      final usdFormatted = CurrencyFormatter.format(14.50, currencyCode: 'USD', showOriginal: true);
      expect(usdFormatted, '\$ 14.50');
    });

    test('formats EUR, GBP, and INR with respective international symbols', () {
      expect(CurrencyFormatter.format(10.0, currencyCode: 'EUR'), contains('€'));
      expect(CurrencyFormatter.format(10.0, currencyCode: 'GBP'), contains('£'));
      expect(CurrencyFormatter.format(10.0, currencyCode: 'INR'), contains('₹'));
      expect(CurrencyFormatter.format(10.0, currencyCode: 'SAR'), contains('ر.স'));
    });
  });

  group('Localization Tests', () {
    test('AppLocalizationsEn provides English default strings', () {
      final en = AppLocalizationsEn();
      expect(en.appTitle, 'FoodLens');
      expect(en.navHome, 'Home');
      expect(en.navTracker, 'Tracker');
      expect(en.navMealPlan, 'Meal Plan');
      expect(en.navProfile, 'Profile');
      expect(en.aboutFoodLens, 'About FoodLens');
    });

    test('AppLocalizationsBn provides authentic Bengali translations', () {
      final bn = AppLocalizationsBn();
      expect(bn.appTitle, 'ফুডলেন্স');
      expect(bn.navHome, 'হোম');
      expect(bn.navTracker, 'ট্র্যাকার');
      expect(bn.navMealPlan, 'মিল প্ল্যান');
      expect(bn.navProfile, 'প্রোফাইল');
      expect(bn.aboutFoodLens, 'ফুডলেন্স সম্পর্কে');
      expect(bn.madeWithPassion, contains('CodeByArnob'));
    });

    test('DashboardLocalizationHelper provides localized greetings and insights', () {
      // English Greetings
      expect(DashboardLocalizationHelper.getGreeting('en', 'Alice', hour: 8), contains('Good morning, Alice'));
      expect(DashboardLocalizationHelper.getGreeting('en', 'Alice', hour: 14), contains('Good afternoon, Alice'));
      expect(DashboardLocalizationHelper.getGreeting('en', 'Alice', hour: 20), contains('Good evening, Alice'));

      // Bengali Greetings
      expect(DashboardLocalizationHelper.getGreeting('bn', 'অনন্যা', hour: 8), contains('সুপ্রভাত, অনন্যা'));
      expect(DashboardLocalizationHelper.getGreeting('bn', 'অনন্যা', hour: 14), contains('শুভ অপরাহ্ন, অনন্যা'));
      expect(DashboardLocalizationHelper.getGreeting('bn', 'অনন্যা', hour: 20), contains('শুভ সন্ধ্যা, অনন্যা'));

      // Arabic Greetings
      expect(DashboardLocalizationHelper.getGreeting('ar', 'علي', hour: 8), contains('صباح الخير، علي'));
      expect(DashboardLocalizationHelper.getGreeting('ar', 'علي', hour: 14), contains('مساء الخير، علي'));
      expect(DashboardLocalizationHelper.getGreeting('ar', 'علي', hour: 20), contains('مساء النور، علي'));

      // Scanning titles
      expect(DashboardLocalizationHelper.getScanFoodTitle('en'), 'Scan Food Dish');
      expect(DashboardLocalizationHelper.getScanFoodTitle('bn'), 'খাবারের ছবি স্ক্যান করুন');
      expect(DashboardLocalizationHelper.getScanFoodTitle('ar'), 'مسح وجبة طعام');

      expect(DashboardLocalizationHelper.getScanMenuTitle('en'), 'Scan Restaurant Menu');
      expect(DashboardLocalizationHelper.getScanMenuTitle('bn'), 'রেস্তোরাঁর মেনু স্ক্যান');
      expect(DashboardLocalizationHelper.getScanMenuTitle('ar'), 'مسح قائمة المطعم');

      // Nutrition insights
      final insightZero = DashboardLocalizationHelper.getNutritionInsight('en', 0, 2000);
      expect(insightZero, contains('Start your day'));

      final insightRemaining = DashboardLocalizationHelper.getNutritionInsight('en', 1200, 2000);
      expect(insightRemaining, contains('800 kcal away'));
    });
  });

  group('Optimization & State Resilience Tests', () {
    test('AuthState initial state restores immediately without blocking', () {
      final user = PuterUser(username: 'testchef', uuid: 'uuid-1234');
      final state = AuthState(user: user, isLoading: false, isBridgeReady: true);
      expect(state.isAuthenticated, true);
      expect(state.isLoading, false);
      expect(state.user?.username, 'testchef');
    });

    test('ScannerState supports stage updates and cancel', () {
      const state = ScannerState(
        isScanning: true,
        currentStageMessage: 'Analyzing macro & micronutrient profile...',
      );
      expect(state.isScanning, true);
      expect(state.currentStageMessage, contains('macro & micronutrient'));

      final cancelled = state.copyWith(
        isScanning: false,
        clearStage: true,
        errorMessage: 'Scan cancelled by user.',
      );
      expect(cancelled.isScanning, false);
      expect(cancelled.currentStageMessage, null);
      expect(cancelled.errorMessage, contains('cancelled'));
    });

    test('PuterAuthException and PuterInsufficientFundsException categorization', () {
      final authExc = PuterAuthException('Puter authentication required. Please connect your Puter account.', code: 'auth_required');
      expect(authExc.message, contains('Puter authentication required'));
      expect(authExc.code, 'auth_required');

      final fundsExc = PuterInsufficientFundsException(
        message: 'Your monthly AI allowance is exhausted.',
        upgradeUrl: 'https://puter.com/account',
      );
      expect(fundsExc.message, contains('allowance is exhausted'));
      expect(fundsExc.upgradeUrl, 'https://puter.com/account');
      expect(fundsExc.code, 'insufficient_funds');
    });
  });
}
