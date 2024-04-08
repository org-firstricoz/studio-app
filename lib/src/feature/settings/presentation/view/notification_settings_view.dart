import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/custom_list_tile.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/simple_app_bar.dart';
import 'package:flutter_riverpod_base/src/utils/app_settings_handler.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';
import 'package:flutter_riverpod_base/src/utils/studio_app_bar.dart';

class NotificationSettingsView extends StatefulWidget {
  static String routePath = '/notification-settings-view';

  const NotificationSettingsView({Key? key}) : super(key: key);

  @override
  State<NotificationSettingsView> createState() =>
      _NotificationSettingsViewState();
}

class _NotificationSettingsViewState extends State<NotificationSettingsView> {
  bool useCustomNotifications = true;
  bool useHighPriorityNotifications = true;

  String selectedNotificationTone = "Default (waterDrop_preview.ogg)";

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Notification",
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomListTile(
              title: const Text("Use custom notifications"),
              onTap: () {
                setState(() {
                  useCustomNotifications = !useCustomNotifications;
                });
              },
              tailingIcon: Checkbox(
                value: useCustomNotifications,
                onChanged: (value) {
                  setState(() {
                    useCustomNotifications = value ?? false;
                  });
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Message notifications",
              ),
            ),
            CustomListTile(
              title: const Text("Notification tone"),
              subtitle: Text(selectedNotificationTone),
              onTap: () {
                _showNotificationToneBottomSheet(context);
              },
            ),
            CustomListTile(
              title: const Text("Vibrate"),
              subtitle: Text(vibrateMode),
              onTap: () {
                _showVibrateModeDialog(context);
              },
            ),
            CustomListTile(
              title: const Text("Use high priority notifications"),
              subtitle: const Text(
                "Show preview of notifications at the top of the screen",
              ),
              onTap: () {
                setState(() {
                  useHighPriorityNotifications = !useHighPriorityNotifications;
                });
              },
              tailingIcon: Checkbox(
                value: useHighPriorityNotifications,
                onChanged: (value) {
                  setState(() {
                    useHighPriorityNotifications = value ?? false;
                  });
                },
              ),
            ),
            CustomListTile(
              leadingIcon: const Icon(Icons.settings_applications),
              title: const Text("Open App Notification Settings"),
              onTap: () {
                AppSettingsHandler.openNotificationSettings(context);
              },
            ),
          ],
        ).addSpacingBetweenElements(15),
      ),
    );
  }

  void _showVibrateModeDialog(BuildContext context) {
    String selectedVibrateMode = vibrateMode;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Vibrate Mode"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: const Text("Vibrate"),
                value: "Vibrate",
                groupValue: selectedVibrateMode,
                onChanged: (String? value) {
                  _setVibrateMode(value);
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: const Text("Silent"),
                value: "Silent",
                groupValue: selectedVibrateMode,
                onChanged: (String? value) {
                  _setVibrateMode(value);
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: const Text("Normal"),
                value: "Normal",
                groupValue: selectedVibrateMode,
                onChanged: (String? value) {
                  _setVibrateMode(value);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String vibrateMode = "Vibrate";

  void _setVibrateMode(String? mode) {
    if (mode != null) {
      vibrateMode = mode;
      setState(() {});
    }
  }

  void _showNotificationToneBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 16.0),
              ListTile(
                title: const Text("Default (waterDrop_preview.ogg)"),
                onTap: () {
                  _selectNotificationTone("Default (waterDrop_preview.ogg)");
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                title: const Text("Sound 1"),
                onTap: () {
                  _selectNotificationTone("Sound 1");
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                title: const Text("Sound 2"),
                onTap: () {
                  _selectNotificationTone("Sound 2");
                  Navigator.pop(context);
                },
              ),
              // Add more options as needed
            ],
          ),
        );
      },
    );
  }

  void _selectNotificationTone(String tone) {
    setState(() {
      selectedNotificationTone = tone;
    });
  }
}
