import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guida/constants/color.dart';

class GuidaForm extends StatelessWidget {
  final Key? formKey;
  final Color? formColor;
  final List<Widget> formFields;

  const GuidaForm({
    super.key,
    required this.formFields,
    this.formKey,
    this.formColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .88.sw,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 45),
      decoration: BoxDecoration(
        color: formColor ?? GuidaColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: formFields),
      ),
    );
  }
}
