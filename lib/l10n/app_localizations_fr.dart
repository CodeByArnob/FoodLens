// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'FoodLens';

  @override
  String get tagline => 'Intelligence Alimentaire par IA';

  @override
  String get navHome => 'Accueil';

  @override
  String get navTracker => 'Suivi';

  @override
  String get navScanner => 'Scanner';

  @override
  String get navMealPlan => 'Repas';

  @override
  String get navProfile => 'Profil';

  @override
  String get onboardingSkip => 'Passer';

  @override
  String get onboardingContinue => 'Continuer';

  @override
  String get onboardingGetStarted => 'Commencer';

  @override
  String get onboardingTitle1 => 'Scannez N\'importe Quel Plat ou Menu';

  @override
  String get onboardingDesc1 =>
      'Intelligence alimentaire instantanée par IA. Pointez votre caméra vers vos repas ou menus.';

  @override
  String get onboardingTitle2 => 'Analyses Nutritionnelles et Cliniques';

  @override
  String get onboardingDesc2 =>
      'Obtenez des estimations de calories, la répartition des macronutriments et des scores de santé.';

  @override
  String get onboardingTitle3 => 'Sécurité Diététique et Allergènes';

  @override
  String get onboardingDesc3 =>
      'Filtrez par Halal, Végétalien, Keto, Sans Gluten et recevez des alertes d\'allergènes.';

  @override
  String get onboardingTitle4 => 'IA Décentralisée avec Puter.js';

  @override
  String get onboardingDesc4 =>
      'Propulsé par votre compte Puter personnel avec quota gratuit mensuel et respect de la vie privée.';

  @override
  String get connectPuterTitle => 'Connecter un Compte Puter';

  @override
  String get connectPuterSub => 'Cloud d\'Intelligence Alimentaire Personnel';

  @override
  String get connectPuterDesc =>
      'FoodLens utilise l\'architecture User-Pays de Puter.js pour protéger vos données.';

  @override
  String get signInWithPuter => 'Se Connecter avec Puter';

  @override
  String get createFreePuterAccount => 'Créer un Compte Puter Gratuit';

  @override
  String get offlineMode => 'Mode Hors Ligne';

  @override
  String get signInWithToken => 'Connexion par Jeton API';

  @override
  String get hideTokenLogin => 'Masquer la Connexion par Jeton';

  @override
  String get tokenPlaceholder => 'Coller le jeton depuis puter.com/dashboard';

  @override
  String get connectWithToken => 'Connecter avec le Jeton';

  @override
  String get paste => 'Coller';

  @override
  String get getToken => 'Obtenir un Jeton ↗';

  @override
  String get greeting => 'Bonjour, Explorateur Culinaire 👋';

  @override
  String get greetingSub => 'Suivez et optimisez votre nutrition quotidienne';

  @override
  String get todayNutritionSummary => 'Résumé Nutritionnel du Jour';

  @override
  String get kcalConsumed => 'kcal consommées';

  @override
  String get kcalLeft => 'restantes';

  @override
  String get protein => 'Protéines';

  @override
  String get carbs => 'Glucides';

  @override
  String get fat => 'Lipides';

  @override
  String get fiber => 'Fibres';

  @override
  String get waterHydration => 'Hydratation';

  @override
  String get addWater => '+250 ml Eau';

  @override
  String get foodTools => 'Outils d\'Intelligence Alimentaire';

  @override
  String get foodCompare => 'Comparer Aliments';

  @override
  String get foodCompareSub => 'Statistiques côte à côte';

  @override
  String get menuExplorer => 'Explorateur de Menus';

  @override
  String get menuExplorerSub => 'Analyser des menus';

  @override
  String get scanHistory => 'Historique des Scans';

  @override
  String get favourites => 'Favoris';

  @override
  String scansCount(int count) {
    return '$count scans';
  }

  @override
  String savedCount(int count) {
    return '$count enregistrés';
  }

  @override
  String get recommendedForGoals => 'Recommandé pour Vos Objectifs';

  @override
  String get viewAll => 'Voir Tout';

  @override
  String get dishMode => 'Plat';

  @override
  String get menuMode => 'Menu';

  @override
  String get labelMode => 'Étiquette OCR';

  @override
  String get alignFoodPrompt =>
      'Cadrez l\'assiette au centre pour une meilleure précision';

  @override
  String get alignMenuPrompt => 'Pointez la caméra vers le texte du menu';

  @override
  String get alignLabelPrompt => 'Cadrez le tableau nutritionnel du produit';

  @override
  String get takePhoto => 'Prendre une Photo';

  @override
  String get uploadGallery => 'Importer depuis la Galerie';

  @override
  String get analyzingFood => 'Analyse nutritionnelle en cours...';

  @override
  String get healthIndex => 'Indice de Santé';

  @override
  String get score => 'SCORE';

  @override
  String get aiEstimate => 'ESTIMATION IA';

  @override
  String get verifiedLabel => 'ÉTIQUETTE VÉRIFIÉE';

  @override
  String get macroBreakdown => 'Répartition des Macronutriments';

  @override
  String get microBreakdown => 'Micronutriments et Vitamines';

  @override
  String get sugar => 'Sucre';

  @override
  String get saturatedFat => 'Graisses Saturées';

  @override
  String get sodium => 'Sodium';

  @override
  String get potassium => 'Potassium';

  @override
  String get calcium => 'Calcium';

  @override
  String get iron => 'Fer';

  @override
  String get vitaminC => 'Vitamine C';

  @override
  String get ingredients => 'Ingrédients Principaux';

  @override
  String get healthierAlternatives => 'Alternatives Plus Saines';

  @override
  String get portionSize => 'Portion';

  @override
  String get logMeal => 'Enregistrer le Repas';

  @override
  String get originalPrice => 'Prix d\'Origine';

  @override
  String get convertedPrice => 'Prix Converti';

  @override
  String exchangeRateSource(String source) {
    return 'Taux de change actualisé via $source';
  }

  @override
  String get menuExplorerTitle => 'Explorateur de Menus de Restaurant';

  @override
  String get scanPhysicalMenu => 'Scanner un Menu Papier';

  @override
  String get scanMenuDesc =>
      'Scannez une carte ou un menu papier pour extraire les plats et calories.';

  @override
  String get scanMenuBtn => 'Scanner le Menu avec la Caméra';

  @override
  String get curatedDemos => 'Menus Sélectionnés & Démos';

  @override
  String get detectedDishes => 'Plats Détectés & Nutrition';

  @override
  String get allItems => 'Tous les Plats';

  @override
  String get highProtein => 'Riche en Protéines (25g+)';

  @override
  String get lowCalorie => 'Faible en Calories (<500 kcal)';

  @override
  String get settingsTitle => 'Paramètres et Préférences';

  @override
  String get appearanceSection => 'Apparence';

  @override
  String get appearanceDesc => 'Personnaliser le thème et le confort visuel';

  @override
  String get themeMode => 'Mode du Thème';

  @override
  String get darkMode => 'Mode Sombre';

  @override
  String get lightMode => 'Mode Clair';

  @override
  String get systemDefault => 'Défaut du Système';

  @override
  String get languageRegionSection => 'Langue et Région';

  @override
  String get languageRegionDesc =>
      'Langue d\'affichage de l\'application et formats';

  @override
  String get language => 'Langue de l\'App';

  @override
  String get countryRegion => 'Pays / Région';

  @override
  String get timeZone => 'Fuseau Horaire';

  @override
  String get currencyLocalizationSection => 'Devise et Tarification';

  @override
  String get currencyLocalizationDesc =>
      'Conversion en temps réel et affichage des prix';

  @override
  String get currency => 'Devise Préférée';

  @override
  String get exchangeRates => 'Taux de Change en Direct';

  @override
  String get measurementSystemSection => 'Système de Mesure';

  @override
  String get measurementSystemDesc =>
      'Métrique (grammes, ml) vs Impérial (onces)';

  @override
  String get unitSystem => 'Système d\'Unités';

  @override
  String get metric => 'Métrique (g, ml, kg)';

  @override
  String get imperial => 'Impérial (oz, fl oz, lb)';

  @override
  String get dietaryPreferencesSection => 'Préférences Alimentaires';

  @override
  String get dietaryPreferencesDesc =>
      'Halal, Végétalien, Keto, Allergènes et objectifs';

  @override
  String get dailyCalorieGoal => 'Objectif Calorique Quotidien';

  @override
  String get notificationsSection => 'Notifications';

  @override
  String get notificationsDesc => 'Rappels d\'hydratation et suivi des repas';

  @override
  String get hydrationReminders => 'Rappels d\'Hydratation';

  @override
  String get mealReminders => 'Alertes de Repas';

  @override
  String get privacySecuritySection => 'Confidentialité et Sécurité';

  @override
  String get privacySecurityDesc =>
      'Clés Puter décentralisées et gestion des données';

  @override
  String get puterAccount => 'Compte Puter.js';

  @override
  String get connected => 'Connecté';

  @override
  String get disconnected => 'Déconnecté (Mode Hors Ligne)';

  @override
  String get storageDataSection => 'Stockage et Données';

  @override
  String get storageDataDesc => 'Gestion du cache local et plats sauvegardés';

  @override
  String get clearCache => 'Effacer le Cache Local';

  @override
  String get cacheCleared => 'Cache local effacé avec succès.';

  @override
  String get aboutSection => 'À Propos de FoodLens';

  @override
  String get aboutDesc => 'Profil du développeur, crédits et version';

  @override
  String get aboutTitle => 'À Propos de FoodLens';

  @override
  String get appName => 'FoodLens';

  @override
  String get appVersion => 'Version 1.0.0 (Version Mondiale)';

  @override
  String get creatorTitle => 'Créé & Développé par';

  @override
  String get developerName => 'CodeByArnob';

  @override
  String get developerRole => 'Créateur Original & Développeur Principal';

  @override
  String get viewGithubProfile => 'Voir le Profil GitHub';

  @override
  String get madeWithPassion => 'Fait avec passion par CodeByArnob ❤️';

  @override
  String get maintainerTitle => 'Responsable du Projet';

  @override
  String get contributorsTitle => 'Contributeurs & Open Source';

  @override
  String get officialGithub => 'Dépôt GitHub Officiel';

  @override
  String get safetyDisclaimerTitle => 'Avertissement de Sécurité & Nutrition';

  @override
  String get safetyDisclaimer =>
      'FoodLens estime les valeurs nutritionnelles à partir d\'images. Cela ne garantit pas l\'absence d\'allergènes et ne constitue pas un avis médical.';

  @override
  String get insufficientFundsTitle => 'Quota Mensuel Épuisé';

  @override
  String get insufficientFundsDesc =>
      'Votre allocation Puter AI est épuisée. Veuillez recharger votre compte.';

  @override
  String get upgradePuter => 'Mettre à Niveau Puter';

  @override
  String get aboutFoodLens => 'À propos de FoodLens';

  @override
  String get selectLanguage => 'Choisir la Langue';

  @override
  String get suggestedLocale => 'Langue Suggérée';

  @override
  String get selectCurrency => 'Choisir la Devise';

  @override
  String get localizationSection => 'Localisation & Région';

  @override
  String get measurementSystem => 'Système de Mesure';

  @override
  String get dietarySection => 'Préférences Alimentaires & Objectifs';

  @override
  String get dietaryFilters => 'Filtres Alimentaires';

  @override
  String get dataManagement => 'Stockage & Données';

  @override
  String get cancel => 'Annuler';

  @override
  String get clear => 'Effacer';

  @override
  String get recentScans => 'Scans Récents';

  @override
  String get favorites => 'Favoris';
}
