class MenuItemDish {
  final String id;
  final String name;
  final String description;
  final String priceRaw;
  final double priceValue;
  final int estimatedCalories;
  final double protein;
  final double carbs;
  final double fat;
  final List<String> dietaryTags;
  final List<String> allergens;
  final String healthRating; // 'A', 'B', 'C', 'D'

  MenuItemDish({
    required this.id,
    required this.name,
    this.description = '',
    required this.priceRaw,
    required this.priceValue,
    required this.estimatedCalories,
    this.protein = 0.0,
    this.carbs = 0.0,
    this.fat = 0.0,
    this.dietaryTags = const [],
    this.allergens = const [],
    this.healthRating = 'B',
  });

  factory MenuItemDish.fromJson(Map<String, dynamic> json) {
    return MenuItemDish(
      id: json['id'] as String? ?? UniqueKey().toString(),
      name: json['name'] as String? ?? 'Menu Dish',
      description: json['description'] as String? ?? '',
      priceRaw: json['price_raw'] as String? ?? '\$0.00',
      priceValue: (json['price_value'] as num?)?.toDouble() ?? 0.0,
      estimatedCalories: (json['estimated_calories'] as num?)?.toInt() ?? 450,
      protein: (json['protein'] as num?)?.toDouble() ?? 20.0,
      carbs: (json['carbs'] as num?)?.toDouble() ?? 40.0,
      fat: (json['fat'] as num?)?.toDouble() ?? 15.0,
      dietaryTags:
          (json['dietary_tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      allergens:
          (json['allergens'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      healthRating: json['health_rating'] as String? ?? 'B',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price_raw': priceRaw,
      'price_value': priceValue,
      'estimated_calories': estimatedCalories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'dietary_tags': dietaryTags,
      'allergens': allergens,
      'health_rating': healthRating,
    };
  }
}

class MenuAnalysisResult {
  final String restaurantName;
  final String cuisineType;
  final String currency;
  final List<MenuItemDish> dishes;

  MenuAnalysisResult({
    required this.restaurantName,
    required this.cuisineType,
    required this.currency,
    required this.dishes,
  });

  factory MenuAnalysisResult.fromJson(Map<String, dynamic> json) {
    return MenuAnalysisResult(
      restaurantName: json['restaurant_name'] as String? ?? 'Restaurant Menu',
      cuisineType: json['cuisine_type'] as String? ?? 'Culinary Menu',
      currency: json['currency'] as String? ?? '\$',
      dishes:
          (json['dishes'] as List<dynamic>?)
              ?.map((e) => MenuItemDish.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurant_name': restaurantName,
      'cuisine_type': cuisineType,
      'currency': currency,
      'dishes': dishes.map((e) => e.toJson()).toList(),
    };
  }
}

class UniqueKey {
  @override
  String toString() => DateTime.now().microsecondsSinceEpoch.toString();
}
