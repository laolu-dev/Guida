import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guida/constants/color.dart';

class GuidaTextField extends ConsumerWidget {
  final TextEditingController controller;
  final String hint;
  final IconData? fieldIcon;
  final double? padding;

  const GuidaTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.padding,
    this.fieldIcon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: GuidaColors.textFieldColor,
            hintText: hint,
            hintStyle: GoogleFonts.montserrat(
              fontSize: 20.sp,
              color: GuidaColors.black.withOpacity(.5),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 12, right: 4),
              child: Icon(
                fieldIcon,
                size: 38,
                color: GuidaColors.white,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        SizedBox(height: padding ?? 22.h)
      ],
    );
  }
}
