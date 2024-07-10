import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guida/constants/color.dart';
import 'package:guida/constants/enums.dart';
import 'package:guida/constants/images.dart';

class TransportDialog extends StatefulWidget {
  const TransportDialog({super.key});

  @override
  State<TransportDialog> createState() => _TransportDialogState();
}

class _TransportDialogState extends State<TransportDialog> {
  TransportMode state = TransportMode.walking;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 36, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Choose mode of transport:",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() => state = TransportMode.walking);
                    Future.delayed(Durations.extralong4);
                    Navigator.pop(context, state);
                  },
                  child: AnimatedContainer(
                    duration: Durations.medium4,
                    padding: REdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: switch (state) {
                        TransportMode.walking =>
                          GuidaColors.redAccent.withOpacity(.8),
                        TransportMode.car => Colors.transparent,
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: GuidaColors.black),
                    ),
                    child: Row(
                      children: [
                        Image.asset(Images.walk, width: 28.w),
                        Text(
                          "Walking",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                GestureDetector(
                  onTap: () {
                    setState(() => state = TransportMode.car);
                    Future.delayed(Durations.extralong4);
                    Navigator.pop(context, state);
                  },
                  child: AnimatedContainer(
                    duration: Durations.medium4,
                    padding: REdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: switch (state) {
                        TransportMode.walking => Colors.transparent,
                        TransportMode.car =>
                          GuidaColors.redAccent.withOpacity(.8),
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: GuidaColors.black),
                    ),
                    child: Row(
                      children: [
                        Image.asset(Images.car, width: 28.w),
                        Text(
                          "Driving",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
