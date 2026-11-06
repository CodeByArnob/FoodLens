// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'ফুডলেন্স';

  @override
  String get tagline => 'এআই-চালিত খাদ্য বুদ্ধিমত্তা';

  @override
  String get navHome => 'হোম';

  @override
  String get navTracker => 'ট্র্যাকার';

  @override
  String get navScanner => 'স্ক্যান করুন';

  @override
  String get navMealPlan => 'মিল প্ল্যান';

  @override
  String get navProfile => 'প্রোফাইল';

  @override
  String get onboardingSkip => 'এড়িয়ে যান';

  @override
  String get onboardingContinue => 'পরবর্তী';

  @override
  String get onboardingGetStarted => 'শুরু করুন';

  @override
  String get onboardingTitle1 => 'যেকোনো খাবার, মেনু বা ফুড লেবেল স্ক্যান করুন';

  @override
  String get onboardingDesc1 =>
      'তাৎক্ষণিক এআই খাদ্য বিশ্লেষণ। আপনার ক্যামেরার সামনে রাখুন রান্না করা খাবার, রেস্তোরাঁর মেনু বা প্যাকেটজাত খাবার।';

  @override
  String get onboardingTitle2 => 'গভীর পুষ্টি ও স্বাস্থ্য বিশ্লেষণ';

  @override
  String get onboardingDesc2 =>
      'তাৎক্ষণিক ক্যালোরি হিসাব, প্রোটিন, কার্বস, ফ্যাট ও ফাইবারের অনুপাত এবং স্বাস্থ্য স্কোর পান।';

  @override
  String get onboardingTitle3 => 'ব্যক্তিগত খাদ্যাভ্যাস ও অ্যালার্জির সতর্কতা';

  @override
  String get onboardingDesc3 =>
      'হালাল, ভেগান, কিটো, গ্লুটেন-ফ্রি অনুযায়ী ফিল্টার করুন এবং সম্ভাব্য অ্যালার্জির সতর্কতা পান।';

  @override
  String get onboardingTitle4 => 'পিউটার (Puter) ক্লাউড এআই';

  @override
  String get onboardingDesc4 =>
      'আপনার নিজস্ব পিউটার অ্যাকাউন্ট দিয়ে পরিচালিত। ১০০% গোপনীয়তা এবং প্রতি মাসে বিনামূল্যে এআই টোকেন।';

  @override
  String get connectPuterTitle => 'পিউটার অ্যাকাউন্ট যুক্ত করুন';

  @override
  String get connectPuterSub => 'ব্যক্তিগত ক্লাউড খাদ্য বুদ্ধিমত্তা';

  @override
  String get connectPuterDesc =>
      'ফুডলেন্স পিউটার ক্লাউড আর্কিটেকচার ব্যবহার করে। আপনি আপনার ব্যক্তিগত অ্যাকাউন্ট যুক্ত করে বিনামূল্যে মাসিক এআই ব্যবহার করতে পারেন।';

  @override
  String get signInWithPuter => 'পিউটার দিয়ে সাইন ইন করুন';

  @override
  String get createFreePuterAccount => 'বিনামূল্যে পিউটার অ্যাকাউন্ট খুলুন';

  @override
  String get offlineMode => 'অফলাইন মোড';

  @override
  String get signInWithToken => 'পিউটার এপিআই টোকেন দিয়ে লগইন করুন';

  @override
  String get hideTokenLogin => 'টোকেন লগইন লুকান';

  @override
  String get tokenPlaceholder => 'puter.com/dashboard থেকে টোকেন পেস্ট করুন';

  @override
  String get connectWithToken => 'টোকেন দিয়ে যুক্ত করুন';

  @override
  String get paste => 'পেস্ট';

  @override
  String get getToken => 'টোকেন নিন ↗';

  @override
  String get greeting => 'স্বাগতম, ফুড এক্সপ্লোরার 👋';

  @override
  String get greetingSub => 'আপনার খাদ্যাভ্যাস ও পুষ্টির হিসাব রাখুন';

  @override
  String get todayNutritionSummary => 'আজকের পুষ্টি সারাংশ';

  @override
  String get kcalConsumed => 'ক্যালোরি গ্রহণ';

  @override
  String get kcalLeft => 'বাকি আছে';

  @override
  String get protein => 'প্রোটিন';

  @override
  String get carbs => 'কার্বস';

  @override
  String get fat => 'ফ্যাট';

  @override
  String get fiber => 'ফাইবার';

  @override
  String get waterHydration => 'পানি পানের পরিমাণ';

  @override
  String get addWater => '+২৫০ মিলি পানি';

  @override
  String get foodTools => 'খাদ্য বিশ্লেষণ টুলস';

  @override
  String get foodCompare => 'খাবারের তুলনা';

  @override
  String get foodCompareSub => 'পাশাপাশি পুষ্টির তুলনা';

  @override
  String get menuExplorer => 'মেনু এক্সপ্লোরার';

  @override
  String get menuExplorerSub => 'রেস্তোরাঁর মেনু স্ক্যান';

  @override
  String get scanHistory => 'স্ক্যান ইতিহাস';

  @override
  String get favourites => 'পছন্দের খাবার';

  @override
  String scansCount(int count) {
    return '$countটি স্ক্যান';
  }

  @override
  String savedCount(int count) {
    return '$countটি সংরক্ষিত';
  }

  @override
  String get recommendedForGoals => 'আপনার লক্ষ্যের জন্য সুপারিশকৃত';

  @override
  String get viewAll => 'সবগুলো দেখুন';

  @override
  String get dishMode => 'খাবার';

  @override
  String get menuMode => 'মেনু';

  @override
  String get labelMode => 'লেবেল রিডার';

  @override
  String get alignFoodPrompt =>
      'সঠিক ফলাফলের জন্য খাবারের প্লেট ফ্রেমের মাঝে রাখুন';

  @override
  String get alignMenuPrompt => 'রেস্তোরাঁর মেনুর ওপর ক্যামেরা তাক করুন';

  @override
  String get alignLabelPrompt => 'প্যাকেটের পুষ্টি তথ্যের ওপর ফোকাস করুন';

  @override
  String get takePhoto => 'ছবি তুলুন';

  @override
  String get uploadGallery => 'গ্যালারি থেকে নিন';

  @override
  String get analyzingFood => 'খাদ্যের পুষ্টি বিশ্লেষণ করা হচ্ছে...';

  @override
  String get healthIndex => 'স্বাস্থ্য সূচক';

  @override
  String get score => 'স্কোর';

  @override
  String get aiEstimate => 'এআই অনুমান';

  @override
  String get verifiedLabel => 'যাচাইকৃত লেবেল';

  @override
  String get macroBreakdown => 'ম্যাক্রোনিউট্রিয়েন্ট বিশ্লেষণ';

  @override
  String get microBreakdown => 'মাইক্রোনিউট্রিয়েন্ট ও ভিটামিন';

  @override
  String get sugar => 'চিনি';

  @override
  String get saturatedFat => 'স্যাচুরেটেড ফ্যাট';

  @override
  String get sodium => 'সোডিয়াম';

  @override
  String get potassium => 'পটাশিয়াম';

  @override
  String get calcium => 'ক্যালসিয়াম';

  @override
  String get iron => 'আয়রন';

  @override
  String get vitaminC => 'ভিটামিন সি';

  @override
  String get ingredients => 'প্রধান উপাদানসমূহ';

  @override
  String get healthierAlternatives => 'স্বাস্থ্যকর বিকল্প খাবার';

  @override
  String get portionSize => 'পরিমাণ';

  @override
  String get logMeal => 'মিল যোগ করুন';

  @override
  String get originalPrice => 'মূল মূল্য';

  @override
  String get convertedPrice => 'রূপান্তরিত মূল্য';

  @override
  String exchangeRateSource(String source) {
    return '$source থেকে বিনিময় হার আপডেট করা হয়েছে';
  }

  @override
  String get menuExplorerTitle => 'রেস্তোরাঁ মেনু এক্সপ্লোরার';

  @override
  String get scanPhysicalMenu => 'একটি কাগজের মেনু স্ক্যান করুন';

  @override
  String get scanMenuDesc =>
      'কাগজের মেনু বা খাবার তালিকা স্ক্যান করে পুষ্টি ও দাম দেখুন।';

  @override
  String get scanMenuBtn => 'ক্যামেরা দিয়ে মেনু স্ক্যান করুন';

  @override
  String get curatedDemos => 'নমুনা রেস্তোরাঁ মেনু';

  @override
  String get detectedDishes => 'শনাক্তকৃত খাবার ও পুষ্টি';

  @override
  String get allItems => 'সব খাবার';

  @override
  String get highProtein => 'উচ্চ প্রোটিন (২৫ গ্রাম+)';

  @override
  String get lowCalorie => 'কম ক্যালোরি (<৫০০ ক্যালোরি)';

  @override
  String get settingsTitle => 'সেটিংস ও পছন্দসমূহ';

  @override
  String get appearanceSection => 'চেহারা ও ডিসপ্লে';

  @override
  String get appearanceDesc => 'ডার্ক মোড ও থিম পরিবর্তন করুন';

  @override
  String get themeMode => 'থিম মোড';

  @override
  String get darkMode => 'ডার্ক মোড';

  @override
  String get lightMode => 'লাইট মোড';

  @override
  String get systemDefault => 'সিস্টেম ডিফল্ট';

  @override
  String get languageRegionSection => 'ভাষা ও অঞ্চল';

  @override
  String get languageRegionDesc => 'অ্যাপের ভাষা, দেশ ও অঞ্চলের ফরম্যাট';

  @override
  String get language => 'অ্যাপের ভাষা';

  @override
  String get countryRegion => 'দেশ / অঞ্চল';

  @override
  String get timeZone => 'টাইম জোন';

  @override
  String get currencyLocalizationSection => 'মুদ্রা ও মূল্য রূপান্তর';

  @override
  String get currencyLocalizationDesc =>
      'লাইভ রেটে বিনিময় মূল্য ও মুদ্রা প্রদর্শন';

  @override
  String get currency => 'পছন্দের মুদ্রা';

  @override
  String get exchangeRates => 'লাইভ বিনিময় হার';

  @override
  String get measurementSystemSection => 'পরিমাপ পদ্ধতি';

  @override
  String get measurementSystemDesc =>
      'মেট্রিক (গ্রাম, মিলি) বনাম ইম্পেরিয়াল (আউন্স)';

  @override
  String get unitSystem => 'একক পদ্ধতি';

  @override
  String get metric => 'মেট্রিক (গ্রাম, মিলি, কেজি)';

  @override
  String get imperial => 'ইম্পেরিয়াল (আউন্স, পাউন্ড)';

  @override
  String get dietaryPreferencesSection => 'খাদ্যাভ্যাস ও ফিল্টার';

  @override
  String get dietaryPreferencesDesc =>
      'হালাল, নিরামিষ, কিটো ও অ্যালার্জি ফিল্টার';

  @override
  String get dailyCalorieGoal => 'দৈনিক ক্যালোরি লক্ষ্য';

  @override
  String get notificationsSection => 'নোটিফিকেশন';

  @override
  String get notificationsDesc => 'পানি পান ও খাবার লগ করার রিমাইন্ডার';

  @override
  String get hydrationReminders => 'পানি পানের রিমাইন্ডার';

  @override
  String get mealReminders => 'খাবার লগের সতর্কতা';

  @override
  String get privacySecuritySection => 'গোপনীয়তা ও নিরাপত্তা';

  @override
  String get privacySecurityDesc => 'পিউটার ক্লাউড কি ও ডেটা নিয়ন্ত্রণ';

  @override
  String get puterAccount => 'পিউটার (Puter.js) অ্যাকাউন্ট';

  @override
  String get connected => 'সংযুক্ত';

  @override
  String get disconnected => 'বিচ্ছিন্ন (অফলাইন মোড)';

  @override
  String get storageDataSection => 'স্টোরেজ ও ক্যাশ';

  @override
  String get storageDataDesc => 'অফলাইন ক্যাশ ও সংরক্ষিত খাবারের হিসাব';

  @override
  String get clearCache => 'স্থানীয় ক্যাশ মুছে ফেলুন';

  @override
  String get cacheCleared => 'স্থানীয় ক্যাশ সফলভাবে মুছে ফেলা হয়েছে।';

  @override
  String get aboutSection => 'ফুডলেন্স সম্পর্কে';

  @override
  String get aboutDesc => 'ডেভেলপারের পরিচয়, সংস্করণ ও তথ্য';

  @override
  String get aboutTitle => 'ফুডলেন্স সম্পর্কে';

  @override
  String get appName => 'ফুডলেন্স';

  @override
  String get appVersion => 'ভার্সন ১.০.০ (গ্লোবাল রিলিজ)';

  @override
  String get creatorTitle => 'তৈরি ও ডেভেলপ করেছেন';

  @override
  String get developerName => 'CodeByArnob';

  @override
  String get developerRole => 'মূল নির্মাতা ও প্রধান ডেভেলপার';

  @override
  String get viewGithubProfile => 'গিটহাব প্রোফাইল দেখুন';

  @override
  String get madeWithPassion => 'CodeByArnob দ্বারা ভালোবাসায় নির্মিত ❤️';

  @override
  String get maintainerTitle => 'প্রজেক্ট মেইনটেইনার';

  @override
  String get contributorsTitle => 'অবদানকারী ও ওপেন সোর্স';

  @override
  String get officialGithub => 'অফিসিয়াল গিটহাব রিপোজিটরি';

  @override
  String get safetyDisclaimerTitle =>
      'স্বাস্থ্য ও পুষ্টি সংক্রান্ত সতর্কবার্তা';

  @override
  String get safetyDisclaimer =>
      'ফুডলেন্স এআই ছবির মাধ্যমে পুষ্টির অনুমান করে। এটি খাবারে অ্যালার্জেন বা উপাদানের সম্পূর্ণ নিশ্চিতকরণ দিতে পারে না এবং এটি কোনো চিকিৎসা পরামর্শ নয়। যেকোনো খাদ্যতালিকা নির্ধারণে চিকিৎসকের পরামর্শ নিন।';

  @override
  String get insufficientFundsTitle => 'মাসিক কোটা শেষ হয়েছে';

  @override
  String get insufficientFundsDesc =>
      'আপনার ব্যক্তিগত পিউটার এআই কোটা শেষ হয়েছে। অনুগ্রহ করে পুটার অ্যাকাউন্টে ক্রেডিট যোগ করুন।';

  @override
  String get upgradePuter => 'পিউটার অ্যাকাউন্ট আপগ্রেড করুন';

  @override
  String get aboutFoodLens => 'ফুডলেন্স সম্পর্কে';

  @override
  String get selectLanguage => 'ভাষা নির্বাচন করুন';

  @override
  String get suggestedLocale => 'প্রস্তাবিত ভাষা';

  @override
  String get selectCurrency => 'মুদ্রা নির্বাচন করুন';

  @override
  String get localizationSection => 'ভাষা ও অঞ্চল';

  @override
  String get measurementSystem => 'পরিমাপ পদ্ধতি';

  @override
  String get dietarySection => 'খাদ্যাভ্যাস ও লক্ষ্য';

  @override
  String get dietaryFilters => 'খাদ্য ফিল্টার';

  @override
  String get dataManagement => 'স্টোরেজ ও ডেটা';

  @override
  String get cancel => 'বাতিল';

  @override
  String get clear => 'মুছে ফেলুন';

  @override
  String get recentScans => 'সাম্প্রতিক স্ক্যান';

  @override
  String get favorites => 'পছন্দসমূহ';
}
