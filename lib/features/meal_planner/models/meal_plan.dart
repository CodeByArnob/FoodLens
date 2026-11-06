class PlannedMeal {
  final String mealType; // 'Breakfast', 'Lunch', 'Dinner', 'Snacks'
  final String dishName;
  final String portion;
  final int calories;
  final double protein;
  final double carbs;
  final double fat;
  final int prepTimeMinutes;
  final List<String> ingredients;
  final String instructions;

  PlannedMeal({
    required this.mealType,
    required this.dishName,
    required this.portion,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.prepTimeMinutes = 15,
    this.ingredients = const [],
    this.instructions = '',
  });

  factory PlannedMeal.fromJson(Map<String, dynamic> json) {
    return PlannedMeal(
      mealType: json['meal_type'] as String? ?? 'Meal',
      dishName: json['dish_name'] as String? ?? 'Dish',
      portion: json['portion'] as String? ?? '1 portion',
      calories: (json['calories'] as num?)?.toInt() ?? 400,
      protein: (json['protein'] as num?)?.toDouble() ?? 20.0,
      carbs: (json['carbs'] as num?)?.toDouble() ?? 40.0,
      fat: (json['fat'] as num?)?.toDouble() ?? 12.0,
      prepTimeMinutes: (json['prep_time_minutes'] as num?)?.toInt() ?? 15,
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      instructions: json['instructions'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meal_type': mealType,
      'dish_name': dishName,
      'portion': portion,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'prep_time_minutes': prepTimeMinutes,
      'ingredients': ingredients,
      'instructions': instructions,
    };
  }
}

class MealPlan {
  final String planTitle;
  final int totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFat;
  final List<PlannedMeal> meals;
  final String nutritionalSummary;

  MealPlan({
    required this.planTitle,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFat,
    required this.meals,
    this.nutritionalSummary = '',
  });

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    return MealPlan(
      planTitle: json['plan_title'] as String? ?? 'Personalized Meal Plan',
      totalCalories: (json['total_calories'] as num?)?.toInt() ?? 2000,
      totalProtein: (json['total_protein'] as num?)?.toDouble() ?? 120.0,
      totalCarbs: (json['total_carbs'] as num?)?.toDouble() ?? 200.0,
      totalFat: (json['total_fat'] as num?)?.toDouble() ?? 60.0,
      meals: (json['meals'] as List<dynamic>?)
              ?.map((e) => PlannedMeal.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      nutritionalSummary: json['nutritional_summary'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plan_title': planTitle,
      'total_calories': totalCalories,
      'total_protein': totalProtein,
      'total_carbs': totalCarbs,
      'total_fat': totalFat,
      'meals': meals.map((e) => e.toJson()).toList(),
      'nutritional_summary': nutritionalSummary,
    };
  }
}
