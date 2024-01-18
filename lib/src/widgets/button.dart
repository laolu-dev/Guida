import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guida/constants/color.dart';
import 'package:guida/src/widgets/loading_widget.dart';

class GuidaButton extends StatelessWidget {
  final String name;
  final bool isLoading;
  final void Function()? action;

  const GuidaButton({
    super.key,
    required this.name,
    required this.isLoading,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: GuidaColors.grey,
        disabledBackgroundColor: GuidaColors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        fixedSize: Size(.71.sw, .05.sh),
        padding: const EdgeInsets.symmetric(vertical: 4),
      ),
      child: isLoading
          ? const Loading()
          : Text(
              name,
              style: GoogleFonts.montserrat(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: GuidaColors.white,
              ),
            ),
    );
  }
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox.adaptive(value: true, onChanged: (value) {}),
        Text(""),
        Spacer(),
        Text("")
      ],
    );
  }
}
