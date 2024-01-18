import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guida/constants/color.dart';

class GuidaForm extends StatelessWidget {
  final List<Widget> formFields;
  const GuidaForm({super.key, required this.formFields});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: .40.sh,
      width: .87.sw,
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: GuidaColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Column(children: formFields),
    );
  }
}
