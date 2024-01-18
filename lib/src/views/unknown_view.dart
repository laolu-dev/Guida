import 'package:flutter/material.dart';

class UnknownView extends StatelessWidget {
  const UnknownView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "This page does not exist",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
