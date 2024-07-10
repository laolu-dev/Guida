import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guida/constants/images.dart';

import '../../constants/color.dart';

class GuidaLogo extends StatelessWidget {
  const GuidaLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: GuidaColors.grey,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: const Offset(2, 3),
            color: GuidaColors.black.withOpacity(.07),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.asset(Images.logo, fit: BoxFit.fill),
      ),
    );
  }
}
