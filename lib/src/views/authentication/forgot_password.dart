import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guida/constants/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/color.dart';
import '../../../util/helpers.dart';
import 'reset_link.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  bool _rememberUser = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _rememberUser = prefs.getBool("isLoggedIn") ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 32,
          width: 32,
          child: Checkbox.adaptive(
            value: _rememberUser,
            onChanged: (value) {
              save(value!);
              setState(() => _rememberUser = value);
            },
            activeColor: GuidaColors.blue,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: BorderSide(color: GuidaColors.blue),
          ),
        ),
        Text(
          "Remember me",
          style: TextStyle(
            fontSize: 12.sp,
            color: GuidaColors.blue,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Helpers.showGuidaModal(context, const ResetLinkView()),
          child: Text(
            "Forgot password",
            style: TextStyle(
              fontSize: 12.sp,
              color: GuidaColors.blue,
            ),
          ),
        )
      ],
    );
  }

  void save(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", value);
    await prefs.setString("initRoute", GuidaRouteString.faculties);
  }
}
