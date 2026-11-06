import 'package:flutter_riverpod/legacy.dart';
import '../models/comparison_result.dart';
import '../../scanner/models/food_analysis_result.dart';
import '../../auth/providers/auth_provider.dart';

class FoodComparisonState {
  final FoodAnalysisResult? foodA;
  final FoodAnalysisResult? foodB;
  final bool isComparing;
  final ComparisonResult? result;
  final String? errorMessage;

  const FoodComparisonState({
    this.foodA,
    this.foodB,
    this.isComparing = false,
    this.result,
    this.errorMessage,
  });

  bool get canCompare => foodA != null && foodB != null;

  FoodComparisonState copyWith({
    FoodAnalysisResult? foodA,
    FoodAnalysisResult? foodB,
    bool? isComparing,
    ComparisonResult? result,
    String? errorMessage,
    bool clearResult = false,
  }) {
    return FoodComparisonState(
      foodA: foodA ?? this.foodA,
      foodB: foodB ?? this.foodB,
      isComparing: isComparing ?? this.isComparing,
      result: clearResult ? null : (result ?? this.result),
      errorMessage: errorMessage,
    );
  }
}

final foodComparisonProvider =
    StateNotifierProvider<FoodComparisonNotifier, FoodComparisonState>((ref) {
      final bridge = ref.watch(puterBridgeServiceProvider);
      final storage = ref.watch(localStorageServiceProvider);
      return FoodComparisonNotifier(bridge, storage);
    });

class FoodComparisonNotifier extends StateNotifier<FoodComparisonState> {
  final dynamic _bridge;
  final dynamic _storage;

  FoodComparisonNotifier(this._bridge, this._storage)
    : super(const FoodComparisonState()) {
    _initDefaults();
  }

  Future<void> _initDefaults() async {
    final history = _storage.getScanHistory();
    if (history.length >= 2) {
      state = state.copyWith(foodA: history[0], foodB: history[1]);
    } else {
      final seeds = await _storage.loadSeedDatabase();
      if (seeds.length >= 2) {
        state = state.copyWith(foodA: seeds[0], foodB: seeds[1]);
      }
    }
  }

  void selectFoodA(FoodAnalysisResult food) {
    state = state.copyWith(foodA: food, clearResult: true);
  }

  void selectFoodB(FoodAnalysisResult food) {
    state = state.copyWith(foodB: food, clearResult: true);
  }

  Future<void> runComparison() async {
    if (!state.canCompare) return;

    state = state.copyWith(isComparing: true, errorMessage: null);

    try {
      final res = await _bridge.compareFoods(
        foodA: state.foodA!.toJson(),
        foodB: state.foodB!.toJson(),
      );

      state = state.copyWith(result: res, isComparing: false);
    } catch (e) {
      final calDiff = state.foodA!.calories - state.foodB!.calories;
      final protDiff = state.foodA!.protein - state.foodB!.protein;
      final winner = state.foodA!.healthScore >= state.foodB!.healthScore
          ? state.foodA!.foodName
          : state.foodB!.foodName;

      final fallback = ComparisonResult(
        winner: winner,
        verdictSummary:
            '${state.foodA!.foodName} delivers ${state.foodA!.calories} kcal with ${state.foodA!.protein.toStringAsFixed(1)}g protein, compared to ${state.foodB!.foodName}\'s ${state.foodB!.calories} kcal and ${state.foodB!.protein.toStringAsFixed(1)}g protein.',
        calorieDiff: calDiff,
        proteinDiff: protDiff,
        comparisonPoints: [
          ComparisonPoint(
            category: 'Calorie Density',
            betterItem: calDiff < 0
                ? state.foodA!.foodName
                : state.foodB!.foodName,
            explanation: 'Lower overall caloric footprint per portion.',
          ),
          ComparisonPoint(
            category: 'Protein Density',
            betterItem: protDiff > 0
                ? state.foodA!.foodName
                : state.foodB!.foodName,
            explanation:
                'Higher percentage of energy derived from amino acids.',
          ),
        ],
        recommendationByGoal: {
          'Weight Management': calDiff < 0
              ? state.foodA!.foodName
              : state.foodB!.foodName,
          'Muscle Hypertrophy': protDiff > 0
              ? state.foodA!.foodName
              : state.foodB!.foodName,
        },
      );

      state = state.copyWith(result: fallback, isComparing: false);
    }
  }
}
