import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/logo.dart';
import '../widgets/view_widget.dart';

class DirectionsView extends ConsumerStatefulWidget {
  final List<String> directions;
  const DirectionsView({super.key, required this.directions});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DirectionsViewState();
}

class _DirectionsViewState extends ConsumerState<DirectionsView> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return ViewWidget(
      viewBody: SafeArea(
        child: SingleChildScrollView(
          padding: REdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const BackButton(),
                  const GuidaLogo(),
                  SizedBox(width: 16.h),
                  Text(
                    "Instructions to location",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Stepper(
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep < widget.directions.length - 1) {
                    setState(() => _currentStep += 1);
                  }
                  if (_currentStep == (widget.directions.length - 1)) {}
                },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() => _currentStep -= 1);
                  }
                },
                onStepTapped: (index) {
                  setState(() => _currentStep = index);
                },
                steps: widget.directions.isNotEmpty
                    ? widget.directions.map((direction) {
                        return Step(
                          title: Text(
                            direction,
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                          isActive: widget.directions.indexOf(direction) ==
                              _currentStep,
                          content: const SizedBox(),
                        );
                      }).toList()
                    : [
                        Step(
                          title: Text(
                            "No instruction",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                          isActive: true,
                          content: const SizedBox(),
                        )
                      ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
