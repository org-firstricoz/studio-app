import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/feature/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';

class DeleteAccountAlertModel extends StatefulWidget {
  const DeleteAccountAlertModel({super.key});

  @override
  State<DeleteAccountAlertModel> createState() =>
      _DeleteAccountAlertModelState();
}

class _DeleteAccountAlertModelState extends State<DeleteAccountAlertModel> {
  bool agreeTerms = false;
  bool agreeDataDeletion = false;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return AlertDialog(
      backgroundColor: color.surface,
      surfaceTintColor: color.onSecondary,
      title: const Text("Confirm Account Deletion"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Please confirm that you want to delete your account."),
          const SizedBox(height: 16),
          CheckboxListTile(
            activeColor: ColorAssets.primaryBlue,
            checkColor: ColorAssets.white,
            title: const Text("I agree to the Terms and Conditions"),
            value: agreeTerms,
            onChanged: (value) {
              if (value != null) {
                agreeTerms = value;
                setState(() {});
              }
            },
          ),
          CheckboxListTile(
            activeColor: ColorAssets.primaryBlue,
            checkColor: ColorAssets.white,
            title: const Text("I understand that this action is irreversible"),
            value: agreeDataDeletion,
            onChanged: (value) {
              if (value != null) {
                agreeDataDeletion = value;
                setState(() {});
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Cancel",
            style: TextStyle(color: ColorAssets.primaryBlue),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            // overlayColor: MaterialStateProperty.resolveWith<Color?>(
            //   (Set<MaterialState> states) {
            //     if (states.contains(MaterialState.pressed)) {

            //       return ColorAssets.activeOverlayColor;
            //     }
            //     // The button is not pressed
            //     return ColorAssets.inactiveOverlayColor;
            //   },
            // ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  // The button is disabled
                  return ColorAssets.lightGray.withOpacity(0.2);
                }
                // The button is enabled
                return ColorAssets.primaryBlue;
              },
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  // The button is disabled
                  return ColorAssets.blackFaded.withOpacity(0.5);
                }
                // The button is enabled
                return ColorAssets.white;
              },
            ),
          ),
          onPressed: (agreeTerms && agreeDataDeletion)
              ? () {
                  context.read<SettingsBloc>().add(DeleteAccountEvent(noParams: NoParams()));
                }
              : null,
          child: const Text("Delete Account"),
        ),
      ],
    );
  }
}
