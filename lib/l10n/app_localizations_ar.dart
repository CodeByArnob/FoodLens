// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'فودلينز';

  @override
  String get tagline => 'ذكاء غذائي مدعوم بالذكاء الاصطناعي';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navTracker => 'المتتبع';

  @override
  String get navScanner => 'مسح الطعام';

  @override
  String get navMealPlan => 'خطة الوجبات';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get onboardingSkip => 'تخطي';

  @override
  String get onboardingContinue => 'متابعة';

  @override
  String get onboardingGetStarted => 'ابدأ الآن';

  @override
  String get onboardingTitle1 => 'امسح أي طبق أو قائمة أو ملصق طعام';

  @override
  String get onboardingDesc1 =>
      'تحليل فوري للذكاء الغذائي. وجّه الكاميرا نحو الوجبات أو قوائم المطاعم.';

  @override
  String get onboardingTitle2 => 'تحليلات غذائية وصحية عميقة';

  @override
  String get onboardingDesc2 =>
      'احصل على تقديرات فورية للسعرات الحرارية وتوزيع المغذيات الكبرى.';

  @override
  String get onboardingTitle3 => 'أمان غذائي مخصص وتحذير من مسببات الحساسية';

  @override
  String get onboardingDesc3 =>
      'تصفية حسب الحلال والنباتي والكيتو وتحذيرات استباقية من مسببات الحساسية.';

  @override
  String get onboardingTitle4 => 'ذكاء اصطناعي لا مركزي مع Puter.js';

  @override
  String get onboardingDesc4 =>
      'مدعوم بحساب Puter الخاص بك مع خصوصية تامة وحصة شهرية مجانية.';

  @override
  String get connectPuterTitle => 'ربط حساب Puter';

  @override
  String get connectPuterSub => 'سحابة الذكاء الغذائي الشخصية';

  @override
  String get connectPuterDesc =>
      'يستخدم FoodLens بنية Puter.js لحماية خصوصيتك واستهلاك حصتك المجانية.';

  @override
  String get signInWithPuter => 'تسجيل الدخول عبر Puter';

  @override
  String get createFreePuterAccount => 'إنشاء حساب Puter مجاني';

  @override
  String get offlineMode => 'الوضع غير المتصل';

  @override
  String get signInWithToken => 'تسجيل الدخول برمز API';

  @override
  String get hideTokenLogin => 'إخفاء تسجيل الدخول بالرمز';

  @override
  String get tokenPlaceholder => 'الصق الرمز هنا';

  @override
  String get connectWithToken => 'اتصال بالرمز';

  @override
  String get paste => 'لصق';

  @override
  String get getToken => 'الحصول على رمز ↗';

  @override
  String get greeting => 'مرحباً، مستكشف الطعام 👋';

  @override
  String get greetingSub => 'تتبع وحسّن ذكائك الغذائي';

  @override
  String get todayNutritionSummary => 'ملخص التغذية اليوم';

  @override
  String get kcalConsumed => 'سعرة حرارية مستهلكة';

  @override
  String get kcalLeft => 'متبقي';

  @override
  String get protein => 'بروتين';

  @override
  String get carbs => 'كربوهيدرات';

  @override
  String get fat => 'دهون';

  @override
  String get fiber => 'ألياف';

  @override
  String get waterHydration => 'ترطيب الماء';

  @override
  String get addWater => '+250 مل ماء';

  @override
  String get foodTools => 'أدوات الذكاء الغذائي';

  @override
  String get foodCompare => 'مقارنة الأطعمة';

  @override
  String get foodCompareSub => 'إحصائيات جنباً إلى جنب';

  @override
  String get menuExplorer => 'مستكشف القوائم';

  @override
  String get menuExplorerSub => 'تحليل قوائم الطعام';

  @override
  String get scanHistory => 'سجل المسح';

  @override
  String get favourites => 'المفضلة';

  @override
  String scansCount(int count) {
    return '$count مسح';
  }

  @override
  String savedCount(int count) {
    return '$count محفوظ';
  }

  @override
  String get recommendedForGoals => 'موصى به لأهدافك';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get dishMode => 'طبق';

  @override
  String get menuMode => 'قائمة';

  @override
  String get labelMode => 'ملصق غذائي';

  @override
  String get alignFoodPrompt => 'ضع الطبق داخل الإطار للحصول على أفضل دقة';

  @override
  String get alignMenuPrompt => 'وجّه الكاميرا نحو نص القائمة';

  @override
  String get alignLabelPrompt => 'ركّز على جدول الحقائق الغذائية';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get uploadGallery => 'رفع من المعرض';

  @override
  String get analyzingFood => 'جارٍ تحليل الذكاء الغذائي...';

  @override
  String get healthIndex => 'مؤشر الصحة';

  @override
  String get score => 'النتيجة';

  @override
  String get aiEstimate => 'تقدير الذكاء الاصطناعي';

  @override
  String get verifiedLabel => 'ملصق موثوق';

  @override
  String get macroBreakdown => 'توزيع المغذيات الكبرى';

  @override
  String get microBreakdown => 'المغذيات الصغرى والفيتامينات';

  @override
  String get sugar => 'سكر';

  @override
  String get saturatedFat => 'دهون مشبعة';

  @override
  String get sodium => 'صوديوم';

  @override
  String get potassium => 'بوتاسيوم';

  @override
  String get calcium => 'كالسيوم';

  @override
  String get iron => 'حديد';

  @override
  String get vitaminC => 'فيتامين ج';

  @override
  String get ingredients => 'المكونات الأساسية';

  @override
  String get healthierAlternatives => 'بدائل صحية أكثر';

  @override
  String get portionSize => 'حجم الحصة';

  @override
  String get logMeal => 'تسجيل الوجبة';

  @override
  String get originalPrice => 'السعر الأصلي';

  @override
  String get convertedPrice => 'السعر المحول';

  @override
  String exchangeRateSource(String source) {
    return 'تم تحديث سعر الصرف عبر $source';
  }

  @override
  String get menuExplorerTitle => 'مستكشف قوائم المطاعم';

  @override
  String get scanPhysicalMenu => 'مسح قائمة ورقية';

  @override
  String get scanMenuDesc => 'وجّه الكاميرا لاستخراج الأطباق وتقديرات التغذية.';

  @override
  String get scanMenuBtn => 'مسح القائمة بالكاميرا';

  @override
  String get curatedDemos => 'قوائم ونماذج تجريبية';

  @override
  String get detectedDishes => 'الأطباق المكتشفة والقيم الغذائية';

  @override
  String get allItems => 'جميع العناصر';

  @override
  String get highProtein => 'عالي البروتين (25 غرام+)';

  @override
  String get lowCalorie => 'قليل السعرات (<500 سعرة)';

  @override
  String get settingsTitle => 'الإعدادات والتفضيلات';

  @override
  String get appearanceSection => 'المظهر';

  @override
  String get appearanceDesc => 'تخصيص السمات والوضع الداكن والراحة البصرية';

  @override
  String get themeMode => 'وضع السمة';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get lightMode => 'الوضع الفاتح';

  @override
  String get systemDefault => 'افتراضي النظام';

  @override
  String get languageRegionSection => 'اللغة والمنطقة';

  @override
  String get languageRegionDesc => 'لغة عرض التطبيق وتفضيلات الدولة والتنسيقات';

  @override
  String get language => 'لغة التطبيق';

  @override
  String get countryRegion => 'البلد / المنطقة';

  @override
  String get timeZone => 'المنطقة الزمنية';

  @override
  String get currencyLocalizationSection => 'العملة والتسعير';

  @override
  String get currencyLocalizationDesc =>
      'تحويل أسعار الصرف المباشرة وعرض الأسعار';

  @override
  String get currency => 'العملة المفضلة';

  @override
  String get exchangeRates => 'أسعار الصرف المباشرة';

  @override
  String get measurementSystemSection => 'نظام القياس';

  @override
  String get measurementSystemDesc =>
      'المتري (جرام، مل) مقابل الإمبراطوري (أونصة)';

  @override
  String get unitSystem => 'نظام الوحدات';

  @override
  String get metric => 'متري (جرام، مل، كجم)';

  @override
  String get imperial => 'إمبراطوري (أونصة، رطل)';

  @override
  String get dietaryPreferencesSection => 'التفضيلات الغذائية';

  @override
  String get dietaryPreferencesDesc =>
      'الحلال، النباتي، الكيتو، ومسببات الحساسية';

  @override
  String get dailyCalorieGoal => 'هدف السعرات الحرارية اليومي';

  @override
  String get notificationsSection => 'الإشعارات';

  @override
  String get notificationsDesc => 'تذكيرات تسجيل الوجبات وشرب الماء';

  @override
  String get hydrationReminders => 'تذكيرات شرب الماء';

  @override
  String get mealReminders => 'تنبيهات تسجيل الوجبات';

  @override
  String get privacySecuritySection => 'الخصوصية والأمان';

  @override
  String get privacySecurityDesc =>
      'مفاتيح Puter السحابية اللامركزية والتحكم في البيانات';

  @override
  String get puterAccount => 'حساب Puter.js';

  @override
  String get connected => 'متصل';

  @override
  String get disconnected => 'غير متصل (الوضع غير المتصل)';

  @override
  String get storageDataSection => 'التخزين والبيانات';

  @override
  String get storageDataDesc =>
      'ذاكرة التخزين المؤقت المحلية وإدارة الأطباق المحفوظة';

  @override
  String get clearCache => 'مسح الذاكرة المؤقتة المحلية';

  @override
  String get cacheCleared => 'تم مسح الذاكرة المؤقتة بنجاح.';

  @override
  String get aboutSection => 'حول FoodLens';

  @override
  String get aboutDesc => 'ملف المطور واعتمادات المنشئ والإصدار';

  @override
  String get aboutTitle => 'حول FoodLens';

  @override
  String get appName => 'FoodLens';

  @override
  String get appVersion => 'الإصدار 1.0.0 (الإصدار العالمي)';

  @override
  String get creatorTitle => 'تم إنشاؤه وتطويره بواسطة';

  @override
  String get developerName => 'CodeByArnob';

  @override
  String get developerRole => 'المبتكر الأصلي والمطور الرئيسي';

  @override
  String get viewGithubProfile => 'عرض الملف الشخصي على GitHub';

  @override
  String get madeWithPassion => 'صُنِع بشغف بواسطة CodeByArnob ❤️';

  @override
  String get maintainerTitle => 'المشرف على المشروع';

  @override
  String get contributorsTitle => 'المساهمون والمصادر المفتوحة';

  @override
  String get officialGithub => 'مستودع GitHub الرسمي';

  @override
  String get safetyDisclaimerTitle => 'إخلاء المسؤولية الصحية والغذائية';

  @override
  String get safetyDisclaimer =>
      'يقدّر FoodLens القيم الغذائية بناءً على الصور. لا يمكن ضمان خلو الوجبات من مسببات الحساسية أو التلوث المتبادل، ولا يُعد ذلك استشارة طبية.';

  @override
  String get insufficientFundsTitle => 'نفدت الحصة الشهرية';

  @override
  String get insufficientFundsDesc =>
      'نفد رصيد الذكاء الاصطناعي لحساب Puter الخاص بك. يُرجى ترقية الحساب أو شراء رصيد.';

  @override
  String get upgradePuter => 'ترقية حساب Puter';

  @override
  String get aboutFoodLens => 'حول FoodLens';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get suggestedLocale => 'اللغة المقترحة';

  @override
  String get selectCurrency => 'اختر العملة';

  @override
  String get localizationSection => 'اللغة والمنطقة';

  @override
  String get measurementSystem => 'نظام القياس';

  @override
  String get dietarySection => 'التفضيلات والأهداف الغذائية';

  @override
  String get dietaryFilters => 'تصفية الأطعمة';

  @override
  String get dataManagement => 'التخزين والبيانات';

  @override
  String get cancel => 'إلغاء';

  @override
  String get clear => 'مسح';

  @override
  String get recentScans => 'عمليات المسح الأخيرة';

  @override
  String get favorites => 'المفضلة';
}
