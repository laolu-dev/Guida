import 'package:flutter/material.dart';

class ViewWiget extends StatelessWidget {
  final Widget? viewBody;
  final Color? backgroundColor;
  const ViewWiget({super.key, this.viewBody, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: viewBody,
    );
  }
}
