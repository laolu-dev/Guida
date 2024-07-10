import 'package:flutter/material.dart';

class ViewWidget extends StatelessWidget {
  final Widget? viewBody;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  
  const ViewWidget({
    super.key,
    this.viewBody,
    this.backgroundColor,
    this.bottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: viewBody,
      bottomSheet: bottomSheet,
    );
  }
}
