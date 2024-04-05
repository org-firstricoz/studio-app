import 'package:flutter/material.dart';

class SnackBarService {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    Duration? duration,
    bool failed =false
  }) {
    // final colorScheme
    ScaffoldMessenger.of(context).showSnackBar(
      
      SnackBar(
        backgroundColor: failed? Colors.redAccent:null,
        content: Text(message),
      ),
    );
  }
   static void showSnackBarWithAction({
    required BuildContext context,
    required String message,
    Duration? duration,
   required VoidCallback ontap,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      
      SnackBar(
        action: SnackBarAction(label: "Confirm", onPressed: ontap),
        content: Text(message),
      ),
    );
  }
}
