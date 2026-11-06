import 'package:uuid/uuid.dart';
import '../../../core/errors/app_exception.dart';

class NonFoodImageException extends AppException {
  final String? category;

  NonFoodImageException(super.message, {super.code = 'NON_FOOD_IMAGE', this.category, super.details});

  @override
  String toString() => message;
}

class HealthierAlternative {
  final String name;
  final int calorieDifference; // e.g. -120
  final String reason;

  HealthierAlternative({
    required this.name,
    required this.calorieDifference,
    required this.reason,
  });

  factory HealthierAlternative.fromJson(Map<String, dynamic> json) {
    return HealthierAlternative(
      name: json['name'] as String? ?? 'Alternative Dish',
      calorieDifference: (json['calorie_difference'] as num?)?.toInt() ?? -50,
      reason: json['reason'] as String? ?? 'Nutrient balanced alternative',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'calorie_difference': calorieDifference,
      'reason': reason,
    };
  }
}

class FoodAnalysisResult {
  final String id;
  final String foodName;
  final double confidenceScore;
  final bool isVerifiedLabel;
  final bool isFoodRelated;
  final String detectedCategory;
  final String? rejectionReason;
  final bool isArtificialOrIllustration;
  final bool isAmbiguous;
  final String? ambiguityClarificationPrompt;
  final String? confidenceExplanation;
  final String portionSize;
  final String cuisine;
  final List<String> ingredients;
  final int calories;
  final double protein;
  final double carbohydrates;
  final double fat;
  final double saturatedFat;
  final double fiber;
  final double sugar;
  final double sodium;
  final double potassium;
  final double calcium;
  final double iron;
  final double vitaminC;
  final int healthScore;
  final List<String> healthPros;
  final List<String> healthCons;
  final List<String> allergenWarnings;
  final List<String> dietaryTags;
  final String disclaimer;
  final List<HealthierAlternative> healthierAlternatives;
  final String? imagePath;
  final DateTime timestamp;
  final bool isFavorite;

  FoodAnalysisResult({
    String? id,
    required this.foodName,
    this.confidenceScore = 0.92,
    this.isVerifiedLabel = false,
    this.isFoodRelated = true,
    this.detectedCategory = 'prepared_dish',
    this.rejectionReason,
    this.isArtificialOrIllustration = false,
    this.isAmbiguous = false,
    this.ambiguityClarificationPrompt,
    this.confidenceExplanation,
    this.portionSize = '1 serving',
    this.cuisine = 'Global',
    this.ingredients = const [],
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fat,
    this.saturatedFat = 0.0,
    this.fiber = 0.0,
    this.sugar = 0.0,
    this.sodium = 0.0,
    this.potassium = 0.0,
    this.calcium = 0.0,
    this.iron = 0.0,
    this.vitaminC = 0.0,
    this.healthScore = 75,
    this.healthPros = const [],
    this.healthCons = const [],
    this.allergenWarnings = const [],
    this.dietaryTags = const [],
    this.disclaimer =
        'AI estimate from visual analysis. Actual nutrition & allergens may vary by recipe and kitchen preparation.',
    this.healthierAlternatives = const [],
    this.imagePath,
    DateTime? timestamp,
    this.isFavorite = false,
  })  : id = id ?? const Uuid().v4(),
        timestamp = timestamp ?? DateTime.now();

