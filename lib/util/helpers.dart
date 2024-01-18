import 'package:flutter/material.dart';

class Helpers {
  static void navigateTo(BuildContext context, String destination) {
    Navigator.of(context).pushNamed(destination);
  }

  static void dropKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
