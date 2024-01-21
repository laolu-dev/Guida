import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guida/constants/color.dart';
import 'package:guida/src/providers/providers.dart';
import 'package:guida/src/views/password_reset.dart';
import 'package:guida/util/helpers.dart';

class GuidaButton extends StatelessWidget {
  final String name;
  final void Function()? action;

  const GuidaButton({super.key, required this.name, this.action});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: GuidaColors.red,
        disabledBackgroundColor: GuidaColors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        fixedSize: Size(double.maxFinite, .055.sh),
        padding: const EdgeInsets.symmetric(vertical: 4),
      ),
      child: Text(
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

class GuidaMapButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;
  const GuidaMapButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: GuidaColors.red.withAlpha(160),
        child: InkWell(
          splashColor: GuidaColors.redAccent,
          onTap: onTap,
          child: SizedBox(
            width: 50.w,
            height: 50.h,
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}

class ForgotPassword extends ConsumerWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        SizedBox(
          height: 32,
          width: 32,
          child: Checkbox.adaptive(
            value: ref.watch(rememberMeController),
            onChanged: (value) =>
                ref.read(rememberMeController.notifier).changeState(value!),
            activeColor: GuidaColors.blue,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: BorderSide(color: GuidaColors.blue),
          ),
        ),
        Text(
          "Remember me",
          style: GoogleFonts.montserrat(
            fontSize: 12.sp,
            color: GuidaColors.blue,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () =>
              Helpers.showGuidaModal(context, const SendResetLinkView()),
          child: Text(
            "Forgot password",
            style: GoogleFonts.montserrat(
              fontSize: 12.sp,
              color: GuidaColors.blue,
            ),
          ),
        )
      ],
    );
  }
}
