import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/commons/views/otp/login_otp.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/simple_app_bar.dart';
import 'package:flutter_riverpod_base/src/feature/auth/presentation/pages/login_page.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';
import 'package:flutter_riverpod_base/src/utils/form_text_field.dart';
import 'package:flutter_riverpod_base/src/utils/snackbar_service.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod_base/src/commons/widgets/custom_list_tile.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/core/models/notification.dart';

class PasswordManagerView extends StatelessWidget {
  static String routePath = '/password-manager-view';

  const PasswordManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: SimpleAppBar(
        title: "Password Manager",
        leadingCallback: () => Navigator.pop(context),
      ),
      body: ListView(
        children: [
          _buildOptions(context),
        ],
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          leadingIcon: SvgPicture.asset(ImageAssets.key),
          title: const Text("Reset Password"),
          onTap: () {
            _showResetPasswordDialog(context);
          },
        ),
        CustomListTile(
          leadingIcon: Icon(
            Icons.copy_all_rounded,
            color: ColorAssets.primaryBlue,
          ),
          title: const Text("Copy Password"),
          onTap: () {
            _copyPasswordToClipboard(context, "password_here");
          },
        ),
        CustomListTile(
          leadingIcon: SvgPicture.asset(ImageAssets.logout),
          title: const Text("Logout of all devices"),
          onTap: () {
            SnackBarService.showSnackBarWithAction(
                context: context,
                message: "Do you want to logout of all devices ?",
                ontap: () {
                  context.push(LoginOtp.routePath);
                });
          },
        ),
      ],
    );
  }

  void _copyPasswordToClipboard(
    BuildContext context,
    String password,
  ) {
    FlutterClipboard.copy(password)
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Password copied to clipboard"),
              ),
            ));
  }

  void _showResetPasswordDialog(BuildContext context) {
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    final color = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          titlePadding:
              EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 15),
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          actionsPadding: EdgeInsets.only(top: 0, right: 15, bottom: 10),
          title: const Text("Reset Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormTextField(
                controller: newPasswordController,
                enableObsecure: true,
                labelText: "New Password",
                hintText: "Enter new password",
              ),
              FormTextField(
                controller: confirmPasswordController,
                enableObsecure: true,
                labelText: "Confirm Password",
                hintText: "Enter cofirm password",
              ),
              // TextField(
              //   controller: newPasswordController,
              //   obscureText: true,
              //   decoration: const InputDecoration(
              //     labelText: "New Password",
              //   ),
              // ),
              // TextField(
              //   controller: confirmPasswordController,
              //   obscureText: true,
              //   decoration: const InputDecoration(
              //     labelText: "Confirm Password",
              //   ),
              // ),
            ],
          ).addSpacingBetweenElements(10),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                String newPassword = newPasswordController.text;
                String confirmPassword = confirmPasswordController.text;

                if (newPassword == confirmPassword && newPassword.isNotEmpty) {
                  Navigator.of(context).pop();
                  SnackBarService.showSnackBar(
                      context: context, message: "Password reset success");
                } else {
                  SnackBarService.showSnackBar(
                      failed: true,
                      context: context,
                      message: "Passwords do not match");
                }
              },
              child: const Text("Reset"),
            ),
          ],
        );
      },
    );
  }
}
