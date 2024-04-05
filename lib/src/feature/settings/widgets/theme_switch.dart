 

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/custom_list_tile.dart'; 
import 'package:flutter_riverpod_base/src/feature/settings/provider/theme_provider.dart';
import 'package:flutter_riverpod_base/src/feature/settings/widgets/theme_selecting_widget.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';

class ThemeSwitchingWidget extends ConsumerWidget {
  const ThemeSwitchingWidget({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(themeProvider);

    return CustomListTile(
      leadingIcon: Icon(
        themeModeState == ThemeMode.system
            ? Icons.device_unknown
            : themeModeState == ThemeMode.light
                ? Icons.light_mode_rounded
                : Icons.light_mode,
        color: ColorAssets.primaryBlue,
      ),
      title: const Text(
        "Change Theme",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          // color: ColorAssets.blackFaded,
        ),
      ),
      subtitle: Text(
        themeModeState == ThemeMode.system
            ? "System Default"
            : themeModeState == ThemeMode.light
                ? "Light Mode"
                : "Dark Mode ",
      ),
      tailingIcon: Icon(Icons.chevron_right_rounded, color: ColorAssets.primaryBlue),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Builder(
              builder: (context) => ThemeSelectorSheet(),
            );
          },
        );
      },
    );
  }
}
