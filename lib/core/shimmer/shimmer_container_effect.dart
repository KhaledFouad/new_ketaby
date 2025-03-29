import 'package:flutter/material.dart';
import 'package:new_ketaby/core/utils/app_colors.dart' show AppColors;
import 'package:shimmer/shimmer.dart';

class ShimmerContainerEffect extends StatelessWidget {
  const ShimmerContainerEffect({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.margin,
  });

  final double? width;
  final double? height;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColors.grey50.withOpacity(0.3),
      highlightColor: highlightColor ?? AppColors.white.withOpacity(0.6),
      child: Container(
        margin: margin,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
      ),
    );
  }
}
