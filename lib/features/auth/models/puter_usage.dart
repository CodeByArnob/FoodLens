class PuterUsage {
  final double totalAllowance;
  final double usedAllowance;
  final double remainingAllowance;
  final double percentUsed;
  final String status;
  final bool hasExhaustedAllowance;

  PuterUsage({
    required this.totalAllowance,
    required this.usedAllowance,
    required this.remainingAllowance,
    required this.percentUsed,
    this.status = 'active',
    this.hasExhaustedAllowance = false,
  });

  factory PuterUsage.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return PuterUsage.defaultFreeTier();
    }

    final allowanceInfo = json['allowanceInfo'] as Map<String, dynamic>? ?? json;

    final total = (allowanceInfo['allowance'] as num?)?.toDouble() ??
        (allowanceInfo['total'] as num?)?.toDouble() ??
        10000000.0; // 10M microcents ($10) free default on Puter

    final used = (allowanceInfo['used'] as num?)?.toDouble() ??
        (allowanceInfo['cost'] as num?)?.toDouble() ??
        0.0;

    final remaining = (allowanceInfo['remaining'] as num?)?.toDouble() ??
        (total - used).clamp(0.0, total);

    final percent = total > 0 ? (used / total).clamp(0.0, 1.0) : 0.0;
    final exhausted = remaining <= 0;

    return PuterUsage(
      totalAllowance: total,
      usedAllowance: used,
      remainingAllowance: remaining,
      percentUsed: percent,
      status: exhausted ? 'insufficient_funds' : 'active',
      hasExhaustedAllowance: exhausted,
    );
  }

  factory PuterUsage.defaultFreeTier() {
    return PuterUsage(
      totalAllowance: 10000000.0,
      usedAllowance: 1250000.0,
      remainingAllowance: 8750000.0,
      percentUsed: 0.125,
      status: 'active',
      hasExhaustedAllowance: false,
    );
  }

  factory PuterUsage.exhausted() {
    return PuterUsage(
      totalAllowance: 10000000.0,
      usedAllowance: 10000000.0,
      remainingAllowance: 0.0,
      percentUsed: 1.0,
      status: 'insufficient_funds',
      hasExhaustedAllowance: true,
    );
  }

  /// Formatted credits for human display
  String get remainingCreditsFormatted {
    final remainingDollars = remainingAllowance / 1000000.0; // convert microcents to $ equivalent
    return '\$${remainingDollars.toStringAsFixed(2)}';
  }

  String get totalCreditsFormatted {
    final totalDollars = totalAllowance / 1000000.0;
    return '\$${totalDollars.toStringAsFixed(2)}';
  }

  String get usedCreditsFormatted {
    final usedDollars = usedAllowance / 1000000.0;
    return '\$${usedDollars.toStringAsFixed(2)}';
  }
}
