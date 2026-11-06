import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('ja'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'FoodLens'**
  String get appTitle;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'AI-Powered Food Intelligence'**
  String get tagline;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navTracker.
  ///
  /// In en, this message translates to:
  /// **'Tracker'**
  String get navTracker;

  /// No description provided for @navScanner.
  ///
  /// In en, this message translates to:
  /// **'Scan Food'**
  String get navScanner;

  /// No description provided for @navMealPlan.
  ///
  /// In en, this message translates to:
  /// **'Meal Plan'**
  String get navMealPlan;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinue;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingGetStarted;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Scan Any Dish, Menu or Food Label'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'Instant AI food intelligence. Point your camera at home-cooked meals, restaurant menus, or packaged food labels.'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Deep Nutritional & Health Analytics'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Get instant calorie estimates, full macronutrient distributions (protein, carbs, fat, fiber), and clinical health grades.'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Personalized Dietary & Allergen Safety'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Filter by Halal, Vegan, Keto, Gluten-Free, and receive proactive warnings about hidden allergens.'**
  String get onboardingDesc3;

  /// No description provided for @onboardingTitle4.
  ///
  /// In en, this message translates to:
  /// **'Decentralized AI with Puter.js'**
  String get onboardingTitle4;

  /// No description provided for @onboardingDesc4.
  ///
  /// In en, this message translates to:
  /// **'Powered by your personal Puter account. Zero server tracking, full privacy, and a generous free monthly allowance.'**
  String get onboardingDesc4;

  /// No description provided for @connectPuterTitle.
  ///
  /// In en, this message translates to:
  /// **'Connect Puter Account'**
  String get connectPuterTitle;

  /// No description provided for @connectPuterSub.
  ///
  /// In en, this message translates to:
  /// **'Personal Food Intelligence Cloud'**
  String get connectPuterSub;

  /// No description provided for @connectPuterDesc.
  ///
  /// In en, this message translates to:
  /// **'FoodLens uses Puter.js User-Pays architecture. You connect with your own official Puter account, consuming your free monthly AI compute with complete privacy.'**
  String get connectPuterDesc;

  /// No description provided for @signInWithPuter.
  ///
  /// In en, this message translates to:
  /// **'Sign In with Puter'**
  String get signInWithPuter;

  /// No description provided for @createFreePuterAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Free Puter Account'**
  String get createFreePuterAccount;

  /// No description provided for @offlineMode.
  ///
  /// In en, this message translates to:
  /// **'Offline Mode'**
  String get offlineMode;

  /// No description provided for @signInWithToken.
  ///
  /// In en, this message translates to:
  /// **'Sign in using Puter API Token'**
  String get signInWithToken;

  /// No description provided for @hideTokenLogin.
  ///
  /// In en, this message translates to:
  /// **'Hide Token Login'**
  String get hideTokenLogin;

  /// No description provided for @tokenPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Paste token from puter.com/dashboard'**
  String get tokenPlaceholder;

  /// No description provided for @connectWithToken.
  ///
  /// In en, this message translates to:
  /// **'Connect with Token'**
  String get connectWithToken;

  /// No description provided for @paste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paste;

  /// No description provided for @getToken.
  ///
  /// In en, this message translates to:
  /// **'Get Token ↗'**
  String get getToken;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, Food Explorer 👋'**
  String get greeting;

  /// No description provided for @greetingSub.
  ///
  /// In en, this message translates to:
  /// **'Track & optimize your food intelligence'**
  String get greetingSub;

  /// No description provided for @todayNutritionSummary.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Nutrition Summary'**
  String get todayNutritionSummary;

  /// No description provided for @kcalConsumed.
  ///
  /// In en, this message translates to:
  /// **'kcal consumed'**
  String get kcalConsumed;

  /// No description provided for @kcalLeft.
  ///
  /// In en, this message translates to:
  /// **'left'**
  String get kcalLeft;

  /// No description provided for @protein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get protein;

  /// No description provided for @carbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get carbs;

  /// No description provided for @fat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get fat;

  /// No description provided for @fiber.
  ///
  /// In en, this message translates to:
  /// **'Fiber'**
  String get fiber;

  /// No description provided for @waterHydration.
  ///
  /// In en, this message translates to:
  /// **'Water Hydration'**
  String get waterHydration;

  /// No description provided for @addWater.
  ///
  /// In en, this message translates to:
  /// **'+250 ml Water'**
  String get addWater;

  /// No description provided for @foodTools.
  ///
  /// In en, this message translates to:
  /// **'Food Intelligence Tools'**
  String get foodTools;

  /// No description provided for @foodCompare.
  ///
  /// In en, this message translates to:
  /// **'Food Compare'**
  String get foodCompare;

  /// No description provided for @foodCompareSub.
  ///
  /// In en, this message translates to:
  /// **'Side-by-side stats'**
  String get foodCompareSub;

  /// No description provided for @menuExplorer.
  ///
  /// In en, this message translates to:
  /// **'Menu Explorer'**
  String get menuExplorer;

  /// No description provided for @menuExplorerSub.
  ///
  /// In en, this message translates to:
  /// **'Analyze menus'**
  String get menuExplorerSub;

  /// No description provided for @scanHistory.
  ///
  /// In en, this message translates to:
  /// **'Scan History'**
  String get scanHistory;

  /// No description provided for @favourites.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favourites;

  /// No description provided for @scansCount.
  ///
  /// In en, this message translates to:
  /// **'{count} scans'**
  String scansCount(int count);

  /// No description provided for @savedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} saved'**
  String savedCount(int count);

  /// No description provided for @recommendedForGoals.
  ///
  /// In en, this message translates to:
  /// **'Recommended for Your Goals'**
  String get recommendedForGoals;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @dishMode.
  ///
  /// In en, this message translates to:
  /// **'Dish'**
  String get dishMode;

  /// No description provided for @menuMode.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menuMode;

  /// No description provided for @labelMode.
  ///
  /// In en, this message translates to:
  /// **'Label OCR'**
  String get labelMode;

  /// No description provided for @alignFoodPrompt.
  ///
  /// In en, this message translates to:
  /// **'Align plate inside the frame for best accuracy'**
  String get alignFoodPrompt;

  /// No description provided for @alignMenuPrompt.
  ///
  /// In en, this message translates to:
  /// **'Position camera over restaurant menu text'**
  String get alignMenuPrompt;

  /// No description provided for @alignLabelPrompt.
  ///
  /// In en, this message translates to:
  /// **'Focus on the nutrition facts table on food package'**
  String get alignLabelPrompt;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @uploadGallery.
  ///
  /// In en, this message translates to:
  /// **'Upload from Gallery'**
  String get uploadGallery;

  /// No description provided for @analyzingFood.
  ///
  /// In en, this message translates to:
  /// **'Analyzing Food Intelligence...'**
  String get analyzingFood;

  /// No description provided for @healthIndex.
  ///
  /// In en, this message translates to:
  /// **'Health Index'**
  String get healthIndex;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'SCORE'**
  String get score;

  /// No description provided for @aiEstimate.
  ///
  /// In en, this message translates to:
  /// **'AI ESTIMATE'**
  String get aiEstimate;

  /// No description provided for @verifiedLabel.
  ///
  /// In en, this message translates to:
  /// **'VERIFIED LABEL'**
  String get verifiedLabel;

  /// No description provided for @macroBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Macronutrients Breakdown'**
  String get macroBreakdown;

  /// No description provided for @microBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Micronutrients & Electrolytes'**
  String get microBreakdown;

  /// No description provided for @sugar.
  ///
  /// In en, this message translates to:
  /// **'Sugar'**
  String get sugar;

  /// No description provided for @saturatedFat.
  ///
  /// In en, this message translates to:
  /// **'Saturated Fat'**
  String get saturatedFat;

  /// No description provided for @sodium.
  ///
  /// In en, this message translates to:
  /// **'Sodium'**
  String get sodium;

  /// No description provided for @potassium.
  ///
  /// In en, this message translates to:
  /// **'Potassium'**
  String get potassium;

  /// No description provided for @calcium.
  ///
  /// In en, this message translates to:
  /// **'Calcium'**
  String get calcium;

  /// No description provided for @iron.
  ///
  /// In en, this message translates to:
  /// **'Iron'**
  String get iron;

  /// No description provided for @vitaminC.
  ///
  /// In en, this message translates to:
  /// **'Vitamin C'**
  String get vitaminC;

  /// No description provided for @ingredients.
  ///
  /// In en, this message translates to:
  /// **'Key Ingredients'**
  String get ingredients;

  /// No description provided for @healthierAlternatives.
  ///
  /// In en, this message translates to:
  /// **'Healthier Alternatives'**
  String get healthierAlternatives;

  /// No description provided for @portionSize.
  ///
  /// In en, this message translates to:
  /// **'Portion Size'**
  String get portionSize;

  /// No description provided for @logMeal.
  ///
  /// In en, this message translates to:
  /// **'Log Meal'**
  String get logMeal;

  /// No description provided for @originalPrice.
  ///
  /// In en, this message translates to:
  /// **'Original Price'**
  String get originalPrice;

  /// No description provided for @convertedPrice.
  ///
  /// In en, this message translates to:
  /// **'Converted Price'**
  String get convertedPrice;

  /// No description provided for @exchangeRateSource.
  ///
  /// In en, this message translates to:
  /// **'Exchange rate updated via {source}'**
  String exchangeRateSource(String source);

  /// No description provided for @menuExplorerTitle.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Menu Explorer'**
  String get menuExplorerTitle;

  /// No description provided for @scanPhysicalMenu.
  ///
  /// In en, this message translates to:
  /// **'Scan a Physical Menu'**
  String get scanPhysicalMenu;

  /// No description provided for @scanMenuDesc.
  ///
  /// In en, this message translates to:
  /// **'Point at any paper menu or wine list to extract dishes & nutritional estimates.'**
  String get scanMenuDesc;

  /// No description provided for @scanMenuBtn.
  ///
  /// In en, this message translates to:
  /// **'Scan Restaurant Menu with Camera'**
  String get scanMenuBtn;

  /// No description provided for @curatedDemos.
  ///
  /// In en, this message translates to:
  /// **'Curated Menus & OCR Demos'**
  String get curatedDemos;

  /// No description provided for @detectedDishes.
  ///
  /// In en, this message translates to:
  /// **'Detected Dishes & Nutrition'**
  String get detectedDishes;

  /// No description provided for @allItems.
  ///
  /// In en, this message translates to:
  /// **'All Items'**
  String get allItems;

  /// No description provided for @highProtein.
  ///
  /// In en, this message translates to:
  /// **'High Protein (25g+)'**
  String get highProtein;

  /// No description provided for @lowCalorie.
  ///
  /// In en, this message translates to:
  /// **'Low Calorie (<500 kcal)'**
  String get lowCalorie;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings & Preferences'**
  String get settingsTitle;

  /// No description provided for @appearanceSection.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceSection;

  /// No description provided for @appearanceDesc.
  ///
  /// In en, this message translates to:
  /// **'Customize themes, dark mode and visual comfort'**
  String get appearanceDesc;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @languageRegionSection.
  ///
  /// In en, this message translates to:
  /// **'Language & Region'**
  String get languageRegionSection;

  /// No description provided for @languageRegionDesc.
  ///
  /// In en, this message translates to:
  /// **'App display language, country preferences and formats'**
  String get languageRegionDesc;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get language;

  /// No description provided for @countryRegion.
  ///
  /// In en, this message translates to:
  /// **'Country / Region'**
  String get countryRegion;

  /// No description provided for @timeZone.
  ///
  /// In en, this message translates to:
  /// **'Time Zone'**
  String get timeZone;

  /// No description provided for @currencyLocalizationSection.
  ///
  /// In en, this message translates to:
  /// **'Currency & Pricing'**
  String get currencyLocalizationSection;

  /// No description provided for @currencyLocalizationDesc.
  ///
  /// In en, this message translates to:
  /// **'Real-time exchange rate conversion and price display'**
  String get currencyLocalizationDesc;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Preferred Currency'**
  String get currency;

  /// No description provided for @exchangeRates.
  ///
  /// In en, this message translates to:
  /// **'Live Exchange Rates'**
  String get exchangeRates;

  /// No description provided for @measurementSystemSection.
  ///
  /// In en, this message translates to:
  /// **'Measurement System'**
  String get measurementSystemSection;

  /// No description provided for @measurementSystemDesc.
  ///
  /// In en, this message translates to:
  /// **'Metric (grams, ml) vs Imperial (ounces, fl oz)'**
  String get measurementSystemDesc;

  /// No description provided for @unitSystem.
  ///
  /// In en, this message translates to:
  /// **'Unit System'**
  String get unitSystem;

  /// No description provided for @metric.
  ///
  /// In en, this message translates to:
  /// **'Metric (g, ml, kg)'**
  String get metric;

  /// No description provided for @imperial.
  ///
  /// In en, this message translates to:
  /// **'Imperial (oz, fl oz, lbs)'**
  String get imperial;

  /// No description provided for @dietaryPreferencesSection.
  ///
  /// In en, this message translates to:
  /// **'Dietary Preferences'**
  String get dietaryPreferencesSection;

  /// No description provided for @dietaryPreferencesDesc.
  ///
  /// In en, this message translates to:
  /// **'Halal, Vegan, Keto, Allergens and customized goals'**
  String get dietaryPreferencesDesc;

  /// No description provided for @dailyCalorieGoal.
  ///
  /// In en, this message translates to:
  /// **'Daily Calorie Goal'**
  String get dailyCalorieGoal;

  /// No description provided for @notificationsSection.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsSection;

  /// No description provided for @notificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Meal logging reminders and hydration alerts'**
  String get notificationsDesc;

  /// No description provided for @hydrationReminders.
  ///
  /// In en, this message translates to:
  /// **'Hydration Reminders'**
  String get hydrationReminders;

  /// No description provided for @mealReminders.
  ///
  /// In en, this message translates to:
  /// **'Meal Logging Alerts'**
  String get mealReminders;

  /// No description provided for @privacySecuritySection.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacySecuritySection;

  /// No description provided for @privacySecurityDesc.
  ///
  /// In en, this message translates to:
  /// **'Puter decentralized cloud keys and data controls'**
  String get privacySecurityDesc;

  /// No description provided for @puterAccount.
  ///
  /// In en, this message translates to:
  /// **'Puter.js Account'**
  String get puterAccount;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// No description provided for @disconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected (Offline Mode)'**
  String get disconnected;

  /// No description provided for @storageDataSection.
  ///
  /// In en, this message translates to:
  /// **'Storage & Data'**
  String get storageDataSection;

  /// No description provided for @storageDataDesc.
  ///
  /// In en, this message translates to:
  /// **'Local scan cache and saved dish management'**
  String get storageDataDesc;

  /// No description provided for @clearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear Local Scan Cache'**
  String get clearCache;

  /// No description provided for @cacheCleared.
  ///
  /// In en, this message translates to:
  /// **'Local scan cache cleared successfully.'**
  String get cacheCleared;

  /// No description provided for @aboutSection.
  ///
  /// In en, this message translates to:
  /// **'About FoodLens'**
  String get aboutSection;

  /// No description provided for @aboutDesc.
  ///
  /// In en, this message translates to:
  /// **'Developer profile, creator credits and version'**
  String get aboutDesc;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About FoodLens'**
  String get aboutTitle;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'FoodLens'**
  String get appName;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0 (Global Release)'**
  String get appVersion;

  /// No description provided for @creatorTitle.
  ///
  /// In en, this message translates to:
  /// **'Created & Developed by'**
  String get creatorTitle;

  /// No description provided for @developerName.
  ///
  /// In en, this message translates to:
  /// **'CodeByArnob'**
  String get developerName;

  /// No description provided for @developerRole.
  ///
  /// In en, this message translates to:
  /// **'Original Creator & Lead Developer'**
  String get developerRole;

  /// No description provided for @viewGithubProfile.
  ///
  /// In en, this message translates to:
  /// **'View GitHub Profile'**
  String get viewGithubProfile;

  /// No description provided for @madeWithPassion.
  ///
  /// In en, this message translates to:
  /// **'Made with passion by CodeByArnob'**
  String get madeWithPassion;

  /// No description provided for @maintainerTitle.
  ///
  /// In en, this message translates to:
  /// **'Project Maintainer'**
  String get maintainerTitle;

  /// No description provided for @contributorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contributors & Open Source'**
  String get contributorsTitle;

  /// No description provided for @officialGithub.
  ///
  /// In en, this message translates to:
  /// **'Official GitHub Repository'**
  String get officialGithub;

  /// No description provided for @safetyDisclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'Safety & Nutritional Disclaimer'**
  String get safetyDisclaimerTitle;

  /// No description provided for @safetyDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'FoodLens AI estimates nutritional values and detects ingredients from visual imagery. It cannot guarantee the absence of cross-contamination or allergens, and must not be used as laboratory analysis or medical advice. Consult a healthcare professional for dietary prescriptions.'**
  String get safetyDisclaimer;

  /// No description provided for @insufficientFundsTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly Quota Exhausted'**
  String get insufficientFundsTitle;

  /// No description provided for @insufficientFundsDesc.
  ///
  /// In en, this message translates to:
  /// **'Your personal Puter AI allowance has run out. Please upgrade your Puter account or add credits.'**
  String get insufficientFundsDesc;

  /// No description provided for @upgradePuter.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Puter Account'**
  String get upgradePuter;

  /// No description provided for @aboutFoodLens.
  ///
  /// In en, this message translates to:
  /// **'About FoodLens'**
  String get aboutFoodLens;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @suggestedLocale.
  ///
  /// In en, this message translates to:
  /// **'Suggested Locale'**
  String get suggestedLocale;

  /// No description provided for @selectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Select Currency'**
  String get selectCurrency;

  /// No description provided for @localizationSection.
  ///
  /// In en, this message translates to:
  /// **'Localization & Region'**
  String get localizationSection;

  /// No description provided for @measurementSystem.
  ///
  /// In en, this message translates to:
  /// **'Measurement System'**
  String get measurementSystem;

  /// No description provided for @dietarySection.
  ///
  /// In en, this message translates to:
  /// **'Dietary Preferences & Goals'**
  String get dietarySection;

  /// No description provided for @dietaryFilters.
  ///
  /// In en, this message translates to:
  /// **'Dietary Filters'**
  String get dietaryFilters;

  /// No description provided for @dataManagement.
  ///
  /// In en, this message translates to:
  /// **'Storage & Data'**
  String get dataManagement;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @recentScans.
  ///
  /// In en, this message translates to:
  /// **'Recent Scans'**
  String get recentScans;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favorites;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'bn',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'ja',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'bn':
      return AppLocalizationsBn();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
