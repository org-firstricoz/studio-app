import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leadingIcon;
  final Widget title;
  final Widget? subtitle;
  final Widget? tailingIcon;
  final VoidCallback? onTap;
  final bool enableBottom;
  final bool error;
  const CustomListTile({
    Key? key,
    this.leadingIcon,
    required this.title,
    this.tailingIcon,
    required this.onTap,
    this.subtitle,
    this.error = false,
    this.enableBottom = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            border: enableBottom
                ? Border(
                    bottom: BorderSide(
                        color: ColorAssets.lightGray.withOpacity(0.3),
                        width: 0.5))
                : null),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 5),
          leading: leadingIcon,
          title: title,
          titleTextStyle: textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: error ? colorScheme.error : null
              // color: ColorAssets.blackFaded,
              ),
          subtitleTextStyle: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: error ? colorScheme.error : null

              // color: ColorAssets.blackFaded,
              ),
          subtitle: subtitle,
          trailing: tailingIcon,
        )).onTap(onTap);
  }
}
