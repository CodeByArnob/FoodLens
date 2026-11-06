// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'FoodLens';

  @override
  String get tagline => 'AI-Powered Food Intelligence';

  @override
  String get navHome => 'Home';

  @override
  String get navTracker => 'Tracker';

  @override
  String get navScanner => 'Scan Food';

  @override
  String get navMealPlan => 'Meal Plan';

  @override
  String get navProfile => 'Profile';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingContinue => 'Continue';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get onboardingTitle1 => 'Scan Any Dish, Menu or Food Label';

  @override
  String get onboardingDesc1 =>
      'Instant AI food intelligence. Point your camera at home-cooked meals, restaurant menus, or packaged food labels.';

  @override
  String get onboardingTitle2 => 'Deep Nutritional & Health Analytics';

  @override
  String get onboardingDesc2 =>
      'Get instant calorie estimates, full macronutrient distributions (protein, carbs, fat, fiber), and clinical health grades.';

  @override
  String get onboardingTitle3 => 'Personalized Dietary & Allergen Safety';

  @override
  String get onboardingDesc3 =>
      'Filter by Halal, Vegan, Keto, Gluten-Free, and receive proactive warnings about hidden allergens.';

  @override
  String get onboardingTitle4 => 'Decentralized AI with Puter.js';

  @override
  String get onboardingDesc4 =>
      'Powered by your personal Puter account. Zero server tracking, full privacy, and a generous free monthly allowance.';

  @override
  String get connectPuterTitle => 'Connect Puter Account';

  @override
  String get connectPuterSub => 'Personal Food Intelligence Cloud';

  @override
  String get connectPuterDesc =>
      'FoodLens uses Puter.js User-Pays architecture. You connect with your own official Puter account, consuming your free monthly AI compute with complete privacy.';

  @override
  String get signInWithPuter => 'Sign In with Puter';

  @override
  String get createFreePuterAccount => 'Create Free Puter Account';

  @override
  String get offlineMode => 'Offline Mode';

  @override
  String get signInWithToken => 'Sign in using Puter API Token';

  @override
  String get hideTokenLogin => 'Hide Token Login';

  @override
  String get tokenPlaceholder => 'Paste token from puter.com/dashboard';

  @override
  String get connectWithToken => 'Connect with Token';

  @override
  String get paste => 'Paste';

  @override
  String get getToken => 'Get Token ↗';

  @override
  String get greeting => 'Hello, Food Explorer 👋';

  @override
  String get greetingSub => 'Track & optimize your food intelligence';

  @override
  String get todayNutritionSummary => 'Today\'s Nutrition Summary';

  @override
  String get kcalConsumed => 'kcal consumed';

  @override
  String get kcalLeft => 'left';

  @override
  String get protein => 'Protein';

  @override
  String get carbs => 'Carbs';

  @override
  String get fat => 'Fat';

  @override
  String get fiber => 'Fiber';

  @override
  String get waterHydration => 'Water Hydration';

  @override
  String get addWater => '+250 ml Water';

  @override
  String get foodTools => 'Food Intelligence Tools';

  @override
  String get foodCompare => 'Food Compare';

  @override
  String get foodCompareSub => 'Side-by-side stats';

  @override
  String get menuExplorer => 'Menu Explorer';

  @override
  String get menuExplorerSub => 'Analyze menus';

  @override
  String get scanHistory => 'Scan History';

  @override
  String get favourites => 'Favourites';

  @override
  String scansCount(int count) {
    return '$count scans';
  }

  @override
  String savedCount(int count) {
    return '$count saved';
  }

  @override
  String get recommendedForGoals => 'Recommended for Your Goals';

  @override
  String get viewAll => 'View All';

  @override
  String get dishMode => 'Dish';

  @override
  String get menuMode => 'Menu';

  @override
  String get labelMode => 'Label OCR';

  @override
  String get alignFoodPrompt =>
      'Align plate inside the frame for best accuracy';

  @override
  String get alignMenuPrompt => 'Position camera over restaurant menu text';

  @override
  String get alignLabelPrompt =>
      'Focus on the nutrition facts table on food package';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get uploadGallery => 'Upload from Gallery';

  @override
  String get analyzingFood => 'Analyzing Food Intelligence...';

  @override
  String get healthIndex => 'Health Index';

  @override
  String get score => 'SCORE';

  @override
  String get aiEstimate => 'AI ESTIMATE';

  @override
  String get verifiedLabel => 'VERIFIED LABEL';

  @override
  String get macroBreakdown => 'Macronutrients Breakdown';

  @override
  String get microBreakdown => 'Micronutrients & Electrolytes';

  @override
  String get sugar => 'Sugar';

  @override
  String get saturatedFat => 'Saturated Fat';

  @override
  String get sodium => 'Sodium';

  @override
  String get potassium => 'Potassium';

  @override
  String get calcium => 'Calcium';

  @override
  String get iron => 'Iron';

  @override
  String get vitaminC => 'Vitamin C';

  @override
  String get ingredients => 'Key Ingredients';

  @override
  String get healthierAlternatives => 'Healthier Alternatives';

  @override
  String get portionSize => 'Portion Size';

  @override
  String get logMeal => 'Log Meal';

  @override
  String get originalPrice => 'Original Price';

  @override
  String get convertedPrice => 'Converted Price';

  @override
  String exchangeRateSource(String source) {
    return 'Exchange rate updated via $source';
  }

  @override
  String get menuExplorerTitle => 'Restaurant Menu Explorer';

  @override
  String get scanPhysicalMenu => 'Scan a Physical Menu';

  @override
  String get scanMenuDesc =>
      'Point at any paper menu or wine list to extract dishes & nutritional estimates.';

  @override
  String get scanMenuBtn => 'Scan Restaurant Menu with Camera';

  @override
  String get curatedDemos => 'Curated Menus & OCR Demos';

  @override
  String get detectedDishes => 'Detected Dishes & Nutrition';

  @override
  String get allItems => 'All Items';

  @override
  String get highProtein => 'High Protein (25g+)';

  @override
  String get lowCalorie => 'Low Calorie (<500 kcal)';

  @override
  String get settingsTitle => 'Settings & Preferences';

  @override
  String get appearanceSection => 'Appearance';

  @override
  String get appearanceDesc => 'Customize themes, dark mode and visual comfort';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get systemDefault => 'System Default';

  @override
  String get languageRegionSection => 'Language & Region';

  @override
  String get languageRegionDesc =>
      'App display language, country preferences and formats';

  @override
  String get language => 'App Language';

  @override
  String get countryRegion => 'Country / Region';

  @override
  String get timeZone => 'Time Zone';

  @override
  String get currencyLocalizationSection => 'Currency & Pricing';

  @override
  String get currencyLocalizationDesc =>
      'Real-time exchange rate conversion and price display';

  @override
  String get currency => 'Preferred Currency';

  @override
  String get exchangeRates => 'Live Exchange Rates';

  @override
  String get measurementSystemSection => 'Measurement System';

  @override
  String get measurementSystemDesc =>
      'Metric (grams, ml) vs Imperial (ounces, fl oz)';

  @override
  String get unitSystem => 'Unit System';

  @override
  String get metric => 'Metric (g, ml, kg)';

  @override
  String get imperial => 'Imperial (oz, fl oz, lbs)';

  @override
  String get dietaryPreferencesSection => 'Dietary Preferences';

  @override
  String get dietaryPreferencesDesc =>
      'Halal, Vegan, Keto, Allergens and customized goals';

  @override
  String get dailyCalorieGoal => 'Daily Calorie Goal';

  @override
  String get notificationsSection => 'Notifications';

  @override
  String get notificationsDesc => 'Meal logging reminders and hydration alerts';

  @override
  String get hydrationReminders => 'Hydration Reminders';

  @override
  String get mealReminders => 'Meal Logging Alerts';

  @override
  String get privacySecuritySection => 'Privacy & Security';

  @override
  String get privacySecurityDesc =>
      'Puter decentralized cloud keys and data controls';

  @override
  String get puterAccount => 'Puter.js Account';

  @override
  String get connected => 'Connected';

  @override
  String get disconnected => 'Disconnected (Offline Mode)';

  @override
  String get storageDataSection => 'Storage & Data';

  @override
  String get storageDataDesc => 'Local scan cache and saved dish management';

  @override
  String get clearCache => 'Clear Local Scan Cache';

  @override
  String get cacheCleared => 'Local scan cache cleared successfully.';

  @override
  String get aboutSection => 'About FoodLens';

  @override
  String get aboutDesc => 'Developer profile, creator credits and version';

  @override
  String get aboutTitle => 'About FoodLens';

  @override
  String get appName => 'FoodLens';

  @override
  String get appVersion => 'Version 1.0.0 (Global Release)';

  @override
  String get creatorTitle => 'Created & Developed by';

  @override
  String get developerName => 'CodeByArnob';

  @override
  String get developerRole => 'Original Creator & Lead Developer';

  @override
  String get viewGithubProfile => 'View GitHub Profile';

  @override
  String get madeWithPassion => 'Made with passion by CodeByArnob';

  @override
  String get maintainerTitle => 'Project Maintainer';

  @override
  String get contributorsTitle => 'Contributors & Open Source';

  @override
  String get officialGithub => 'Official GitHub Repository';

  @override
  String get safetyDisclaimerTitle => 'Safety & Nutritional Disclaimer';

  @override
  String get safetyDisclaimer =>
      'FoodLens AI estimates nutritional values and detects ingredients from visual imagery. It cannot guarantee the absence of cross-contamination or allergens, and must not be used as laboratory analysis or medical advice. Consult a healthcare professional for dietary prescriptions.';

  @override
  String get insufficientFundsTitle => 'Monthly Quota Exhausted';

  @override
  String get insufficientFundsDesc =>
      'Your personal Puter AI allowance has run out. Please upgrade your Puter account or add credits.';

  @override
  String get upgradePuter => 'Upgrade Puter Account';

  @override
  String get aboutFoodLens => 'About FoodLens';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get suggestedLocale => 'Suggested Locale';

  @override
  String get selectCurrency => 'Select Currency';

  @override
  String get localizationSection => 'Localization & Region';

  @override
  String get measurementSystem => 'Measurement System';

  @override
  String get dietarySection => 'Dietary Preferences & Goals';

  @override
  String get dietaryFilters => 'Dietary Filters';

  @override
  String get dataManagement => 'Storage & Data';

  @override
  String get cancel => 'Cancel';

  @override
  String get clear => 'Clear';

  @override
  String get recentScans => 'Recent Scans';

  @override
  String get favorites => 'Favourites';
}
