import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/constants/app_colors.dart';

class MacroDonutChart extends StatelessWidget {
  final double proteinGrams;
  final double carbsGrams;
  final double fatGrams;
  final double size;

  const MacroDonutChart({
    super.key,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatGrams,
    this.size = 140,
  });

  @override
  Widget build(BuildContext context) {
    final totalGrams = proteinGrams + carbsGrams + fatGrams;
    final pPct = totalGrams > 0
        ? (proteinGrams / totalGrams * 100).round()
        : 33;
    final cPct = totalGrams > 0 ? (carbsGrams / totalGrams * 100).round() : 33;
    final fPct = totalGrams > 0 ? (fatGrams / totalGrams * 100).round() : 34;

    return SizedBox(
      width: size,
      height: size,
      child: PieChart(
        PieChartData(
          sectionsSpace: 3,
          centerSpaceRadius: size * 0.32,
          sections: [
            PieChartSectionData(
              color: AppColors.protein,
              value: proteinGrams <= 0 ? 1 : proteinGrams,
              title: '$pPct%',
              radius: size * 0.16,
              titleStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              color: AppColors.carbs,
              value: carbsGrams <= 0 ? 1 : carbsGrams,
              title: '$cPct%',
              radius: size * 0.16,
              titleStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              color: AppColors.fat,
              value: fatGrams <= 0 ? 1 : fatGrams,
              title: '$fPct%',
              radius: size * 0.16,
              titleStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
