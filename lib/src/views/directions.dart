import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guida/constants/color.dart';
import 'package:guida/util/helpers.dart';

import '../models/location/location_model.dart';
import '../widgets/view_widget.dart';

class DirectionsView extends ConsumerStatefulWidget {
  final LocationModel location;
  const DirectionsView({super.key, required this.location});

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
                  Expanded(
                    child: Text(
                      "Directions",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: REdgeInsets.symmetric(vertical: 20, horizontal: 12),
                child: Text(
                  widget.location.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Stepper(
                currentStep: _currentStep,
                physics: const ClampingScrollPhysics(),
                onStepContinue: _currentStep ==
                        (widget.location.steps.length - 1)
                    ? null
                    : () async {
                        if (_currentStep < (widget.location.steps.length - 1)) {
                          setState(() => _currentStep += 1);
                          debugPrint(widget.location.steps.toString());
                        }
                        if (_currentStep ==
                            (widget.location.steps.length - 1)) {
                          await Future.delayed(Durations.extralong2);
                          _congratsMessage();
                        }
                      },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() => _currentStep -= 1);
                  }
                },
                onStepTapped: (index) => setState(() => _currentStep = index),
                steps: widget.location.directions.isNotEmpty
                    ? widget.location.steps.map((direction) {
                        return Step(
                          title: Row(
                            children: [
                              Padding(
                                padding: REdgeInsets.symmetric(horizontal: 4),
                                child: Icon(Helpers.getDirectionIcon(direction),
                                    size: 32),
                              ),
                              Expanded(
                                child: Text(
                                  direction,
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                            ],
                          ),
                          isActive: _currentStep ==
                              widget.location.steps.indexOf(direction),
                          content:
                              _currentStep == (widget.location.steps.length - 1)
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Image.network(
                                        Helpers.modifyGoogleDriveLink(
                                            widget.location.image),
                                        fit: BoxFit.fill,
                                        width: 1.sw,
                                        height: .3.sh,
                                      ),
                                    )
                                  : const SizedBox(),
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

  void _congratsMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 64,
                color: GuidaColors.red,
              ),
              SizedBox(height: 12.h),
              Text(
                "You have arrived at your location",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          contentPadding: REdgeInsets.symmetric(vertical: 12, horizontal: 24),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Back",
                style: TextStyle(fontSize: 16.sp),
              ),
            )
          ],
        );
      },
    );
  }
}
