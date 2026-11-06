class UnitConverter {
  /// Converts grams to ounces
  static double gramsToOunces(double grams) {
    return grams * 0.035274;
  }

  /// Converts ounces to grams
  static double ouncesToGrams(double oz) {
    return oz / 0.035274;
  }

  /// Format weight according to selected unit system ('metric' or 'imperial')
  static String formatWeight(double grams, {required bool isMetric}) {
    if (isMetric) {
      if (grams >= 1000) {
        return '${(grams / 1000).toStringAsFixed(1)} kg';
      }
      return '${grams.toStringAsFixed(grams % 1 == 0 ? 0 : 1)} g';
    } else {
      final oz = gramsToOunces(grams);
      if (oz >= 16) {
        return '${(oz / 16).toStringAsFixed(1)} lbs';
      }
      return '${oz.toStringAsFixed(1)} oz';
    }
  }

  /// Format liquid volume (ml vs fl oz)
  static String formatVolume(double ml, {required bool isMetric}) {
    if (isMetric) {
      if (ml >= 1000) {
        return '${(ml / 1000).toStringAsFixed(1)} L';
      }
      return '${ml.toStringAsFixed(0)} ml';
    } else {
      final flOz = ml * 0.033814;
      return '${flOz.toStringAsFixed(1)} fl oz';
    }
  }
}
