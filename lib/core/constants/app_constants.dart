class AppConstants {
  static const String appName = 'FoodLens';
  static const String appTagline = 'Global AI Food Intelligence & Nutrition';
  static const String appVersion = '1.0.0';

  // Puter URLs & Endpoints
  static const String puterDocsUrl = 'https://docs.puter.com';
  static const String puterAccountUrl = 'https://puter.com/account';
  static const String puterSignUpUrl = 'https://puter.com/signup';
  static const String puterDashboardUrl = 'https://puter.com/dashboard#account';

  // Local Storage Keys
  static const String keyPuterToken = 'foodlens_puter_token';
  static const String keyPuterUsername = 'foodlens_puter_username';
  static const String keyPuterUuid = 'foodlens_puter_uuid';
  static const String keyHasCompletedOnboarding = 'foodlens_onboarding_completed';
  static const String keyScanHistory = 'foodlens_scan_history';
  static const String keyFavorites = 'foodlens_favorites';
  static const String keyDailyLogs = 'foodlens_daily_logs';
  static const String keyActiveMealPlan = 'foodlens_active_meal_plan';
  static const String keyUserPreferences = 'foodlens_user_preferences';
  static const String keySelectedCurrency = 'foodlens_currency';
  static const String keyUnitSystem = 'foodlens_unit_system'; // 'metric' or 'imperial'
  static const String keyThemeMode = 'foodlens_theme_mode'; // 'system', 'light', 'dark'
  static const String keySelectedLanguage = 'foodlens_language';
  static const String keyDailyCalorieTarget = 'foodlens_daily_calorie_target';

  // Default Targets
  static const int defaultDailyCalories = 2100;
  static const double defaultDailyProtein = 130.0;
  static const double defaultDailyCarbs = 230.0;
  static const double defaultDailyFat = 65.0;
  static const double defaultDailyFiber = 30.0;
}
