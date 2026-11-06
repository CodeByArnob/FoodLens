import '../services/currency_service.dart';

class CurrencyFormatter {
  static String format(
    double amountInUsd, {
    String currencyCode = 'USD',
    String? symbol,
    bool showOriginal = false,
  }) {
    final rate = CurrencyService.fallbackRates[currencyCode] ?? 1.0;
    final converted = amountInUsd * rate;

    String sym = symbol ?? '\$';
    if (symbol == null || symbol.isEmpty) {
      if (currencyCode == 'BDT') {
        sym = '৳';
      } else if (currencyCode == 'EUR') {
        sym = '€';
      } else if (currencyCode == 'GBP') {
        sym = '£';
      } else if (currencyCode == 'INR') {
        sym = '₹';
      } else if (currencyCode == 'SAR') {
        sym = 'ر.স';
      } else if (currencyCode == 'AED') {
        sym = 'د.إ';
      } else if (currencyCode == 'JPY') {
        sym = '¥';
      } else if (currencyCode == 'CAD') {
        sym = 'CA\$';
      } else if (currencyCode == 'AUD') {
        sym = 'A\$';
      }
    }

    final int decimals = (currencyCode == 'JPY' || currencyCode == 'KRW')
        ? 0
        : (converted >= 1000 ? 0 : 2);

    // Format with thousand separators
    final parts = converted.toStringAsFixed(decimals).split('.');
    final integerPart = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    final formattedNum = parts.length > 1 ? '$integerPart.${parts[1]}' : integerPart;
    final result = '$sym $formattedNum';

    if (showOriginal && currencyCode != 'USD') {
      return '$result (\$ ${amountInUsd.toStringAsFixed(2)})';
    }
    return result;
  }
}
