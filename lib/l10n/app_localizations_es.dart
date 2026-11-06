// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'FoodLens';

  @override
  String get tagline => 'Inteligencia Alimentaria con IA';

  @override
  String get navHome => 'Inicio';

  @override
  String get navTracker => 'Seguimiento';

  @override
  String get navScanner => 'Escanear';

  @override
  String get navMealPlan => 'Plan de Comidas';

  @override
  String get navProfile => 'Perfil';

  @override
  String get onboardingSkip => 'Omitir';

  @override
  String get onboardingContinue => 'Continuar';

  @override
  String get onboardingGetStarted => 'Comenzar';

  @override
  String get onboardingTitle1 => 'Escanea Cualquier Plato, Menú o Etiqueta';

  @override
  String get onboardingDesc1 =>
      'Inteligencia alimentaria instantánea con IA. Apunta tu cámara a comidas caseras, menús de restaurantes o etiquetas nutricionales.';

  @override
  String get onboardingTitle2 => 'Análisis Nutricional y Clínico Profundo';

  @override
  String get onboardingDesc2 =>
      'Obtén estimaciones de calorías, distribución completa de macronutrientes y grados de salud clínicos.';

  @override
  String get onboardingTitle3 =>
      'Seguridad Dietética y Alérgenos Personalizada';

  @override
  String get onboardingDesc3 =>
      'Filtra por Halal, Vegano, Keto, Sin Gluten y recibe alertas preventivas sobre alérgenos ocultos.';

  @override
  String get onboardingTitle4 => 'IA Descentralizada con Puter.js';

  @override
  String get onboardingDesc4 =>
      'Impulsado por tu cuenta personal de Puter. Cero rastreo, privacidad total y cuota mensual gratuita.';

  @override
  String get connectPuterTitle => 'Conectar Cuenta Puter';

  @override
  String get connectPuterSub => 'Nube Personal de Inteligencia Alimentaria';

  @override
  String get connectPuterDesc =>
      'FoodLens utiliza la arquitectura User-Pays de Puter.js para que uses tu propia cuota mensual gratuita.';

  @override
  String get signInWithPuter => 'Iniciar Sesión con Puter';

  @override
  String get createFreePuterAccount => 'Crear Cuenta Puter Gratis';

  @override
  String get offlineMode => 'Modo Desconectado';

  @override
  String get signInWithToken => 'Iniciar con Token de API Puter';

  @override
  String get hideTokenLogin => 'Ocultar Inicio con Token';

  @override
  String get tokenPlaceholder => 'Pega el token de puter.com/dashboard';

  @override
  String get connectWithToken => 'Conectar con Token';

  @override
  String get paste => 'Pegar';

  @override
  String get getToken => 'Obtener Token ↗';

  @override
  String get greeting => 'Hola, Explorador de Comida 👋';

  @override
  String get greetingSub => 'Rastrea y optimiza tu nutrición diaria';

  @override
  String get todayNutritionSummary => 'Resumen Nutricional de Hoy';

  @override
  String get kcalConsumed => 'kcal consumidas';

  @override
  String get kcalLeft => 'restantes';

  @override
  String get protein => 'Proteína';

  @override
  String get carbs => 'Carbohidratos';

  @override
  String get fat => 'Grasa';

  @override
  String get fiber => 'Fibra';

  @override
  String get waterHydration => 'Hidratación';

  @override
  String get addWater => '+250 ml Agua';

  @override
  String get foodTools => 'Herramientas de Inteligencia';

  @override
  String get foodCompare => 'Comparar Comida';

  @override
  String get foodCompareSub => 'Estadísticas lado a lado';

  @override
  String get menuExplorer => 'Explorador de Menús';

  @override
  String get menuExplorerSub => 'Analizar menús';

  @override
  String get scanHistory => 'Historial de Escaneos';

  @override
  String get favourites => 'Favoritos';

  @override
  String scansCount(int count) {
    return '$count escaneos';
  }

  @override
  String savedCount(int count) {
    return '$count guardados';
  }

  @override
  String get recommendedForGoals => 'Recomendado para tus Objetivos';

  @override
  String get viewAll => 'Ver Todo';

  @override
  String get dishMode => 'Plato';

  @override
  String get menuMode => 'Menú';

  @override
  String get labelMode => 'Etiqueta OCR';

  @override
  String get alignFoodPrompt =>
      'Alinea el plato dentro del marco para mayor precisión';

  @override
  String get alignMenuPrompt => 'Apunta la cámara al texto del menú';

  @override
  String get alignLabelPrompt => 'Enfoca la tabla de información nutricional';

  @override
  String get takePhoto => 'Tomar Foto';

  @override
  String get uploadGallery => 'Subir de Galería';

  @override
  String get analyzingFood => 'Analizando Inteligencia Alimentaria...';

  @override
  String get healthIndex => 'Índice de Salud';

  @override
  String get score => 'PUNTAJE';

  @override
  String get aiEstimate => 'ESTIMACIÓN IA';

  @override
  String get verifiedLabel => 'ETIQUETA VERIFICADA';

  @override
  String get macroBreakdown => 'Desglose de Macronutrientes';

  @override
  String get microBreakdown => 'Micronutrientes y Vitaminas';

  @override
  String get sugar => 'Azúcar';

  @override
  String get saturatedFat => 'Grasa Saturada';

  @override
  String get sodium => 'Sodio';

  @override
  String get potassium => 'Potasio';

  @override
  String get calcium => 'Calcio';

  @override
  String get iron => 'Hierro';

  @override
  String get vitaminC => 'Vitamina C';

  @override
  String get ingredients => 'Ingredientes Clave';

  @override
  String get healthierAlternatives => 'Alternativas Saludables';

  @override
  String get portionSize => 'Porción';

  @override
  String get logMeal => 'Registrar Comida';

  @override
  String get originalPrice => 'Precio Original';

  @override
  String get convertedPrice => 'Precio Convertido';

  @override
  String exchangeRateSource(String source) {
    return 'Tipo de cambio actualizado mediante $source';
  }

  @override
  String get menuExplorerTitle => 'Explorador de Menús de Restaurantes';

  @override
  String get scanPhysicalMenu => 'Escanear un Menú Físico';

  @override
  String get scanMenuDesc =>
      'Apunta a cualquier menú en papel para extraer platos y nutrición.';

  @override
  String get scanMenuBtn => 'Escanear Menú con Cámara';

  @override
  String get curatedDemos => 'Menús Curados y Demos';

  @override
  String get detectedDishes => 'Platos Detectados y Nutrición';

  @override
  String get allItems => 'Todos los Platos';

  @override
  String get highProtein => 'Alto en Proteína (25g+)';

  @override
  String get lowCalorie => 'Bajo en Calorías (<500 kcal)';

  @override
  String get settingsTitle => 'Ajustes y Preferencias';

  @override
  String get appearanceSection => 'Apariencia';

  @override
  String get appearanceDesc =>
      'Personaliza temas, modo oscuro y comodidad visual';

  @override
  String get themeMode => 'Modo de Tema';

  @override
  String get darkMode => 'Modo Oscuro';

  @override
  String get lightMode => 'Modo Claro';

  @override
  String get systemDefault => 'Predeterminado del Sistema';

  @override
  String get languageRegionSection => 'Idioma y Región';

  @override
  String get languageRegionDesc =>
      'Idioma de visualización, país y formatos regionales';

  @override
  String get language => 'Idioma de la App';

  @override
  String get countryRegion => 'País / Región';

  @override
  String get timeZone => 'Zona Horaria';

  @override
  String get currencyLocalizationSection => 'Moneda y Precios';

  @override
  String get currencyLocalizationDesc =>
      'Conversión en tiempo real y visualización de precios';

  @override
  String get currency => 'Moneda Preferida';

  @override
  String get exchangeRates => 'Tipos de Cambio en Vivo';

  @override
  String get measurementSystemSection => 'Sistema de Medición';

  @override
  String get measurementSystemDesc =>
      'Métrico (gramos, ml) vs Imperial (onzas)';

  @override
  String get unitSystem => 'Sistema de Unidades';

  @override
  String get metric => 'Métrico (g, ml, kg)';

  @override
  String get imperial => 'Imperial (oz, fl oz, lb)';

  @override
  String get dietaryPreferencesSection => 'Preferencias Dietéticas';

  @override
  String get dietaryPreferencesDesc => 'Halal, Vegano, Keto, Alérgenos y metas';

  @override
  String get dailyCalorieGoal => 'Meta Diaria de Calorías';

  @override
  String get notificationsSection => 'Notificaciones';

  @override
  String get notificationsDesc => 'Recordatorios de comidas y registro de agua';

  @override
  String get hydrationReminders => 'Recordatorios de Hidratación';

  @override
  String get mealReminders => 'Alertas de Registro de Comida';

  @override
  String get privacySecuritySection => 'Privacidad y Seguridad';

  @override
  String get privacySecurityDesc =>
      'Claves descentralizadas de Puter y control de datos';

  @override
  String get puterAccount => 'Cuenta Puter.js';

  @override
  String get connected => 'Conectado';

  @override
  String get disconnected => 'Desconectado (Modo Offline)';

  @override
  String get storageDataSection => 'Almacenamiento y Datos';

  @override
  String get storageDataDesc =>
      'Caché de escaneos y gestión de platos guardados';

  @override
  String get clearCache => 'Borrar Caché Local';

  @override
  String get cacheCleared => 'Caché local borrada exitosamente.';

  @override
  String get aboutSection => 'Acerca de FoodLens';

  @override
  String get aboutDesc => 'Perfil del desarrollador, créditos y versión';

  @override
  String get aboutTitle => 'Acerca de FoodLens';

  @override
  String get appName => 'FoodLens';

  @override
  String get appVersion => 'Versión 1.0.0 (Lanzamiento Global)';

  @override
  String get creatorTitle => 'Creado y Desarrollado por';

  @override
  String get developerName => 'CodeByArnob';

  @override
  String get developerRole => 'Creador Original y Desarrollador Principal';

  @override
  String get viewGithubProfile => 'Ver Perfil de GitHub';

  @override
  String get madeWithPassion => 'Hecho con pasión por CodeByArnob ❤️';

  @override
  String get maintainerTitle => 'Mantenimiento del Proyecto';

  @override
  String get contributorsTitle => 'Colaboradores y Código Abierto';

  @override
  String get officialGithub => 'Repositorio Oficial de GitHub';

  @override
  String get safetyDisclaimerTitle => 'Aviso de Seguridad y Nutrición';

  @override
  String get safetyDisclaimer =>
      'FoodLens estima valores nutricionales a partir de imágenes. No garantiza la ausencia de alérgenos o contaminación cruzada y no constituye consejo médico.';

  @override
  String get insufficientFundsTitle => 'Cuota Mensual Agotada';

  @override
  String get insufficientFundsDesc =>
      'Tu cuota mensual gratuita de Puter se ha agotado. Por favor recarga o actualiza tu cuenta.';

  @override
  String get upgradePuter => 'Actualizar Cuenta Puter';

  @override
  String get aboutFoodLens => 'Acerca de FoodLens';

  @override
  String get selectLanguage => 'Seleccionar Idioma';

  @override
  String get suggestedLocale => 'Idioma Sugerido';

  @override
  String get selectCurrency => 'Seleccionar Moneda';

  @override
  String get localizationSection => 'Localización y Región';

  @override
  String get measurementSystem => 'Sistema de Medida';

  @override
  String get dietarySection => 'Preferencias y Objetivos Dietéticos';

  @override
  String get dietaryFilters => 'Filtros Dietéticos';

  @override
  String get dataManagement => 'Almacenamiento y Datos';

  @override
  String get cancel => 'Cancelar';

  @override
  String get clear => 'Borrar';

  @override
  String get recentScans => 'Escaneos Recientes';

  @override
  String get favorites => 'Favoritos';
}
