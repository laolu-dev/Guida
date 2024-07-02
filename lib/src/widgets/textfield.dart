import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color.dart';
import 'package:ionicons/ionicons.dart';

class GuidaTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool requiresPassword;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final IconData? fieldIcon;
  final double? padding;

  const GuidaTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.requiresPassword = false,
    this.fillColor,
    this.validator,
    this.padding,
    this.fieldIcon,
  });

  @override
  State<StatefulWidget> createState() => _GuidaTextFieldState();
}

class _GuidaTextFieldState extends State<GuidaTextField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            obscureText: widget.requiresPassword ? _obscureText : false,
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.fillColor ?? GuidaColors.textFieldColor,
              errorStyle: TextStyle(
                fontSize: 10.sp,
                color: GuidaColors.red,
              ),
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontSize: 20.sp,
                color: GuidaColors.black.withOpacity(.5),
              ),
              prefixIcon: widget.fieldIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 12, right: 4),
                      child: Icon(
                        widget.fieldIcon,
                        size: 34,
                        color: GuidaColors.white,
                      ),
                    )
                  : const SizedBox(),
              suffixIcon: widget.requiresPassword
                  ? GestureDetector(
                      onTap: () => setState(() => _obscureText = !_obscureText),
                      child: _obscureText
                          ? Icon(
                              Ionicons.eye_off,
                              size: 24,
                              color: GuidaColors.black.withOpacity(.2),
                            )
                          : Icon(
                              Ionicons.eye,
                              size: 24,
                              color: GuidaColors.black.withOpacity(.2),
                            ),
                    )
                  : null,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ),
        SizedBox(height: widget.padding)
      ],
    );
  }
}

class MapTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final void Function()? onTap;

  const MapTextField({
    super.key,
    this.onTap,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 14.h,
          width: 14.h,
          decoration:
              BoxDecoration(color: GuidaColors.red, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: TextField(
            controller: controller,
            style: TextStyle(
              fontSize: 16.sp,
              color: GuidaColors.black.withOpacity(.5),
            ),
            onTap: onTap,
            decoration: InputDecoration(
              filled: true,
              fillColor: GuidaColors.white,
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 20.sp,
                color: GuidaColors.black.withOpacity(.5),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: GuidaColors.blue, width: 2),
                borderRadius: BorderRadius.circular(999),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        )
      ],
    );
  }
}
