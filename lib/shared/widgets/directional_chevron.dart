import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// An arrow/chevron widget that automatically points forward in the active text direction.
/// In LTR, points right (>). In RTL (Arabic/Hebrew), points left (<).
class DirectionalChevron extends StatelessWidget {
  final double size;
  final Color color;

  const DirectionalChevron({
    super.key,
    this.size = 14,
    this.color = AppColors.textMutedDark,
  });

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Icon(
      isRtl ? Icons.arrow_back_ios_new_rounded : Icons.arrow_forward_ios_rounded,
      size: size,
      color: color,
    );
  }
}
