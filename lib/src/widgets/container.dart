import 'package:flutter/material.dart';

class GuidaContainer extends StatelessWidget {
  final Color containerColor;
  final double? containerHeight;
  final double? containerWidth;
  final BorderRadiusGeometry? borderRadiusGeometry;
  const GuidaContainer({
    super.key,
    this.containerHeight,
    this.containerWidth,
    this.borderRadiusGeometry,
    required this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: borderRadiusGeometry ??
            const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
      ),
    );
  }
}

