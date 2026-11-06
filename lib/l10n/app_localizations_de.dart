// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'FoodLens';

  @override
  String get tagline => 'KI-gestützte Ernährungsintelligenz';

  @override
  String get navHome => 'Startseite';

  @override
  String get navTracker => 'Tracker';

  @override
  String get navScanner => 'Scannen';

  @override
  String get navMealPlan => 'Ernährungsplan';

  @override
  String get navProfile => 'Profil';

  @override
  String get onboardingSkip => 'Überspringen';

  @override
  String get onboardingContinue => 'Weiter';

  @override
  String get onboardingGetStarted => 'Loslegen';

  @override
  String get onboardingTitle1 => 'Scanne Gerichte, Speisekarten oder Etiketten';

  @override
  String get onboardingDesc1 =>
      'Sofortige KI-Lebensmittelanalyse. Richte deine Kamera auf Mahlzeiten oder Menüs.';

  @override
  String get onboardingTitle2 => 'Detaillierte Nährwert- & Gesundheitsanalysen';

  @override
  String get onboardingDesc2 =>
      'Erhalte sofortige Kalorienschätzungen, Makronährstoffverteilung und Gesundheitsscores.';

  @override
  String get onboardingTitle3 => 'Personalisierte Diät- & Allergensicherheit';

  @override
  String get onboardingDesc3 =>
      'Filtere nach Halal, Vegan, Keto, Glutenfrei und erhalte Allergenwarnungen.';

  @override
  String get onboardingTitle4 => 'Dezentrale KI mit Puter.js';

  @override
  String get onboardingDesc4 =>
      'Unterstützt durch dein persönliches Puter-Konto mit kostenlosem monatlichem Kontingent.';

  @override
  String get connectPuterTitle => 'Puter-Konto Verbinden';

  @override
  String get connectPuterSub => 'Persönliche Ernährungs-Cloud';

  @override
  String get connectPuterDesc =>
      'FoodLens nutzt Puter.js User-Pays Architektur für absolute Privatsphäre.';

  @override
  String get signInWithPuter => 'Mit Puter Anmelden';

  @override
  String get createFreePuterAccount => 'Kostenloses Puter-Konto Erstellen';

  @override
  String get offlineMode => 'Offline-Modus';

  @override
  String get signInWithToken => 'Mit Puter API-Token Anmelden';

  @override
  String get hideTokenLogin => 'Token-Login Ausblenden';

  @override
  String get tokenPlaceholder => 'Token von puter.com/dashboard einfügen';

  @override
  String get connectWithToken => 'Mit Token Verbinden';

  @override
  String get paste => 'Einfügen';

  @override
  String get getToken => 'Token Abrufen ↗';

  @override
  String get greeting => 'Hallo, Essensentdecker 👋';

  @override
  String get greetingSub => 'Verfolge und optimiere deine Ernährung';

  @override
  String get todayNutritionSummary => 'Heutige Nährwertübersicht';

  @override
  String get kcalConsumed => 'kcal verzehrt';

  @override
  String get kcalLeft => 'übrig';

  @override
  String get protein => 'Protein';

  @override
  String get carbs => 'Kohlenhydrate';

  @override
  String get fat => 'Fett';

  @override
  String get fiber => 'Ballaststoffe';

  @override
  String get waterHydration => 'Wasseraufnahme';

  @override
  String get addWater => '+250 ml Wasser';

  @override
  String get foodTools => 'Ernährungswerkzeuge';

  @override
  String get foodCompare => 'Essen Vergleichen';

  @override
  String get foodCompareSub => 'Vergleichsstatistiken';

  @override
  String get menuExplorer => 'Menü-Explorer';

  @override
  String get menuExplorerSub => 'Speisekarten analysieren';

  @override
  String get scanHistory => 'Scan-Verlauf';

  @override
  String get favourites => 'Favoriten';

  @override
  String scansCount(int count) {
    return '$count Scans';
  }

  @override
  String savedCount(int count) {
    return '$count gespeichert';
  }

  @override
  String get recommendedForGoals => 'Empfohlen für deine Ziele';

  @override
  String get viewAll => 'Alle Anzeigen';

  @override
  String get dishMode => 'Gericht';

  @override
  String get menuMode => 'Menü';

  @override
  String get labelMode => 'Etikett-OCR';

  @override
  String get alignFoodPrompt => 'Platziere den Teller in der Mitte des Rahmens';

  @override
  String get alignMenuPrompt => 'Kamera auf den Text der Speisekarte richten';

  @override
  String get alignLabelPrompt =>
      'Fokussiere die Nährwerttabelle auf der Verpackung';

  @override
  String get takePhoto => 'Foto Aufnehmen';

  @override
  String get uploadGallery => 'Aus Galerie Laden';

  @override
  String get analyzingFood => 'Ernährungsdaten werden analysiert...';

  @override
  String get healthIndex => 'Gesundheitsindex';

  @override
  String get score => 'SCORE';

  @override
  String get aiEstimate => 'KI-SCHÄTZUNG';

  @override
  String get verifiedLabel => 'VERIFIZIERTES ETIKETT';

  @override
  String get macroBreakdown => 'Makronährstoff-Verteilung';

  @override
  String get microBreakdown => 'Mikronährstoffe & Vitamine';

  @override
  String get sugar => 'Zucker';

  @override
  String get saturatedFat => 'Gesättigte Fettsäuren';

  @override
  String get sodium => 'Natrium';

  @override
  String get potassium => 'Kalium';

  @override
  String get calcium => 'Kalzium';

  @override
  String get iron => 'Eisen';

  @override
  String get vitaminC => 'Vitamin C';

  @override
  String get ingredients => 'Hauptzutaten';

  @override
  String get healthierAlternatives => 'Gesündere Alternativen';

  @override
  String get portionSize => 'Portionsgröße';

  @override
  String get logMeal => 'Mahlzeit Protokollieren';

  @override
  String get originalPrice => 'Originalpreis';

  @override
  String get convertedPrice => 'Umgerechneter Preis';

  @override
  String exchangeRateSource(String source) {
    return 'Wechselkurs aktualisiert über $source';
  }

  @override
  String get menuExplorerTitle => 'Restaurant-Menü-Explorer';

  @override
  String get scanPhysicalMenu => 'Papierspeisekarte Scannen';

  @override
  String get scanMenuDesc =>
      'Scanne Speisekarten zur Extraktion von Gerichten und Nährwerten.';

  @override
  String get scanMenuBtn => 'Speisekarte mit Kamera Scannen';

  @override
  String get curatedDemos => 'Kuratierte Menüs & Demos';

  @override
  String get detectedDishes => 'Erkannte Gerichte & Nährwerte';

  @override
  String get allItems => 'Alle Gerichte';

  @override
  String get highProtein => 'Proteinreich (25g+)';

  @override
  String get lowCalorie => 'Kalorienarm (<500 kcal)';

  @override
  String get settingsTitle => 'Einstellungen & Präferenzen';

  @override
  String get appearanceSection => 'Erscheinungsbild';

  @override
  String get appearanceDesc => 'Farbschema und Dunkelmodus anpassen';

  @override
  String get themeMode => 'Theme-Modus';

  @override
  String get darkMode => 'Dunkelmodus';

  @override
  String get lightMode => 'Hellmodus';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get languageRegionSection => 'Sprache & Region';

  @override
  String get languageRegionDesc => 'Anzeigesprache, Länderformate und Region';

  @override
  String get language => 'App-Sprache';

  @override
  String get countryRegion => 'Land / Region';

  @override
  String get timeZone => 'Zeitzone';

  @override
  String get currencyLocalizationSection => 'Währung & Preise';

  @override
  String get currencyLocalizationDesc =>
      'Echtzeit-Wechselkurse und Preisanzeige';

  @override
  String get currency => 'Bevorzugte Währung';

  @override
  String get exchangeRates => 'Live-Wechselkurse';

  @override
  String get measurementSystemSection => 'Maßsystem';

  @override
  String get measurementSystemDesc => 'Metrisch (g, ml) vs Imperial (Unzen)';

  @override
  String get unitSystem => 'Einheitensystem';

  @override
  String get metric => 'Metrisch (g, ml, kg)';

  @override
  String get imperial => 'Imperial (oz, fl oz, lb)';

  @override
  String get dietaryPreferencesSection => 'Ernährungspräferenzen';

  @override
  String get dietaryPreferencesDesc =>
      'Halal, Vegan, Keto, Allergene und Ziele';

  @override
  String get dailyCalorieGoal => 'Tägliches Kalorienziel';

  @override
  String get notificationsSection => 'Benachrichtigungen';

  @override
  String get notificationsDesc =>
      'Erinnerungen an Mahlzeiten und Wasseraufnahme';

  @override
  String get hydrationReminders => 'Trinkerinnerungen';

  @override
  String get mealReminders => 'Mahlzeit-Erinnerungen';

  @override
  String get privacySecuritySection => 'Datenschutz & Sicherheit';

  @override
  String get privacySecurityDesc => 'Puter-Schlüssel und Datenkontrolle';

  @override
  String get puterAccount => 'Puter.js-Konto';

  @override
  String get connected => 'Verbunden';

  @override
  String get disconnected => 'Getrennt (Offline-Modus)';

  @override
  String get storageDataSection => 'Speicher & Daten';

  @override
  String get storageDataDesc => 'Verwaltung des lokalen Caches';

  @override
  String get clearCache => 'Lokalen Cache Leeren';

  @override
  String get cacheCleared => 'Lokaler Cache erfolgreich geleert.';

  @override
  String get aboutSection => 'Über FoodLens';

  @override
  String get aboutDesc => 'Entwicklerprofil, Credits und Version';

  @override
  String get aboutTitle => 'Über FoodLens';

  @override
  String get appName => 'FoodLens';

  @override
  String get appVersion => 'Version 1.0.0 (Global Release)';

  @override
  String get creatorTitle => 'Erstellt & Entwickelt von';

  @override
  String get developerName => 'CodeByArnob';

  @override
  String get developerRole => 'Originaler Schöpfer & Hauptentwickler';

  @override
  String get viewGithubProfile => 'GitHub-Profil Anzeigen';

  @override
  String get madeWithPassion => 'Mit Leidenschaft gemacht von CodeByArnob ❤️';

  @override
  String get maintainerTitle => 'Projekt-Maintainer';

  @override
  String get contributorsTitle => 'Mitwirkende & Open Source';

  @override
  String get officialGithub => 'Offizielles GitHub-Repository';

  @override
  String get safetyDisclaimerTitle => 'Sicherheits- & Ernährungshinweis';

  @override
  String get safetyDisclaimer =>
      'FoodLens schätzt Nährwerte visuell. Dies garantiert keine Allergenfreiheit und ersetzt keine ärztliche Beratung.';

  @override
  String get insufficientFundsTitle => 'Monatliches Kontingent Erschöpft';

  @override
  String get insufficientFundsDesc =>
      'Dein monatliches Puter-KI-Guthaben ist aufgebraucht. Bitte lade dein Konto auf.';

  @override
  String get upgradePuter => 'Puter-Konto Upgraden';

  @override
  String get aboutFoodLens => 'Über FoodLens';

  @override
  String get selectLanguage => 'Sprache Auswählen';

  @override
  String get suggestedLocale => 'Vorgeschlagene Sprache';

  @override
  String get selectCurrency => 'Währung Auswählen';

  @override
  String get localizationSection => 'Lokalisierung & Region';

  @override
  String get measurementSystem => 'Maßsystem';

  @override
  String get dietarySection => 'Ernährungspräferenzen & Ziele';

  @override
  String get dietaryFilters => 'Ernährungsfilter';

  @override
  String get dataManagement => 'Speicher & Daten';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get clear => 'Löschen';

  @override
  String get recentScans => 'Letzte Scans';

  @override
  String get favorites => 'Favoriten';
}
