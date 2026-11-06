import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class CalorieGauge extends StatelessWidget {
  final int consumedCalories;
  final int targetCalories;
  final double size;

  const CalorieGauge({
    super.key,
    required this.consumedCalories,
    required this.targetCalories,
    this.size = 180,
  });

  @override
  Widget build(BuildContext context) {
    final double percent = targetCalories > 0
        ? (consumedCalories / targetCalories).clamp(0.0, 1.5)
        : 0.0;
    final int remaining = max(0, targetCalories - consumedCalories);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _CalorieGaugePainter(
              progress: percent,
              primaryColor: AppColors.primary,
              trackColor: AppColors.darkSurfaceHighlight.withValues(alpha: 0.4),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$consumedCalories',
                style: TextStyle(
                  fontSize: size * 0.18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                'kcal consumed',
                style: TextStyle(
                  fontSize: size * 0.07,
                  color: AppColors.textMutedDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  remaining > 0 ? '$remaining left' : 'Goal met!',
                  style: TextStyle(
                    fontSize: size * 0.065,
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CalorieGaugePainter extends CustomPainter {
  final double progress;
  final Color primaryColor;
  final Color trackColor;

  _CalorieGaugePainter({
    required this.progress,
    required this.primaryColor,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;
    const strokeWidth = 14.0;

    // Track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = 0.75 * pi;
    const sweepAngle = 1.5 * pi;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      trackPaint,
    );

    // Progress Arc with Gradient
    final progressPaint = Paint()
      ..shader = const SweepGradient(
        colors: [Color(0xFF34D399), Color(0xFF10B981), Color(0xFF0EA5E9)],
        startAngle: 0.75 * pi,
        endAngle: 2.25 * pi,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final currentSweep = sweepAngle * progress.clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      currentSweep,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CalorieGaugePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
