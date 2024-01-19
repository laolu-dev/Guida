import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guida/constants/color.dart';
import 'package:guida/src/widgets/loading_widget.dart';

class Helpers {
  static void navigateTo(BuildContext context, String destination) {
    Navigator.of(context).pushNamed(destination);
  }

  static void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void dropKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void showGuidaModal(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isDismissible: false,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: GuidaColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: MediaQuery.of(context).viewInsets,
            child: child);
      },
    );
  }

  static void showGuidaLoadingModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (context) => const Align(
        alignment: Alignment.center,
        child: Loading(),
      ),
    );
  }

  static void showInAppAlertInfo(BuildContext context, String dsc) {
    CherryToast.info(
      title: Text(
        "Info",
        style: TextStyle(color: GuidaColors.black, fontWeight: FontWeight.bold),
      ),
      description: Text(
        dsc,
        style: TextStyle(color: GuidaColors.black),
      ),
      toastDuration: const Duration(milliseconds: 2000),
      animationDuration: const Duration(milliseconds: 500),
    ).show(context);
  }

  static void showInAppAlertSuccess(BuildContext context, String dsc) {
    CherryToast.success(
      title: Text(
        "Success",
        style: TextStyle(color: GuidaColors.black),
      ),
      description: Text(
        dsc,
        style: TextStyle(color: GuidaColors.black),
      ),
      toastDuration: const Duration(milliseconds: 1800),
      animationDuration: const Duration(milliseconds: 400),
    ).show(context);
  }

  static void showInAppAlertError(BuildContext context, String dsc) {
    CherryToast.error(
      title: Text(
        "Error",
        style: TextStyle(color: GuidaColors.black),
      ),
      description: Text(
        dsc,
        style: TextStyle(color: GuidaColors.black),
      ),
      toastDuration: const Duration(milliseconds: 1800),
      animationDuration: const Duration(milliseconds: 400),
    ).show(context);
  }
}