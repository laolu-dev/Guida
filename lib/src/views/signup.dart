import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guida/constants/color.dart';
import 'package:guida/constants/validators.dart';
import 'package:guida/src/providers/providers.dart';
import 'package:guida/src/widgets/button.dart';
import 'package:guida/src/widgets/container.dart';
import 'package:guida/src/widgets/textfield.dart';
import 'package:guida/src/widgets/view_widget.dart';
import 'package:guida/util/helpers.dart';
import 'package:ionicons/ionicons.dart';

class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _username;
  late final TextEditingController _fullname;
  late final TextEditingController _repeatPassword;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _username = TextEditingController();
    _fullname = TextEditingController();
    _repeatPassword = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    _fullname.dispose();
    _repeatPassword.dispose();
    _formKey.currentState?.dispose();
    Helpers.dropKeyboard();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(createAccountController);
    ref.listen(createAccountController, (_, state) {
      state.when(
        data: (user) {
          Helpers.navigateBack(context);
          Helpers.showInAppAlertSuccess(
              context, "Successfully created an account. Please login");
          Helpers.navigateBack(context);
        },
        error: (error, trace) {
          Helpers.navigateBack(context);
          Helpers.showInAppAlertError(context, "$error");
        },
        loading: () => Helpers.showGuidaLoadingModal(context),
      );
    });
    return ViewWiget(
      backgroundColor: GuidaColors.grey,
      viewBody: SingleChildScrollView(
        child: Column(
          children: [
            GuidaContainer(
              containerColor: GuidaColors.red,
              borderRadiusGeometry: const BorderRadius.only(
                bottomLeft: Radius.elliptical(35, 20),
                bottomRight: Radius.elliptical(35, 20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 24, top: 52),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Helpers.navigateBack(context),
                          splashColor: GuidaColors.redAccent,
                          icon: Icon(Icons.navigate_before,
                              size: 36, color: GuidaColors.white),
                        ),
                        IconButton(
                          onPressed: () {},
                          splashColor: GuidaColors.white,
                          icon: Icon(Ionicons.menu,
                              size: 36, color: GuidaColors.white),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 18, 32, 32),
                    child: Text(
                      "CREATE YOUR ACCOUNT",
                      style: GoogleFonts.montserrat(
                          fontSize: 38.sp,
                          color: GuidaColors.white,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    GuidaTextField(
                      hint: "Email",
                      controller: _email,
                      fillColor: GuidaColors.white,
                      validator: (password) =>
                          GuidaValidators.emailValidator(password),
                      padding: 24.h,
                    ),
                    GuidaTextField(
                      hint: "Fullname",
                      controller: _fullname,
                      fillColor: GuidaColors.white,
                      validator: (fullname) =>
                          GuidaValidators.fullnameValidator(fullname),
                      padding: 24.h,
                    ),
                    GuidaTextField(
                      hint: "Username",
                      controller: _username,
                      fillColor: GuidaColors.white,
                      validator: (username) =>
                          GuidaValidators.usernameValidator(username),
                      padding: 24.h,
                    ),
                    GuidaTextField(
                      hint: "Password",
                      fillColor: GuidaColors.white,
                      controller: _password,
                      validator: (password) =>
                          GuidaValidators.passwordValidator(password),
                      requiresPassword: true,
                      padding: 24.h,
                    ),
                    GuidaTextField(
                      hint: "Repeat Password",
                      fillColor: GuidaColors.white,
                      controller: _repeatPassword,
                      validator: (repeatPassword) =>
                          GuidaValidators.repeatPasswordValidator(
                              repeatPassword, _password.text),
                      requiresPassword: true,
                      padding: 32.h,
                    ),
                    GuidaButton(
                      name: 'Create Account',
                      action:
                          authState.isLoading ? null : () => createAccount(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createAccount() {
    Map<String, dynamic> payload = {
      "email": _email.text,
      "fullname": _fullname.text,
      "username": _username.text,
      "password": _password.text,
    };

    if (_formKey.currentState!.validate()) {
      Helpers.dropKeyboard();
      ref.read(createAccountController.notifier).signup(payload);
    } else if (!_password.text.isValidPassword) {
      Helpers.showInAppAlertInfo(
        context,
        "Password should be at least 8 characters with one lowercase, one uppercase, "
        "a special character and one number",
      );
    }
  }
}
