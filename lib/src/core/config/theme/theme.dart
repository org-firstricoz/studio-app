import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';

class Themes {
  static lightTheme(BuildContext context) => ThemeData(
      scaffoldBackgroundColor: ColorAssets.white,
      textTheme: TextTheme(
        titleSmall: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: ColorAssets.lightGray),
        titleMedium: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: ColorAssets.lightGray),
        titleLarge: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: ColorAssets.blackFaded),

        // medium
        bodySmall: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: ColorAssets.lightGray),
        bodyMedium: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: ColorAssets.lightGray),
        bodyLarge: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: ColorAssets.blackFaded),
      ),
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: ColorAssets.primaryBlue,
          onPrimary: ColorAssets.lightBlueGray,
          secondary: ColorAssets.blackFaded,
          onSecondary: ColorAssets.blackFaded,
          error: ColorAssets.redAccent,
          onError: ColorAssets.redAccent,
          surface: ColorAssets.white,
          onSurface: ColorAssets.blackFaded));

  static darkTheme(BuildContext context) => ThemeData(
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: ColorAssets.primaryBlue,
          onPrimary: ColorAssets.lightBlueGray,
          secondary: ColorAssets.blackFaded,
          onSecondary: ColorAssets.lightGray,
          error: ColorAssets.redAccent,
          onError: ColorAssets.lightBlueGray,
          surface: ColorAssets.blackFaded,
          onSurface: ColorAssets.white),
      textTheme: TextTheme(
        titleSmall: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: ColorAssets.lightGray),
        titleMedium: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: ColorAssets.lightGray),
        titleLarge: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: ColorAssets.white),

        // medium
        bodySmall: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: ColorAssets.lightGray),
        bodyMedium: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: ColorAssets.lightGray),
        bodyLarge: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: ColorAssets.lightGray),
      ),
      scaffoldBackgroundColor: ColorAssets.blackFaded);
}

class ColorAssets {
  static Color primaryBlue = const Color.fromRGBO(36, 107, 253, 1);
  static Color black = const Color.fromARGB(255, 0, 0, 0);

  static Color blackFaded = const Color.fromARGB(255, 52, 52, 52);

  static Color transparent = const Color.fromARGB(0, 52, 52, 52);

  static Color lightGray = const Color.fromRGBO(147, 147, 147, 1);
  static Color white = const Color.fromRGBO(255, 255, 255, 1);
  static Color redAccent = const Color.fromRGBO(255, 107, 107, 1);
  static Color lightBlueGray = const Color.fromRGBO(244, 246, 249, 1);
  static Color yellow = Colors.yellow;
}
