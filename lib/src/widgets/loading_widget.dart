import 'package:flutter/material.dart';
import '../../constants/color.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loading extends StatelessWidget {
  final double? size;
  const Loading({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: 64,
      child: LoadingIndicator(
        indicatorType: Indicator.ballSpinFadeLoader,
        colors: [
          GuidaColors.red,
          GuidaColors.black,
          GuidaColors.blue,
        ],
      ),
    );
  }
}
