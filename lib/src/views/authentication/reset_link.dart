import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import '../../../constants/color.dart';
import '../../../constants/validators.dart';
import '../../../util/helpers.dart';
import '../../controllers/providers.dart';
import '../../widgets/button.dart';
import '../../widgets/textfield.dart';

class ResetLinkView extends ConsumerStatefulWidget {
  const ResetLinkView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetLinkViewState();
}

class _ResetLinkViewState extends ConsumerState<ResetLinkView> {
  late final TextEditingController _email;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _email.dispose();
    _formKey.currentState?.dispose();
    Helpers.dropKeyboard();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(resetLinkController);
    ref.listen(resetLinkController, (_, state) {
      state.when(
        data: (user) {
          Helpers.showInAppAlertInfo(context, "Kindly check your mail");
          Helpers.navigateBack(ref);
          Helpers.navigateBack(ref);
        },
        error: (error, trace) {
          Helpers.navigateBack(ref);
          Helpers.showInAppAlertError(context, "$error");
        },
        loading: () => Helpers.showGuidaLoadingModal(context),
      );
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "\t\tSend Reset Link",
              style: TextStyle(
                fontSize: 16.sp,
                color: GuidaColors.black.withOpacity(.7),
              ),
            ),
            SizedBox(height: 8.h),
            GuidaTextField(
              controller: _email,
              hint: "Email",
              validator: (password) => GuidaValidators.emailValidator(password),
              fieldIcon: Ionicons.mail_outline,
            ),
            SizedBox(height: 32.h),
            GuidaButton(
              name: "Send resend Link",
              action: authState.isLoading ? null : () => sendLink(),
            )
          ],
        ),
      ),
    );
  }

  void sendLink() {
    if (_formKey.currentState!.validate()) {
      Helpers.dropKeyboard();
      ref.read(resetLinkController.notifier).sendResetLink(_email.text);
    }
  }
}
