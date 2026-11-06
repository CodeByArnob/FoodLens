import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/dietary_constants.dart';
import '../../../shared/services/local_storage_service.dart';
import '../../auth/providers/auth_provider.dart';

class SettingsState {
  final String currencyCode;
  final String currencySymbol;
  final String currencyName;
  final String currencyFlag;
  final String unitSystem; // 'metric' or 'imperial'
  final String language;
  final String languageNativeName;
  final String country;
  final int dailyCalorieTarget;
  final List<String> dietaryFilters;
  final List<String> allergens;

  const SettingsState({
    this.currencyCode = 'USD',
    this.currencySymbol = '\$',
    this.currencyName = 'US Dollar',
    this.currencyFlag = '🇺🇸',
    this.unitSystem = 'metric',
    this.language = 'en',
    this.languageNativeName = 'English',
    this.country = 'United States',
    this.dailyCalorieTarget = AppConstants.defaultDailyCalories,
    this.dietaryFilters = const [],
    this.allergens = const [],
  });

  bool get isMetric => unitSystem == 'metric';
  Locale get locale => Locale(language);

  SettingsState copyWith({
    String? currencyCode,
    String? currencySymbol,
    String? currencyName,
    String? currencyFlag,
    String? unitSystem,
    String? language,
    String? languageNativeName,
    String? country,
    int? dailyCalorieTarget,
    List<String>? dietaryFilters,
    List<String>? allergens,
  }) {
    return SettingsState(
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyName: currencyName ?? this.currencyName,
      currencyFlag: currencyFlag ?? this.currencyFlag,
      unitSystem: unitSystem ?? this.unitSystem,
      language: language ?? this.language,
      languageNativeName: languageNativeName ?? this.languageNativeName,
      country: country ?? this.country,
      dailyCalorieTarget: dailyCalorieTarget ?? this.dailyCalorieTarget,
      dietaryFilters: dietaryFilters ?? this.dietaryFilters,
      allergens: allergens ?? this.allergens,
    );
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) {
    final storage = ref.watch(localStorageServiceProvider);
    return SettingsNotifier(storage);
  },
);

class SettingsNotifier extends StateNotifier<SettingsState> {
  final LocalStorageService _storage;

  SettingsNotifier(this._storage) : super(const SettingsState()) {
    _loadSettings();
  }

  void _loadSettings() {
    final currency = _storage.getCurrency();
    final unitSystem = _storage.getUnitSystem();
    final language = _storage.getLanguage();
    final country = _storage.getCountry();
    final calorieTarget = _storage.getDailyCalorieTarget();
    final filters = _storage.getDietaryFilters();

    final currencyMap = DietaryConstants.supportedCurrencies.firstWhere(
      (c) => c['code'] == currency,
      orElse: () => {
        'code': 'USD',
        'symbol': '\$',
        'name': 'US Dollar',
        'flag': '🇺🇸',
      },
    );

    final langMap = DietaryConstants.supportedLanguages.firstWhere(
      (l) => l['code'] == language,
      orElse: () => {'code': 'en', 'name': 'English', 'nativeName': 'English'},
    );

    state = SettingsState(
      currencyCode: currency,
      currencySymbol: currencyMap['symbol'] ?? '\$',
      currencyName: currencyMap['name'] ?? 'US Dollar',
      currencyFlag: currencyMap['flag'] ?? '🇺🇸',
      unitSystem: unitSystem,
      language: language,
      languageNativeName: langMap['nativeName'] ?? 'English',
      country: country,
      dailyCalorieTarget: calorieTarget,
      dietaryFilters: filters,
    );
  }

  Future<void> setCurrency(String code) async {
    final currencyMap = DietaryConstants.supportedCurrencies.firstWhere(
      (c) => c['code'] == code,
      orElse: () => {
        'code': 'USD',
        'symbol': '\$',
        'name': 'US Dollar',
        'flag': '🇺🇸',
      },
    );
    await _storage.setCurrency(code);
    state = state.copyWith(
      currencyCode: code,
      currencySymbol: currencyMap['symbol'] ?? '\$',
      currencyName: currencyMap['name'] ?? 'US Dollar',
      currencyFlag: currencyMap['flag'] ?? '🇺🇸',
    );
  }

  Future<void> setLanguage(String lang) async {
    final langMap = DietaryConstants.supportedLanguages.firstWhere(
      (l) => l['code'] == lang,
      orElse: () => {'code': 'en', 'name': 'English', 'nativeName': 'English'},
    );
    await _storage.setLanguage(lang);
    state = state.copyWith(
      language: lang,
      languageNativeName: langMap['nativeName'] ?? 'English',
    );
  }

  Future<void> setCountry(
    String countryName, {
    bool autoAdjustCurrency = false,
  }) async {
    await _storage.setCountry(countryName);
    state = state.copyWith(country: countryName);

    if (autoAdjustCurrency) {
      final countryData = DietaryConstants.supportedCountries.firstWhere(
        (c) => c['name'] == countryName,
        orElse: () => {},
      );
      if (countryData.isNotEmpty) {
        if (countryData['currency'] != null) {
          await setCurrency(countryData['currency']!);
        }
        if (countryData['language'] != null) {
          await setLanguage(countryData['language']!);
        }
      }
    }
  }

  Future<void> setUnitSystem(String system) async {
    await _storage.setUnitSystem(system);
    state = state.copyWith(unitSystem: system);
  }

  Future<void> setDailyCalorieTarget(int target) async {
    await _storage.setDailyCalorieTarget(target);
    state = state.copyWith(dailyCalorieTarget: target);
  }

  Future<void> toggleDietaryFilter(String filter) async {
    final current = List<String>.from(state.dietaryFilters);
    if (current.contains(filter)) {
      current.remove(filter);
    } else {
      current.add(filter);
    }
    await _storage.setDietaryFilters(current);
    state = state.copyWith(dietaryFilters: current);
  }

  /// Suggests language and currency from device locale if not explicitly set
  Future<void> autoDetectLocale(Locale deviceLocale) async {
    final langCode = deviceLocale.languageCode.toLowerCase();
    final countryCode = deviceLocale.countryCode?.toUpperCase();

    // Check if user has already modified settings
    final storedLang = _storage.getLanguage();
    if (storedLang == 'en' && langCode != 'en') {
      final match = DietaryConstants.supportedLanguages.firstWhere(
        (l) => l['code'] == langCode,
        orElse: () => {},
      );
      if (match.isNotEmpty) {
        await setLanguage(langCode);
      }
    }

    if (countryCode != null) {
      final countryMatch = DietaryConstants.supportedCountries.firstWhere(
        (c) => c['code'] == countryCode,
        orElse: () => {},
      );
      if (countryMatch.isNotEmpty && countryMatch['currency'] != null) {
        await setCurrency(countryMatch['currency']!);
        await setCountry(countryMatch['name']!);
      }
    }
  }
}
