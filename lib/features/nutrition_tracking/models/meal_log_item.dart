import 'package:uuid/uuid.dart';

enum MealType { breakfast, lunch, dinner, snack }

class MealLogItem {
  final String id;
  final String foodName;
  final MealType mealType;
  final int calories;
  final double protein;
  final double carbohydrates;
  final double fat;
  final DateTime timestamp;
  final String? imagePath;

  MealLogItem({
    String? id,
    required this.foodName,
    required this.mealType,
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fat,
    DateTime? timestamp,
    this.imagePath,
  }) : id = id ?? const Uuid().v4(),
       timestamp = timestamp ?? DateTime.now();

  factory MealLogItem.fromJson(Map<String, dynamic> json) {
    return MealLogItem(
      id: json['id'] as String?,
      foodName: json['food_name'] as String? ?? 'Food Entry',
      mealType: MealType.values.firstWhere(
        (e) => e.name == json['meal_type'],
        orElse: () => MealType.lunch,
      ),
      calories: (json['calories'] as num?)?.toInt() ?? 0,
      protein: (json['protein'] as num?)?.toDouble() ?? 0.0,
      carbohydrates: (json['carbohydrates'] as num?)?.toDouble() ?? 0.0,
      fat: (json['fat'] as num?)?.toDouble() ?? 0.0,
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'] as String) ?? DateTime.now()
          : DateTime.now(),
      imagePath: json['image_path'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'food_name': foodName,
      'meal_type': mealType.name,
      'calories': calories,
      'protein': protein,
      'carbohydrates': carbohydrates,
      'fat': fat,
      'timestamp': timestamp.toIso8601String(),
      'image_path': imagePath,
    };
  }
}
