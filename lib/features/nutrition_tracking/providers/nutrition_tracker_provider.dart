import 'package:flutter_riverpod/legacy.dart';
import 'package:intl/intl.dart';
import '../models/daily_log.dart';
import '../models/meal_log_item.dart';
import '../../scanner/models/food_analysis_result.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../shared/services/local_storage_service.dart';

class NutritionTrackerState {
  final DateTime selectedDate;
  final List<DailyLog> logs;

  const NutritionTrackerState({
    required this.selectedDate,
    this.logs = const [],
  });

  String get selectedDateKey => DateFormat('yyyy-MM-dd').format(selectedDate);

  DailyLog get todayLog {
    final key = selectedDateKey;
    return logs.firstWhere(
      (log) => log.dateKey == key,
      orElse: () => DailyLog(dateKey: key),
    );
  }

  NutritionTrackerState copyWith({
    DateTime? selectedDate,
    List<DailyLog>? logs,
  }) {
    return NutritionTrackerState(
      selectedDate: selectedDate ?? this.selectedDate,
      logs: logs ?? this.logs,
    );
  }
}

final nutritionTrackerProvider =
    StateNotifierProvider<NutritionTrackerNotifier, NutritionTrackerState>((ref) {
  final storage = ref.watch(localStorageServiceProvider);
  return NutritionTrackerNotifier(storage);
});

class NutritionTrackerNotifier extends StateNotifier<NutritionTrackerState> {
  final LocalStorageService _storage;

  NutritionTrackerNotifier(this._storage)
      : super(NutritionTrackerState(selectedDate: DateTime.now())) {
    _loadLogs();
  }

  void _loadLogs() {
    final savedLogs = _storage.getDailyLogs();
    if (savedLogs.isEmpty) {
      final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final initialLog = DailyLog(
        dateKey: todayKey,
        waterIntakeMl: 1250,
        meals: [
          MealLogItem(
            foodName: 'Avocado Sourdough Toast',
            mealType: MealType.breakfast,
            calories: 340,
            protein: 14.5,
            carbohydrates: 28.0,
            fat: 19.5,
          ),
        ],
      );
      state = state.copyWith(logs: [initialLog]);
      _storage.saveDailyLogs([initialLog]);
    } else {
      state = state.copyWith(logs: savedLogs);
    }
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  Future<void> logFoodItem(FoodAnalysisResult food, MealType mealType) async {
    final key = state.selectedDateKey;
    final item = MealLogItem(
      foodName: food.foodName,
      mealType: mealType,
      calories: food.calories,
      protein: food.protein,
      carbohydrates: food.carbohydrates,
      fat: food.fat,
      imagePath: food.imagePath,
    );

    final currentLogs = List<DailyLog>.from(state.logs);
    final logIndex = currentLogs.indexWhere((l) => l.dateKey == key);

    if (logIndex >= 0) {
      final existing = currentLogs[logIndex];
      final updatedMeals = List<MealLogItem>.from(existing.meals)..add(item);
      currentLogs[logIndex] = existing.copyWith(meals: updatedMeals);
    } else {
      currentLogs.add(DailyLog(dateKey: key, meals: [item]));
    }

    state = state.copyWith(logs: currentLogs);
    await _storage.saveDailyLogs(currentLogs);
  }

  Future<void> removeMealItem(String mealId) async {
    final key = state.selectedDateKey;
    final currentLogs = List<DailyLog>.from(state.logs);
    final logIndex = currentLogs.indexWhere((l) => l.dateKey == key);

    if (logIndex >= 0) {
      final existing = currentLogs[logIndex];
      final updatedMeals = existing.meals.where((m) => m.id != mealId).toList();
      currentLogs[logIndex] = existing.copyWith(meals: updatedMeals);
      state = state.copyWith(logs: currentLogs);
      await _storage.saveDailyLogs(currentLogs);
    }
  }

  Future<void> addWater(int amountMl) async {
    final key = state.selectedDateKey;
    final currentLogs = List<DailyLog>.from(state.logs);
    final logIndex = currentLogs.indexWhere((l) => l.dateKey == key);

    if (logIndex >= 0) {
      final existing = currentLogs[logIndex];
      final updatedWater = (existing.waterIntakeMl + amountMl).clamp(0, 10000);
      currentLogs[logIndex] = existing.copyWith(waterIntakeMl: updatedWater);
    } else {
      currentLogs.add(DailyLog(dateKey: key, waterIntakeMl: amountMl));
    }

    state = state.copyWith(logs: currentLogs);
    await _storage.saveDailyLogs(currentLogs);
  }
}
