import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/constants/app_constants.dart';
import '../../features/scanner/models/food_analysis_result.dart';
import '../../features/nutrition_tracking/models/daily_log.dart';

class LocalStorageService {
  final SharedPreferences _prefs;
  final FlutterSecureStorage _secureStorage;
  String? _cachedPuterToken;

  LocalStorageService(this._prefs, this._secureStorage);

  SharedPreferences get prefs => _prefs;

  static Future<LocalStorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    const secureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(migrateWithBackup: true),
    );
    final service = LocalStorageService(prefs, secureStorage);
    await service._migrateLegacyPuterToken();
    return service;
  }

  // Puter credentials are stored in Android Keystore-backed encrypted storage.
  // The in-memory cache preserves the existing synchronous getter API.
  String? getPuterToken() => _cachedPuterToken;

  Future<void> _migrateLegacyPuterToken() async {
    final secureToken = await _secureStorage.read(key: AppConstants.keyPuterToken);
    if (secureToken != null && secureToken.isNotEmpty) {
      _cachedPuterToken = secureToken;
      await _prefs.remove(AppConstants.keyPuterToken);
      return;
    }

    final legacyToken = _prefs.getString(AppConstants.keyPuterToken);
    if (legacyToken == null || legacyToken.isEmpty) return;

    await _secureStorage.write(
      key: AppConstants.keyPuterToken,
      value: legacyToken,
    );
    final migratedToken = await _secureStorage.read(
      key: AppConstants.keyPuterToken,
    );
    if (migratedToken != legacyToken) {
      throw StateError('Puter credential migration verification failed.');
    }
    _cachedPuterToken = migratedToken;
    await _prefs.remove(AppConstants.keyPuterToken);
  }

  Future<bool> setPuterToken(String? token) async {
    if (token == null || token.trim().isEmpty) {
      await _secureStorage.delete(key: AppConstants.keyPuterToken);
      _cachedPuterToken = null;
      await _prefs.remove(AppConstants.keyPuterToken);
      return true;
    }
    final cleanToken = token.trim();
    await _secureStorage.write(
      key: AppConstants.keyPuterToken,
      value: cleanToken,
    );
    final storedToken = await _secureStorage.read(
      key: AppConstants.keyPuterToken,
    );
    if (storedToken != cleanToken) {
      throw StateError('Puter credential secure-storage verification failed.');
    }
    _cachedPuterToken = storedToken;
    await _prefs.remove(AppConstants.keyPuterToken);
    return true;
  }

  String? getPuterUsername() => _prefs.getString(AppConstants.keyPuterUsername);
  Future<bool> setPuterUsername(String? username) async {
    if (username == null) {
      return _prefs.remove(AppConstants.keyPuterUsername);
    }
    return _prefs.setString(AppConstants.keyPuterUsername, username);
  }

  String? getPuterUuid() => _prefs.getString(AppConstants.keyPuterUuid);
  Future<bool> setPuterUuid(String? uuid) async {
    if (uuid == null) {
      return _prefs.remove(AppConstants.keyPuterUuid);
    }
    return _prefs.setString(AppConstants.keyPuterUuid, uuid);
  }

  Future<void> clearAuth() async {
    await _secureStorage.delete(key: AppConstants.keyPuterToken);
    _cachedPuterToken = null;
    await _prefs.remove(AppConstants.keyPuterToken);
    await _prefs.remove(AppConstants.keyPuterUsername);
    await _prefs.remove(AppConstants.keyPuterUuid);
  }

  // Onboarding
  bool hasCompletedOnboarding() =>
      _prefs.getBool(AppConstants.keyHasCompletedOnboarding) ?? false;

  Future<bool> setCompletedOnboarding(bool completed) =>
      _prefs.setBool(AppConstants.keyHasCompletedOnboarding, completed);

  // Settings & Preferences
  String getCurrency() =>
      _prefs.getString(AppConstants.keySelectedCurrency) ?? 'USD';
  Future<bool> setCurrency(String code) =>
      _prefs.setString(AppConstants.keySelectedCurrency, code);

  String getUnitSystem() =>
      _prefs.getString(AppConstants.keyUnitSystem) ?? 'metric';
  Future<bool> setUnitSystem(String system) =>
      _prefs.setString(AppConstants.keyUnitSystem, system);

  String getLanguage() =>
      _prefs.getString(AppConstants.keySelectedLanguage) ?? 'en';
  Future<bool> setLanguage(String lang) =>
      _prefs.setString(AppConstants.keySelectedLanguage, lang);

  String getCountry() =>
      _prefs.getString('selected_country') ?? 'United States';
  Future<bool> setCountry(String country) =>
      _prefs.setString('selected_country', country);

  int getDailyCalorieTarget() =>
      _prefs.getInt(AppConstants.keyDailyCalorieTarget) ??
      AppConstants.defaultDailyCalories;
  Future<bool> setDailyCalorieTarget(int calories) =>
      _prefs.setInt(AppConstants.keyDailyCalorieTarget, calories);

  List<String> getDietaryFilters() {
    final list = _prefs.getStringList(AppConstants.keyUserPreferences);
    return list ?? [];
  }

  Future<bool> setDietaryFilters(List<String> filters) =>
      _prefs.setStringList(AppConstants.keyUserPreferences, filters);

  // Scan History
  List<FoodAnalysisResult> getScanHistory() {
    final jsonString = _prefs.getString(AppConstants.keyScanHistory);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> list = jsonDecode(jsonString);
      return list
          .map((e) => FoodAnalysisResult.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveScanResult(FoodAnalysisResult result) async {
    final history = getScanHistory();
    history.removeWhere((item) => item.id == result.id);
    history.insert(0, result);
    // keep maximum 100 historical scans
    if (history.length > 100) {
      history.removeRange(100, history.length);
    }
    final jsonString = jsonEncode(history.map((e) => e.toJson()).toList());
    return _prefs.setString(AppConstants.keyScanHistory, jsonString);
  }

  Future<bool> deleteScanResult(String id) async {
    final history = getScanHistory();
    history.removeWhere((item) => item.id == id);
    final jsonString = jsonEncode(history.map((e) => e.toJson()).toList());
    return _prefs.setString(AppConstants.keyScanHistory, jsonString);
  }

  Future<bool> clearScanHistory() => _prefs.remove(AppConstants.keyScanHistory);

  // Favourites
  List<FoodAnalysisResult> getFavorites() {
    final jsonString = _prefs.getString(AppConstants.keyFavorites);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> list = jsonDecode(jsonString);
      return list
          .map((e) => FoodAnalysisResult.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> toggleFavorite(FoodAnalysisResult result) async {
    final favorites = getFavorites();
    final index = favorites.indexWhere(
      (item) => item.id == result.id || item.foodName == result.foodName,
    );
    if (index >= 0) {
      favorites.removeAt(index);
    } else {
      favorites.insert(0, result.copyWith(isFavorite: true));
    }
    final jsonString = jsonEncode(favorites.map((e) => e.toJson()).toList());
    return _prefs.setString(AppConstants.keyFavorites, jsonString);
  }

  bool isFavorite(String id, String foodName) {
    final favorites = getFavorites();
    return favorites.any((item) => item.id == id || item.foodName == foodName);
  }

  // Daily Nutrition Tracking
  List<DailyLog> getDailyLogs() {
    final jsonString = _prefs.getString(AppConstants.keyDailyLogs);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> list = jsonDecode(jsonString);
      return list
          .map((e) => DailyLog.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveDailyLogs(List<DailyLog> logs) {
    final jsonString = jsonEncode(logs.map((e) => e.toJson()).toList());
    return _prefs.setString(AppConstants.keyDailyLogs, jsonString);
  }

  // Load Seed Database from assets
  Future<List<FoodAnalysisResult>> loadSeedDatabase() async {
    try {
      final dataString = await rootBundle.loadString(
        'assets/data/food_database.json',
      );
      final List<dynamic> list = jsonDecode(dataString);
      return list
          .map((e) => FoodAnalysisResult.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
