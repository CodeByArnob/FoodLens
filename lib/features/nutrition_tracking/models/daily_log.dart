import 'meal_log_item.dart';

class DailyLog {
  final String dateKey; // 'yyyy-MM-dd'
  final List<MealLogItem> meals;
  final int waterIntakeMl;

  DailyLog({
    required this.dateKey,
    this.meals = const [],
    this.waterIntakeMl = 0,
  });

  int get totalCalories => meals.fold(0, (sum, m) => sum + m.calories);
  double get totalProtein => meals.fold(0.0, (sum, m) => sum + m.protein);
  double get totalCarbs => meals.fold(0.0, (sum, m) => sum + m.carbohydrates);
  double get totalFat => meals.fold(0.0, (sum, m) => sum + m.fat);
  double get totalFiber => meals.fold(0.0, (sum, m) => sum + (m.carbohydrates * 0.12));

  List<MealLogItem> get breakfastMeals =>
      meals.where((m) => m.mealType == MealType.breakfast).toList();
  List<MealLogItem> get lunchMeals =>
      meals.where((m) => m.mealType == MealType.lunch).toList();
  List<MealLogItem> get dinnerMeals =>
      meals.where((m) => m.mealType == MealType.dinner).toList();
  List<MealLogItem> get snackMeals =>
      meals.where((m) => m.mealType == MealType.snack).toList();

  factory DailyLog.fromJson(Map<String, dynamic> json) {
    return DailyLog(
      dateKey: json['date_key'] as String? ?? '2026-11-05',
      meals: (json['meals'] as List<dynamic>?)
              ?.map((e) => MealLogItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      waterIntakeMl: (json['water_intake_ml'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date_key': dateKey,
      'meals': meals.map((e) => e.toJson()).toList(),
      'water_intake_ml': waterIntakeMl,
    };
  }

  DailyLog copyWith({
    String? dateKey,
    List<MealLogItem>? meals,
    int? waterIntakeMl,
  }) {
    return DailyLog(
      dateKey: dateKey ?? this.dateKey,
      meals: meals ?? this.meals,
      waterIntakeMl: waterIntakeMl ?? this.waterIntakeMl,
    );
  }
}
