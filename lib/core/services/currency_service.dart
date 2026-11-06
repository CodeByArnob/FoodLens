import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../shared/services/local_storage_service.dart';

class CurrencyInfo {
  final String code;
  final String symbol;
  final String name;
  final String flag;
  final String defaultCountry;

  const CurrencyInfo({
    required this.code,
    required this.symbol,
    required this.name,
    required this.flag,
    required this.defaultCountry,
  });
}

class CurrencyService {
  static const String baseCurrency = 'USD';
  static const String providerName = 'ExchangeRate-API / European Central Bank';

  // Verified baseline exchange rates relative to 1 USD
  static const Map<String, double> fallbackRates = {
    'USD': 1.0,
    'BDT': 122.50,
    'EUR': 0.92,
    'GBP': 0.79,
    'INR': 86.80,
    'SAR': 3.75,
    'AED': 3.67,
    'CAD': 1.38,
    'AUD': 1.54,
    'JPY': 152.00,
    'SGD': 1.35,
    'CHF': 0.88,
    'MYR': 4.45,
    'THB': 34.20,
    'CNY': 7.24,
    'KRW': 1385.00,
  };

  static const List<CurrencyInfo> supportedCurrencies = [
    CurrencyInfo(code: 'USD', symbol: '\$', name: 'US Dollar', flag: '🇺🇸', defaultCountry: 'United States'),
    CurrencyInfo(code: 'BDT', symbol: '৳', name: 'Bangladeshi Taka', flag: '🇧🇩', defaultCountry: 'Bangladesh'),
    CurrencyInfo(code: 'EUR', symbol: '€', name: 'Euro', flag: '🇪🇺', defaultCountry: 'European Union'),
    CurrencyInfo(code: 'GBP', symbol: '£', name: 'British Pound', flag: '🇬🇧', defaultCountry: 'United Kingdom'),
    CurrencyInfo(code: 'INR', symbol: '₹', name: 'Indian Rupee', flag: '🇮🇳', defaultCountry: 'India'),
    CurrencyInfo(code: 'SAR', symbol: 'ر.س', name: 'Saudi Riyal', flag: '🇸🇦', defaultCountry: 'Saudi Arabia'),
    CurrencyInfo(code: 'AED', symbol: 'د.إ', name: 'UAE Dirham', flag: '🇦🇪', defaultCountry: 'United Arab Emirates'),
    CurrencyInfo(code: 'CAD', symbol: 'CA\$', name: 'Canadian Dollar', flag: '🇨🇦', defaultCountry: 'Canada'),
    CurrencyInfo(code: 'AUD', symbol: 'A\$', name: 'Australian Dollar', flag: '🇦🇺', defaultCountry: 'Australia'),
    CurrencyInfo(code: 'JPY', symbol: '¥', name: 'Japanese Yen', flag: '🇯🇵', defaultCountry: 'Japan'),
    CurrencyInfo(code: 'SGD', symbol: 'S\$', name: 'Singapore Dollar', flag: '🇸🇬', defaultCountry: 'Singapore'),
    CurrencyInfo(code: 'CHF', symbol: 'CHF', name: 'Swiss Franc', flag: '🇨🇭', defaultCountry: 'Switzerland'),
    CurrencyInfo(code: 'MYR', symbol: 'RM', name: 'Malaysian Ringgit', flag: '🇲🇾', defaultCountry: 'Malaysia'),
    CurrencyInfo(code: 'THB', symbol: '฿', name: 'Thai Baht', flag: '🇹🇭', defaultCountry: 'Thailand'),
  ];

  final LocalStorageService _storage;
  Map<String, double> _liveRates = Map.from(fallbackRates);
  DateTime _lastUpdated = DateTime.now();

  CurrencyService(this._storage) {
    _loadStoredRates();
  }

  Map<String, double> get rates => _liveRates;
  DateTime get lastUpdated => _lastUpdated;
  String get rateSource => providerName;

  void _loadStoredRates() {
    try {
      final cachedJson = _storage.prefs.getString('cached_exchange_rates');
      if (cachedJson != null) {
        final decoded = jsonDecode(cachedJson) as Map<String, dynamic>;
        _liveRates = decoded.map((k, v) => MapEntry(k, (v as num).toDouble()));
        final timeStr = _storage.prefs.getString('cached_exchange_rates_time');
        if (timeStr != null) {
          _lastUpdated = DateTime.parse(timeStr);
        }
      }
    } catch (e) {
      debugPrint('[CurrencyService] Error loading cached rates: $e');
    }
  }

  Future<void> fetchLiveRates() async {
    try {
      final response = await http
          .get(Uri.parse('https://open.er-api.com/v6/latest/USD'))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['rates'] != null && data['rates'] is Map<String, dynamic>) {
          final Map<String, dynamic> rawRates = data['rates'];
          final updated = <String, double>{};

          for (final key in fallbackRates.keys) {
            if (rawRates.containsKey(key)) {
              updated[key] = (rawRates[key] as num).toDouble();
            } else {
              updated[key] = fallbackRates[key]!;
            }
          }

          _liveRates = updated;
          _lastUpdated = DateTime.now();

          await _storage.prefs.setString('cached_exchange_rates', jsonEncode(_liveRates));
          await _storage.prefs.setString('cached_exchange_rates_time', _lastUpdated.toIso8601String());
          debugPrint('[CurrencyService] Live rates fetched successfully.');
        }
      }
    } catch (e) {
      debugPrint('[CurrencyService] Using fallback rates: $e');
    }
  }

  double convert(double amountInUsd, String targetCurrency) {
    final rate = _liveRates[targetCurrency] ?? fallbackRates[targetCurrency] ?? 1.0;
    return amountInUsd * rate;
  }

  String getSymbol(String currencyCode) {
    final match = supportedCurrencies.firstWhere(
      (c) => c.code == currencyCode,
      orElse: () => CurrencyInfo(code: currencyCode, symbol: currencyCode, name: currencyCode, flag: '🌐', defaultCountry: ''),
    );
    return match.symbol;
  }

  String formatPrice(double amountInUsd, String targetCurrency, {bool showOriginal = false, String locale = 'en'}) {
    final converted = convert(amountInUsd, targetCurrency);
    final symbol = getSymbol(targetCurrency);

    // Format decimals: JPY has 0 decimals, BDT has 0 or 2, USD has 2
    final int decimals = (targetCurrency == 'JPY' || targetCurrency == 'KRW')
        ? 0
        : (converted >= 1000 ? 0 : 2);

    final formatter = NumberFormat.currency(
      symbol: '$symbol ',
      decimalDigits: decimals,
    );

    final formatted = formatter.format(converted).trim();

    if (showOriginal && targetCurrency != 'USD') {
      final origFormatter = NumberFormat.currency(symbol: '\$ ', decimalDigits: 2);
      return '$formatted (${origFormatter.format(amountInUsd).trim()})';
    }

    return formatted;
  }
}
