import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guida/constants/color.dart';
import 'package:guida/constants/routes.dart';
import 'package:guida/src/widgets/button.dart';
import 'package:guida/src/widgets/container.dart';
import 'package:guida/src/widgets/form.dart';
import 'package:guida/src/widgets/textfield.dart';
import 'package:guida/src/widgets/view_widget.dart';
import 'package:guida/util/helpers.dart';
import 'package:ionicons/ionicons.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TapGestureRecognizer _createAccount;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _createAccount = TapGestureRecognizer();
    _createAccount.onTap = () {
      Helpers.navigateTo(context, GuidaRouteString.signup);
    };
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    Helpers.dropKeyboard();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewWiget(
      backgroundColor: GuidaColors.grey,
      viewBody: SingleChildScrollView(
        child: Stack(
          children: [
            GuidaContainer(
              containerHeight: 1.sh,
              containerColor: GuidaColors.red,
            ),
            SizedBox(
              height: 1.sh,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GuidaContainer(
                    containerHeight: .67.sh,
                    containerColor: GuidaColors.grey,
                  ),
                  GuidaContainer(
                    containerHeight: .045.sh,
                    containerColor: GuidaColors.grey,
                    borderRadiusGeometry: const BorderRadius.only(
                      topLeft: Radius.elliptical(35, 20),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: .08.sh,
              left: (1.sw - .87.sw) / 2,
              child: GuidaForm(
                formFields: [
                  GuidaTextField(
                    hint: "Email",
                    controller: _email,
                    fieldIcon: Ionicons.person_circle_outline,
                  ),
                  GuidaTextField(
                    hint: "Password",
                    controller: _email,
                    fieldIcon: Ionicons.lock_closed_outline,
                  ),
                  SizedBox(height: 24.h),
                  GuidaButton(
                    name: 'Login',
                    isLoading: true,
                    action: () {},
                  ),
                  SizedBox(height: 24.h),
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        color: GuidaColors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Create an account",
                          recognizer: _createAccount,
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            color: GuidaColors.blue,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: .1.sh,
              left: .18.sw,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/guida_logo.png",
                    color: GuidaColors.grey,
                    colorBlendMode: BlendMode.modulate,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "GUIDA",
                    style: GoogleFonts.montserrat(
                      fontSize: 38.sp,
                      color: GuidaColors.red,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "YOUR UNI GUIDE",
                    style: GoogleFonts.montserrat(
                      fontSize: 28.sp,
                      color: GuidaColors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
