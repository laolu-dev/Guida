import 'package:flutter/material.dart';

class GuidaContainer extends StatelessWidget {
  final Color containerColor;
  final double? containerHeight;
  final double? containerWidth;
  final Widget? child;

  final BorderRadiusGeometry? borderRadiusGeometry;

  const GuidaContainer({
    super.key,
    this.containerHeight,
    this.containerWidth,
    this.borderRadiusGeometry,
    this.child,
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
              bottomLeft: Radius.elliptical(10, 4),
              bottomRight: Radius.circular(25),
            ),
      ),
      child: child,
    );
  }
}
