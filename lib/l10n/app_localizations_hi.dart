// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'फूडलेंस';

  @override
  String get tagline => 'एआई-संचालित खाद्य बुद्धिमत्ता';

  @override
  String get navHome => 'होम';

  @override
  String get navTracker => 'ट्रैकर';

  @override
  String get navScanner => 'स्कैन करें';

  @override
  String get navMealPlan => 'भोजन योजना';

  @override
  String get navProfile => 'प्रोफाइल';

  @override
  String get onboardingSkip => 'छोड़ें';

  @override
  String get onboardingContinue => 'आगे बढ़ें';

  @override
  String get onboardingGetStarted => 'शुरू करें';

  @override
  String get onboardingTitle1 => 'किसी भी व्यंजन, मेनू या लेबल को स्कैन करें';

  @override
  String get onboardingDesc1 =>
      'तुरंत एआई पोषण विश्लेषण। अपने कैमरे को खाने की थाली या मेनू के सामने लाएं।';

  @override
  String get onboardingTitle2 => 'गहरा पोषण और स्वास्थ्य विश्लेषण';

  @override
  String get onboardingDesc2 =>
      'कैलोरी, प्रोटीन, कार्ब्स, फैट और स्वास्थ्य स्कोर तुरंत प्राप्त करें।';

  @override
  String get onboardingTitle3 => 'व्यक्तिगत आहार और एलर्जी सुरक्षा';

  @override
  String get onboardingDesc3 =>
      'हलाल, शाकाहारी, कीटो, ग्लूटेन-फ्री अनुसार फ़िल्टर करें और एलर्जी से सावधान रहें।';

  @override
  String get onboardingTitle4 => 'Puter.js द्वारा विकेंद्रीकृत क्लाउड एआई';

  @override
  String get onboardingDesc4 =>
      'आपके अपने Puter खाते द्वारा संचालित। पूर्ण गोपनीयता और हर महीने मुफ्त एआई कोटा।';

  @override
  String get connectPuterTitle => 'Puter खाता जोड़ें';

  @override
  String get connectPuterSub => 'व्यक्तिगत खाद्य खुफिया क्लाउड';

  @override
  String get connectPuterDesc =>
      'FoodLens Puter.js उपयोगकर्ता-भुगतान तकनीक का उपयोग करता है।';

  @override
  String get signInWithPuter => 'Puter से साइन इन करें';

  @override
  String get createFreePuterAccount => 'मुफ्त Puter खाता बनाएं';

  @override
  String get offlineMode => 'ऑफ़लाइन मोड';

  @override
  String get signInWithToken => 'Puter API टोकन से साइन इन करें';

  @override
  String get hideTokenLogin => 'टोकन लॉगिन छिपाएं';

  @override
  String get tokenPlaceholder => 'puter.com/dashboard से टोकन पेस्ट करें';

  @override
  String get connectWithToken => 'टोकन से कनेक्ट करें';

  @override
  String get paste => 'पेस्ट करें';

  @override
  String get getToken => 'टोकन प्राप्त करें ↗';

  @override
  String get greeting => 'नमस्ते, फूड एक्सप्लोरर 👋';

  @override
  String get greetingSub => 'अपने दैनिक पोषण और आहार पर नज़र रखें';

  @override
  String get todayNutritionSummary => 'आज का पोषण सारांश';

  @override
  String get kcalConsumed => 'kcal कैलोरी ली';

  @override
  String get kcalLeft => 'शेष';

  @override
  String get protein => 'प्रोटीन';

  @override
  String get carbs => 'कार्ब्स';

  @override
  String get fat => 'फैट';

  @override
  String get fiber => 'फाइबर';

  @override
  String get waterHydration => 'जल सेवन';

  @override
  String get addWater => '+250 मिली पानी';

  @override
  String get foodTools => 'खाद्य खुफिया टूल्स';

  @override
  String get foodCompare => 'खाने की तुलना';

  @override
  String get foodCompareSub => 'पोषण तुलना देखें';

  @override
  String get menuExplorer => 'मेनू एक्सप्लोरर';

  @override
  String get menuExplorerSub => 'रेस्टोरेंट मेनू विश्लेषण';

  @override
  String get scanHistory => 'स्कैन इतिहास';

  @override
  String get favourites => 'पसंदीदा व्यंजन';

  @override
  String scansCount(int count) {
    return '$count स्कैन';
  }

  @override
  String savedCount(int count) {
    return '$count सुरक्षित';
  }

  @override
  String get recommendedForGoals => 'आपके लक्ष्यों के लिए अनुशंसित';

  @override
  String get viewAll => 'सभी देखें';

  @override
  String get dishMode => 'व्यंजन';

  @override
  String get menuMode => 'मेनू';

  @override
  String get labelMode => 'लेबल OCR';

  @override
  String get alignFoodPrompt => 'सटीक परिणाम के लिए थाली को फ्रेम के बीच रखें';

  @override
  String get alignMenuPrompt => 'कैमरे को मेनू कार्ड पर केंद्रित करें';

  @override
  String get alignLabelPrompt => 'पैकेट पर पोषण तालिका पर ध्यान केंद्रित करें';

  @override
  String get takePhoto => 'फोटो लें';

  @override
  String get uploadGallery => 'गैलरी से चुनें';

  @override
  String get analyzingFood => 'भोजन विश्लेषण जारी है...';

  @override
  String get healthIndex => 'स्वास्थ्य सूचकांक';

  @override
  String get score => 'स्कोर';

  @override
  String get aiEstimate => 'एआई अनुमान';

  @override
  String get verifiedLabel => 'सत्यापित लेबल';

  @override
  String get macroBreakdown => 'मैक्रोन्यूट्रिएंट्स का विवरण';

  @override
  String get microBreakdown => 'माइक्रोन्यूट्रिएंट्स और विटामिन';

  @override
  String get sugar => 'चीनी';

  @override
  String get saturatedFat => 'संतृप्त वसा';

  @override
  String get sodium => 'सोडियम';

  @override
  String get potassium => 'पोटेशियम';

  @override
  String get calcium => 'कैल्शियम';

  @override
  String get iron => 'आयरन';

  @override
  String get vitaminC => 'विटामिन सी';

  @override
  String get ingredients => 'मुख्य सामग्री';

  @override
  String get healthierAlternatives => 'स्वस्थ विकल्प';

  @override
  String get portionSize => 'मात्रा';

  @override
  String get logMeal => 'भोजन जोड़ें';

  @override
  String get originalPrice => 'मूल मूल्य';

  @override
  String get convertedPrice => 'परिवर्तित मूल्य';

  @override
  String exchangeRateSource(String source) {
    return '$source द्वारा विनिमय दर अपडेट की गई';
  }

  @override
  String get menuExplorerTitle => 'रेस्टोरेंट मेनू एक्सप्लोरर';

  @override
  String get scanPhysicalMenu => 'कागजी मेनू स्कैन करें';

  @override
  String get scanMenuDesc =>
      'किसी भी मेनू कार्ड को स्कैन करके व्यंजन और पोषण देखें।';

  @override
  String get scanMenuBtn => 'कैमरे से मेनू स्कैन करें';

  @override
  String get curatedDemos => 'नमूना मेनू और डेमो';

  @override
  String get detectedDishes => 'पहचाने गए व्यंजन और पोषण';

  @override
  String get allItems => 'सभी व्यंजन';

  @override
  String get highProtein => 'उच्च प्रोटीन (25g+)';

  @override
  String get lowCalorie => 'कम कैलोरी (<500 kcal)';

  @override
  String get settingsTitle => 'सेटिंग्स और प्राथमिकताएं';

  @override
  String get appearanceSection => 'दिखावट';

  @override
  String get appearanceDesc => 'थीम और डार्क मोड अनुकूलित करें';

  @override
  String get themeMode => 'थीम मोड';

  @override
  String get darkMode => 'डार्क मोड';

  @override
  String get lightMode => 'लाइट मोड';

  @override
  String get systemDefault => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get languageRegionSection => 'भाषा और क्षेत्र';

  @override
  String get languageRegionDesc => 'ऐप भाषा, देश और प्रारूप सेटिंग्स';

  @override
  String get language => 'ऐप की भाषा';

  @override
  String get countryRegion => 'देश / क्षेत्र';

  @override
  String get timeZone => 'समय क्षेत्र';

  @override
  String get currencyLocalizationSection => 'मुद्रा और मूल्य निर्धारण';

  @override
  String get currencyLocalizationDesc => 'लाइव विनिमय दर और मूल्य प्रदर्शन';

  @override
  String get currency => 'पसंदीदा मुद्रा';

  @override
  String get exchangeRates => 'लाइव विनिमय दरें';

  @override
  String get measurementSystemSection => 'माप प्रणाली';

  @override
  String get measurementSystemDesc =>
      'मीट्रिक (ग्राम, मिली) बनाम इंपीरियल (औंस)';

  @override
  String get unitSystem => 'इकाई प्रणाली';

  @override
  String get metric => 'मीट्रिक (ग्राम, मिली, किलोग्राम)';

  @override
  String get imperial => 'इंपीरियल (औंस, पाउंड)';

  @override
  String get dietaryPreferencesSection => 'आहार प्राथमिकताएं';

  @override
  String get dietaryPreferencesDesc => 'हलाल, शाकाहारी, कीटो, एलर्जी और लक्ष्य';

  @override
  String get dailyCalorieGoal => 'दैनिक कैलोरी लक्ष्य';

  @override
  String get notificationsSection => 'सूचनाएं';

  @override
  String get notificationsDesc => 'भोजन और पानी पीने के अनुस्मारक';

  @override
  String get hydrationReminders => 'जल सेवन अनुस्मारक';

  @override
  String get mealReminders => 'भोजन लॉग अनुस्मारक';

  @override
  String get privacySecuritySection => 'गोपनीयता और सुरक्षा';

  @override
  String get privacySecurityDesc =>
      'Puter विकेंद्रीकृत क्लाउड और डेटा नियंत्रण';

  @override
  String get puterAccount => 'Puter.js खाता';

  @override
  String get connected => 'संबद्ध';

  @override
  String get disconnected => 'असंलग्न (ऑफ़लाइन मोड)';

  @override
  String get storageDataSection => 'भंडारण और डेटा';

  @override
  String get storageDataDesc => 'लोकल कैश और पसंदीदा व्यंजनों का प्रबंधन';

  @override
  String get clearCache => 'लोकल कैश साफ़ करें';

  @override
  String get cacheCleared => 'लोकल कैश सफलतापूर्वक साफ़ किया गया।';

  @override
  String get aboutSection => 'FoodLens के बारे में';

  @override
  String get aboutDesc => 'डेवलपर प्रोफाइल, निर्माता परिचय और संस्करण';

  @override
  String get aboutTitle => 'FoodLens के बारे में';

  @override
  String get appName => 'FoodLens';

  @override
  String get appVersion => 'संस्करण 1.0.0 (वैश्विक रिलीज)';

  @override
  String get creatorTitle => 'निर्माता और डेवलपर';

  @override
  String get developerName => 'CodeByArnob';

  @override
  String get developerRole => 'मूल निर्माता और मुख्य डेवलपर';

  @override
  String get viewGithubProfile => 'GitHub प्रोफाइल देखें';

  @override
  String get madeWithPassion => 'CodeByArnob द्वारा प्यार से निर्मित ❤️';

  @override
  String get maintainerTitle => 'प्रोजेक्ट मेंटेनर';

  @override
  String get contributorsTitle => 'योगदानकर्ता और ओपन सोर्स';

  @override
  String get officialGithub => 'आधिकारिक GitHub रिपॉजिटरी';

  @override
  String get safetyDisclaimerTitle => 'स्वास्थ्य और पोषण अस्वीकरण';

  @override
  String get safetyDisclaimer =>
      'FoodLens दृश्य विश्लेषण से पोषण का अनुमान लगाता है। यह एलर्जी से मुक्ति की गारंटी नहीं देता और चिकित्सा सलाह नहीं है।';

  @override
  String get insufficientFundsTitle => 'मासिक कोटा समाप्त';

  @override
  String get insufficientFundsDesc =>
      'आपका मासिक Puter एआई कोटा समाप्त हो गया है। कृपया अपना खाता अपग्रेड करें।';

  @override
  String get upgradePuter => 'Puter खाता अपग्रेड करें';

  @override
  String get aboutFoodLens => 'FoodLens के बारे में';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get suggestedLocale => 'सुझाई गई भाषा';

  @override
  String get selectCurrency => 'मुद्रा चुनें';

  @override
  String get localizationSection => 'भाषा और क्षेत्र';

  @override
  String get measurementSystem => 'माप प्रणाली';

  @override
  String get dietarySection => 'आहार प्राथमिकताएं और लक्ष्य';

  @override
  String get dietaryFilters => 'आहार फिल्टर';

  @override
  String get dataManagement => 'संग्रहण और डेटा';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get clear => 'साफ़ करें';

  @override
  String get recentScans => 'हाल के स्कैन';

  @override
  String get favorites => 'पसंदीदा';
}
