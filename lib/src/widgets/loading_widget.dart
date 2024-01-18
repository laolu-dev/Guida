import 'package:flutter/material.dart';
import 'package:guida/constants/color.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loading extends StatelessWidget {
  final double? size;
  const Loading({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      indicatorType: Indicator.ballBeat,
      colors: [
        GuidaColors.red,
        GuidaColors.black,
        GuidaColors.blue,
      ],
    );
  }
}
