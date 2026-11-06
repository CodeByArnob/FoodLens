class DietaryConstants {
  static const List<String> dietaryPreferences = [
    'Vegetarian',
    'Vegan',
    'Halal',
    'Kosher',
    'Keto',
    'Paleo',
    'Gluten-Free',
    'Dairy-Free',
    'High-Protein',
    'Low-Carb',
    'Low-Sugar',
  ];

  static const List<String> commonAllergens = [
    'Peanuts',
    'Tree Nuts',
    'Milk / Dairy',
    'Eggs',
    'Wheat / Gluten',
    'Soy',
    'Fish',
    'Shellfish',
    'Sesame',
  ];

  static const List<String> supportedCuisines = [
    'Global / Any',
    'Mediterranean',
    'Italian',
    'Japanese',
    'Mexican',
    'Indian',
    'Thai',
    'Chinese',
    'Middle Eastern',
    'American',
    'French',
    'Korean',
    'Vietnamese',
  ];

  static const List<Map<String, String>> supportedCurrencies = [
    {
      'code': 'USD',
      'symbol': '\$',
      'name': 'US Dollar',
      'flag': '🇺🇸',
      'country': 'United States',
    },
    {
      'code': 'BDT',
      'symbol': '৳',
      'name': 'Bangladeshi Taka',
      'flag': '🇧🇩',
      'country': 'Bangladesh',
    },
    {
      'code': 'EUR',
      'symbol': '€',
      'name': 'Euro',
      'flag': '🇪🇺',
      'country': 'European Union',
    },
    {
      'code': 'GBP',
      'symbol': '£',
      'name': 'British Pound',
      'flag': '🇬🇧',
      'country': 'United Kingdom',
    },
    {
      'code': 'INR',
      'symbol': '₹',
      'name': 'Indian Rupee',
      'flag': '🇮🇳',
      'country': 'India',
    },
    {
      'code': 'SAR',
      'symbol': 'ر.স',
      'name': 'Saudi Riyal',
      'flag': '🇸🇦',
      'country': 'Saudi Arabia',
    },
    {
      'code': 'AED',
      'symbol': 'د.إ',
      'name': 'UAE Dirham',
      'flag': '🇦🇪',
      'country': 'United Arab Emirates',
    },
    {
      'code': 'CAD',
      'symbol': 'CA\$',
      'name': 'Canadian Dollar',
      'flag': '🇨🇦',
      'country': 'Canada',
    },
    {
      'code': 'AUD',
      'symbol': 'A\$',
      'name': 'Australian Dollar',
      'flag': '🇦🇺',
      'country': 'Australia',
    },
    {
      'code': 'JPY',
      'symbol': '¥',
      'name': 'Japanese Yen',
      'flag': '🇯🇵',
      'country': 'Japan',
    },
    {
      'code': 'SGD',
      'symbol': 'S\$',
      'name': 'Singapore Dollar',
      'flag': '🇸🇬',
      'country': 'Singapore',
    },
    {
      'code': 'CHF',
      'symbol': 'CHF',
      'name': 'Swiss Franc',
      'flag': '🇨🇭',
      'country': 'Switzerland',
    },
    {
      'code': 'MYR',
      'symbol': 'RM',
      'name': 'Malaysian Ringgit',
      'flag': '🇲🇾',
      'country': 'Malaysia',
    },
    {
      'code': 'THB',
      'symbol': '฿',
      'name': 'Thai Baht',
      'flag': '🇹🇭',
      'country': 'Thailand',
    },
  ];

  static const List<Map<String, String>> supportedLanguages = [
    {'code': 'en', 'name': 'English', 'nativeName': 'English', 'flag': '🇺🇸'},
    {'code': 'bn', 'name': 'Bengali', 'nativeName': 'বাংলা', 'flag': '🇧🇩'},
    {'code': 'ar', 'name': 'Arabic', 'nativeName': 'العربية', 'flag': '🇸🇦'},
    {'code': 'es', 'name': 'Spanish', 'nativeName': 'Español', 'flag': '🇪🇸'},
    {'code': 'fr', 'name': 'French', 'nativeName': 'Français', 'flag': '🇫🇷'},
    {'code': 'de', 'name': 'German', 'nativeName': 'Deutsch', 'flag': '🇩🇪'},
    {'code': 'ja', 'name': 'Japanese', 'nativeName': '日本語', 'flag': '🇯🇵'},
    {'code': 'hi', 'name': 'Hindi', 'nativeName': 'हिन्दी', 'flag': '🇮🇳'},
  ];

  static const List<Map<String, String>> supportedCountries = [
    {
      'name': 'United States',
      'code': 'US',
      'currency': 'USD',
      'language': 'en',
      'flag': '🇺🇸',
    },
    {
      'name': 'Bangladesh',
      'code': 'BD',
      'currency': 'BDT',
      'language': 'bn',
      'flag': '🇧🇩',
    },
    {
      'name': 'United Kingdom',
      'code': 'GB',
      'currency': 'GBP',
      'language': 'en',
      'flag': '🇬🇧',
    },
    {
      'name': 'India',
      'code': 'IN',
      'currency': 'INR',
      'language': 'hi',
      'flag': '🇮🇳',
    },
    {
      'name': 'Saudi Arabia',
      'code': 'SA',
      'currency': 'SAR',
      'language': 'ar',
      'flag': '🇸🇦',
    },
    {
      'name': 'United Arab Emirates',
      'code': 'AE',
      'currency': 'AED',
      'language': 'ar',
      'flag': '🇦🇪',
    },
    {
      'name': 'Germany',
      'code': 'DE',
      'currency': 'EUR',
      'language': 'de',
      'flag': '🇩🇪',
    },
    {
      'name': 'France',
      'code': 'FR',
      'currency': 'EUR',
      'language': 'fr',
      'flag': '🇫🇷',
    },
    {
      'name': 'Spain',
      'code': 'ES',
      'currency': 'EUR',
      'language': 'es',
      'flag': '🇪🇸',
    },
    {
      'name': 'Japan',
      'code': 'JP',
      'currency': 'JPY',
      'language': 'ja',
      'flag': '🇯🇵',
    },
    {
      'name': 'Canada',
      'code': 'CA',
      'currency': 'CAD',
      'language': 'en',
      'flag': '🇨🇦',
    },
    {
      'name': 'Australia',
      'code': 'AU',
      'currency': 'AUD',
      'language': 'en',
      'flag': '🇦🇺',
    },
    {
      'name': 'Singapore',
      'code': 'SG',
      'currency': 'SGD',
      'language': 'en',
      'flag': '🇸🇬',
    },
  ];

  static const String safetyMedicalDisclaimer =
      'FoodLens AI estimates nutritional values and detects ingredients from visual imagery. '
      'It cannot guarantee the absence of cross-contamination or allergens, and must not be used '
      'as laboratory analysis or medical advice. Consult a healthcare professional for dietary prescriptions.';
}
