class LabelAnalysisResult {
  final String productName;
  final bool isVerifiedLabel;
  final double confidenceScore;
  final String servingSize;
  final double servingsPerContainer;
  final int calories;
  final double fat;
  final double saturatedFat;
  final double transFat;
  final double cholesterol;
  final double sodium;
  final double carbohydrates;
  final double fiber;
  final double sugar;
  final double addedSugars;
  final double protein;
  final double vitaminD;
  final double calcium;
  final double iron;
  final double potassium;
  final List<String> ingredients;
  final List<String> allergenWarnings;
  final int healthScore;

  LabelAnalysisResult({
    required this.productName,
    this.isVerifiedLabel = true,
    this.confidenceScore = 0.99,
    required this.servingSize,
    this.servingsPerContainer = 1.0,
    required this.calories,
    required this.fat,
    this.saturatedFat = 0.0,
    this.transFat = 0.0,
    this.cholesterol = 0.0,
    required this.sodium,
    required this.carbohydrates,
    this.fiber = 0.0,
    this.sugar = 0.0,
    this.addedSugars = 0.0,
    required this.protein,
    this.vitaminD = 0.0,
    this.calcium = 0.0,
    this.iron = 0.0,
    this.potassium = 0.0,
    this.ingredients = const [],
    this.allergenWarnings = const [],
    this.healthScore = 70,
  });

  factory LabelAnalysisResult.fromJson(Map<String, dynamic> json) {
    return LabelAnalysisResult(
      productName: json['product_name'] as String? ?? 'Packaged Food Item',
      isVerifiedLabel: json['is_verified_label'] as bool? ?? true,
      confidenceScore: (json['confidence_score'] as num?)?.toDouble() ?? 0.99,
      servingSize: json['serving_size'] as String? ?? '1 serving',
      servingsPerContainer:
          (json['servings_per_container'] as num?)?.toDouble() ?? 1.0,
      calories: (json['calories'] as num?)?.toInt() ?? 0,
      fat: (json['fat'] as num?)?.toDouble() ?? 0.0,
      saturatedFat: (json['saturated_fat'] as num?)?.toDouble() ?? 0.0,
      transFat: (json['trans_fat'] as num?)?.toDouble() ?? 0.0,
      cholesterol: (json['cholesterol'] as num?)?.toDouble() ?? 0.0,
      sodium: (json['sodium'] as num?)?.toDouble() ?? 0.0,
      carbohydrates: (json['carbohydrates'] as num?)?.toDouble() ?? 0.0,
      fiber: (json['fiber'] as num?)?.toDouble() ?? 0.0,
      sugar: (json['sugar'] as num?)?.toDouble() ?? 0.0,
      addedSugars: (json['added_sugars'] as num?)?.toDouble() ?? 0.0,
      protein: (json['protein'] as num?)?.toDouble() ?? 0.0,
      vitaminD: (json['vitamin_d'] as num?)?.toDouble() ?? 0.0,
      calcium: (json['calcium'] as num?)?.toDouble() ?? 0.0,
      iron: (json['iron'] as num?)?.toDouble() ?? 0.0,
      potassium: (json['potassium'] as num?)?.toDouble() ?? 0.0,
      ingredients:
          (json['ingredients'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      allergenWarnings:
          (json['allergen_warnings'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      healthScore: (json['health_score'] as num?)?.toInt() ?? 70,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_name': productName,
      'is_verified_label': isVerifiedLabel,
      'confidence_score': confidenceScore,
      'serving_size': servingSize,
      'servings_per_container': servingsPerContainer,
      'calories': calories,
      'fat': fat,
      'saturated_fat': saturatedFat,
      'trans_fat': transFat,
      'cholesterol': cholesterol,
      'sodium': sodium,
      'carbohydrates': carbohydrates,
      'fiber': fiber,
      'sugar': sugar,
      'added_sugars': addedSugars,
      'protein': protein,
      'vitamin_d': vitaminD,
      'calcium': calcium,
      'iron': iron,
      'potassium': potassium,
      'ingredients': ingredients,
      'allergen_warnings': allergenWarnings,
      'health_score': healthScore,
    };
  }
}
