import 'package:flutter/material.dart';
import 'package:owl/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    super.key,
    required this.height,
    required this.width,
    this.shapeBorder = const RoundedRectangleBorder(),
  }) : radius = null;

  const ShimmerWidget.circular({super.key, required double size})
      : radius = size,
        height = null,
        width = null,
        shapeBorder = const RoundedRectangleBorder();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDarkMode ? CustomColors.darkGrey : CustomColors.mediumGrey.withOpacity(.5),
      highlightColor: isDarkMode ? CustomColors.mediumGrey : CustomColors.lightGrey,
      child: radius != null
          ? CircleAvatar(radius: radius)
          : Container(
              height: height,
              width: width,
              decoration: ShapeDecoration(
                shape: shapeBorder,
                color: isDarkMode ? CustomColors.darkGrey : CustomColors.mediumGrey,
              ),
            ),
    );
  }
}
