


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_base/src/feature/settings/provider/theme_provider.dart'; 
import 'package:flutter_riverpod_base/src/res/colors.dart';

class ThemeSelectorSheet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(themeProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const Text("Light Theme"),
          leading: const Icon(Icons.light_mode_rounded),
          selectedColor: ColorAssets.primaryBlue,
          onTap: () {
            ref.read(themeProvider.notifier).toggleTheme(ThemeMode.light);
            Navigator.pop(context);
          },
          selected: themeModeState == ThemeMode.light,
        ),
        ListTile(
          title: const Text("Dark Theme"),
          leading: const Icon(Icons.dark_mode_rounded),
          selectedColor: ColorAssets.primaryBlue,
          onTap: () {
            ref.read(themeProvider.notifier).toggleTheme(ThemeMode.dark);
            Navigator.pop(context);
          },
          selected: themeModeState == ThemeMode.dark,
        ),
        ListTile(
          title: const Text("System Theme"),
          leading: const Icon(Icons.device_unknown),
          selectedColor: ColorAssets.primaryBlue,
          onTap: () {
            ref.read(themeProvider.notifier).toggleTheme(ThemeMode.system);
            Navigator.pop(context);
          },
          selected: themeModeState == ThemeMode.system,
        ),
      ],
    );
  }
}
