import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';

class ToastUtils {
  static void showSuccess(BuildContext context, String message) {
    _showToast(context, message, ColorAssets.primaryBlue);
  }

  static void showError(BuildContext context, String message) {
    _showToast(context, message, ColorAssets.redAccent);
  }

  static void showInfo(BuildContext context, String message) {
    _showToast(context, message, ColorAssets.yellow);
  }

  static void _showToast(BuildContext context, String message, Color bgColor) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: bgColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
