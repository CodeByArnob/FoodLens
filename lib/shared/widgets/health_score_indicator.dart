import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class HealthScoreIndicator extends StatelessWidget {
  final int score;
  final double confidenceScore;
  final bool isVerified;

  const HealthScoreIndicator({
    super.key,
    required this.score,
    required this.confidenceScore,
    this.isVerified = false,
  });

  Color get scoreColor {
    if (score >= 80) return AppColors.primary;
    if (score >= 60) return AppColors.tertiary;
    return AppColors.accentRose;
  }

  String get scoreGrade {
    if (score >= 90) return 'A+';
    if (score >= 80) return 'A';
    if (score >= 70) return 'B';
    if (score >= 60) return 'C';
    return 'D';
  }

  @override
  Widget build(BuildContext context) {
    final confPercent = (confidenceScore * 100).round();

    return Row(
      children: [
        // Circular Health Gauge
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: scoreColor.withValues(alpha: 0.15),
            border: Border.all(color: scoreColor, width: 2),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$score',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: scoreColor,
                  height: 1.1,
                ),
              ),
              Text(
                'SCORE',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: scoreColor,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        // Score description & Verification tag
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'Health Index: Grade $scoreGrade',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: scoreColor,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: isVerified
                          ? AppColors.primary.withValues(alpha: 0.15)
                          : AppColors.secondary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isVerified
                            ? AppColors.primary.withValues(alpha: 0.4)
                            : AppColors.secondary.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      isVerified ? 'VERIFIED LABEL' : 'AI ESTIMATE',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: isVerified
                            ? AppColors.primaryLight
                            : AppColors.secondaryLight,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                isVerified
                    ? '100% precision from verified manufacturer nutrition panel'
                    : 'Visual recognition confidence: $confPercent%',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMutedDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
