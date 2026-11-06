class ComparisonPoint {
  final String category;
  final String betterItem;
  final String explanation;

  ComparisonPoint({
    required this.category,
    required this.betterItem,
    required this.explanation,
  });

  factory ComparisonPoint.fromJson(Map<String, dynamic> json) {
    return ComparisonPoint(
      category: json['category'] as String? ?? 'Nutritional Balance',
      betterItem: json['better_item'] as String? ?? 'Item 1',
      explanation: json['explanation'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'better_item': betterItem,
      'explanation': explanation,
    };
  }
}

class ComparisonResult {
  final String winner;
  final String verdictSummary;
  final int calorieDiff;
  final double proteinDiff;
  final double sugarDiff;
  final double sodiumDiff;
  final List<ComparisonPoint> comparisonPoints;
  final Map<String, String> recommendationByGoal;

  ComparisonResult({
    required this.winner,
    required this.verdictSummary,
    this.calorieDiff = 0,
    this.proteinDiff = 0.0,
    this.sugarDiff = 0.0,
    this.sodiumDiff = 0.0,
    this.comparisonPoints = const [],
    this.recommendationByGoal = const {},
  });

  factory ComparisonResult.fromJson(Map<String, dynamic> json) {
    return ComparisonResult(
      winner: json['winner'] as String? ?? 'Balanced Choice',
      verdictSummary: json['verdict_summary'] as String? ?? '',
      calorieDiff: (json['calorie_diff'] as num?)?.toInt() ?? 0,
      proteinDiff: (json['protein_diff'] as num?)?.toDouble() ?? 0.0,
      sugarDiff: (json['sugar_diff'] as num?)?.toDouble() ?? 0.0,
      sodiumDiff: (json['sodium_diff'] as num?)?.toDouble() ?? 0.0,
      comparisonPoints:
          (json['comparison_points'] as List<dynamic>?)
              ?.map((e) => ComparisonPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      recommendationByGoal:
          (json['recommendation_by_goal'] as Map<String, dynamic>?)?.map(
            (k, v) => MapEntry(k, v.toString()),
          ) ??
          {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'winner': winner,
      'verdict_summary': verdictSummary,
      'calorie_diff': calorieDiff,
      'protein_diff': proteinDiff,
      'sugar_diff': sugarDiff,
      'sodium_diff': sodiumDiff,
      'comparison_points': comparisonPoints.map((e) => e.toJson()).toList(),
      'recommendation_by_goal': recommendationByGoal,
    };
  }
}
