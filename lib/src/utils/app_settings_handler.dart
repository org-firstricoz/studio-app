import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/utils/snackbar_service.dart';

class AppSettingsHandler {
  static void openNotificationSettings(BuildContext context) async {
    try {
      await AppSettings.openAppSettings(type: AppSettingsType.notification);
    } catch (e) {
      // ignore: use_build_context_synchronously
      SnackBarService.showSnackBar(
          context: context,
          message: "Error while navigating to notification settings");
    }
  }
}