  factory FoodAnalysisResult.fromJson(Map<String, dynamic> json) {
    return FoodAnalysisResult(
      id: json['id'] as String?,
      foodName: json['food_name'] as String? ?? json['name'] as String? ?? 'Scanned Dish',
      confidenceScore: (json['confidence_score'] as num?)?.toDouble() ?? 0.90,
      isVerifiedLabel: json['is_verified_label'] as bool? ?? false,
      isFoodRelated: json['is_food_related'] as bool? ?? true,
      detectedCategory: json['detected_category'] as String? ?? 'prepared_dish',
      rejectionReason: json['rejection_reason'] as String?,
      isArtificialOrIllustration: json['is_artificial_or_illustration'] as bool? ?? false,
      isAmbiguous: json['is_ambiguous'] as bool? ?? false,
      ambiguityClarificationPrompt: json['ambiguity_clarification_prompt'] as String?,
      confidenceExplanation: json['confidence_explanation'] as String?,
      portionSize: json['portion_size'] as String? ?? '1 standard serving',
      cuisine: json['cuisine'] as String? ?? 'Global Cuisine',
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      calories: (json['calories'] as num?)?.toInt() ?? 0,
      protein: (json['protein'] as num?)?.toDouble() ?? 0.0,
      carbohydrates: (json['carbohydrates'] as num?)?.toDouble() ?? 0.0,
      fat: (json['fat'] as num?)?.toDouble() ?? 0.0,
      saturatedFat: (json['saturated_fat'] as num?)?.toDouble() ?? 0.0,
      fiber: (json['fiber'] as num?)?.toDouble() ?? 0.0,
      sugar: (json['sugar'] as num?)?.toDouble() ?? 0.0,
      sodium: (json['sodium'] as num?)?.toDouble() ?? 0.0,
      potassium: (json['potassium'] as num?)?.toDouble() ?? 0.0,
      calcium: (json['calcium'] as num?)?.toDouble() ?? 0.0,
      iron: (json['iron'] as num?)?.toDouble() ?? 0.0,
      vitaminC: (json['vitamin_c'] as num?)?.toDouble() ?? 0.0,
      healthScore: (json['health_score'] as num?)?.toInt() ?? 75,
      healthPros: (json['health_pros'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      healthCons: (json['health_cons'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      allergenWarnings: (json['allergen_warnings'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      dietaryTags: (json['dietary_tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      disclaimer: json['disclaimer'] as String? ??
          'AI estimate from visual analysis. Always check with manufacturer or kitchen for severe allergies.',
      healthierAlternatives: (json['healthier_alternatives'] as List<dynamic>?)
              ?.map((e) => HealthierAlternative.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      imagePath: json['image_path'] as String?,
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'] as String) ?? DateTime.now()
          : DateTime.now(),
      isFavorite: json['is_favorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'food_name': foodName,
      'confidence_score': confidenceScore,
      'is_verified_label': isVerifiedLabel,
      'is_food_related': isFoodRelated,
      'detected_category': detectedCategory,
      'rejection_reason': rejectionReason,
      'is_artificial_or_illustration': isArtificialOrIllustration,
      'is_ambiguous': isAmbiguous,
      'ambiguity_clarification_prompt': ambiguityClarificationPrompt,
      'confidence_explanation': confidenceExplanation,
      'portion_size': portionSize,
      'cuisine': cuisine,
      'ingredients': ingredients,
      'calories': calories,
      'protein': protein,
      'carbohydrates': carbohydrates,
      'fat': fat,
      'saturated_fat': saturatedFat,
      'fiber': fiber,
      'sugar': sugar,
      'sodium': sodium,
      'potassium': potassium,
      'calcium': calcium,
      'iron': iron,
      'vitamin_c': vitaminC,
      'health_score': healthScore,
      'health_pros': healthPros,
      'health_cons': healthCons,
      'allergen_warnings': allergenWarnings,
      'dietary_tags': dietaryTags,
      'disclaimer': disclaimer,
      'healthier_alternatives': healthierAlternatives.map((e) => e.toJson()).toList(),
      'image_path': imagePath,
      'timestamp': timestamp.toIso8601String(),
      'is_favorite': isFavorite,
    };
  }

  FoodAnalysisResult copyWith({
    String? id,
    String? foodName,
    double? confidenceScore,
    bool? isVerifiedLabel,
    bool? isFoodRelated,
    String? detectedCategory,
    String? rejectionReason,
    bool? isArtificialOrIllustration,
    bool? isAmbiguous,
    String? ambiguityClarificationPrompt,
    String? confidenceExplanation,
    String? portionSize,
    String? cuisine,
    List<String>? ingredients,
    int? calories,
    double? protein,
    double? carbohydrates,
    double? fat,
    double? saturatedFat,
    double? fiber,
    double? sugar,
    double? sodium,
    double? potassium,
    double? calcium,
    double? iron,
    double? vitaminC,
    int? healthScore,
    List<String>? healthPros,
    List<String>? healthCons,
    List<String>? allergenWarnings,
    List<String>? dietaryTags,
    String? disclaimer,
    List<HealthierAlternative>? healthierAlternatives,
    String? imagePath,
    DateTime? timestamp,
    bool? isFavorite,
  }) {
    return FoodAnalysisResult(
      id: id ?? this.id,
      foodName: foodName ?? this.foodName,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      isVerifiedLabel: isVerifiedLabel ?? this.isVerifiedLabel,
      isFoodRelated: isFoodRelated ?? this.isFoodRelated,
      detectedCategory: detectedCategory ?? this.detectedCategory,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      isArtificialOrIllustration: isArtificialOrIllustration ?? this.isArtificialOrIllustration,
      isAmbiguous: isAmbiguous ?? this.isAmbiguous,
      ambiguityClarificationPrompt: ambiguityClarificationPrompt ?? this.ambiguityClarificationPrompt,
      confidenceExplanation: confidenceExplanation ?? this.confidenceExplanation,
      portionSize: portionSize ?? this.portionSize,
      cuisine: cuisine ?? this.cuisine,
      ingredients: ingredients ?? this.ingredients,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      fat: fat ?? this.fat,
      saturatedFat: saturatedFat ?? this.saturatedFat,
      fiber: fiber ?? this.fiber,
      sugar: sugar ?? this.sugar,
      sodium: sodium ?? this.sodium,
      potassium: potassium ?? this.potassium,
      calcium: calcium ?? this.calcium,
      iron: iron ?? this.iron,
      vitaminC: vitaminC ?? this.vitaminC,
      healthScore: healthScore ?? this.healthScore,
      healthPros: healthPros ?? this.healthPros,
      healthCons: healthCons ?? this.healthCons,
      allergenWarnings: allergenWarnings ?? this.allergenWarnings,
      dietaryTags: dietaryTags ?? this.dietaryTags,
      disclaimer: disclaimer ?? this.disclaimer,
      healthierAlternatives: healthierAlternatives ?? this.healthierAlternatives,
      imagePath: imagePath ?? this.imagePath,
      timestamp: timestamp ?? this.timestamp,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
