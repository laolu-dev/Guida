import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import '../../../constants/color.dart';
import '../../../constants/route_names.dart';
import '../../../constants/validators.dart';
import '../../../services/geolocator.dart';
import '../../../util/helpers.dart';
import '../../controllers/providers.dart';
import '../../widgets/button.dart';
import '../../widgets/container.dart';
import '../../widgets/form.dart';
import '../../widgets/textfield.dart';
import '../../widgets/view_widget.dart';
import 'forgot_password.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final GlobalKey<FormState> _formKey;
  late final TapGestureRecognizer _createAccount;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _createAccount = TapGestureRecognizer();
    _createAccount.onTap = () {
      Helpers.navigateTo(ref, GuidaRouteString.signup);
    };
    GeolocatorService.instance.init();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _formKey.currentState?.dispose();
    Helpers.dropKeyboard();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(loginController);
    ref.listen(
      loginController,
      (_, state) {
        state.when(
          data: (user) async {
            Helpers.navigateBack(ref);
            Helpers.showInAppAlertSuccess(
                context, "Successfully logged in ${user?.displayName ?? ""}");
            Helpers.navigateTo(ref, GuidaRouteString.faculties);
          },
          error: (error, trace) {
            Helpers.navigateBack(ref);
            Helpers.showInAppAlertError(context, "$error");
          },
          loading: () => Helpers.showGuidaLoadingModal(context),
        );
      },
    );

    return ViewWidget(
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
                formKey: _formKey,
                formFields: [
                  GuidaTextField(
                    hint: "Email",
                    controller: _email,
                    validator: (password) =>
                        GuidaValidators.emailValidator(password),
                    fieldIcon: Ionicons.person_circle_outline,
                    padding: 16.h,
                  ),
                  GuidaTextField(
                    hint: "Password",
                    controller: _password,
                    validator: (password) =>
                        GuidaValidators.passwordValidator(password),
                    fieldIcon: Ionicons.lock_closed_outline,
                    requiresPassword: true,
                    padding: 8.h,
                  ),
                  const ForgotPasswordView(),
                  const RSizedBox(height: 16),
                  GuidaButton(
                    name: 'Login',
                    action: authState.isLoading ? null : () => loginUser(),
                  ),
                  SizedBox(height: 12.h),
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: GuidaColors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Create an account",
                          recognizer: _createAccount,
                          style: TextStyle(
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
              top: .08.sh,
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
                    style: TextStyle(
                      fontSize: 38.sp,
                      color: GuidaColors.red,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "YOUR UNI GUIDE",
                    style: TextStyle(
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

  void loginUser() {
    Map<String, dynamic> payload = {
      "email": _email.text,
      "password": _password.text,
    };

    if (_formKey.currentState!.validate()) {
      Helpers.dropKeyboard();
      ref.read(loginController.notifier).login(payload);
    }
  }
}
