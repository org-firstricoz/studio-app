import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';

class CustomTagBuilder extends StatelessWidget {
  const CustomTagBuilder(
      {super.key, this.tag, this.widget, this.onTap, this.isActive});

  final String? tag;
  final Widget? widget;
  final VoidCallback? onTap;
  final bool? isActive;
  @override
  Widget build(BuildContext context) {
        final color = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color:  color.secondary,
            borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: tag == null
            ? widget
            : Text(
                tag ?? "null tag",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: color.primary),
              ),
      ),
    );
  }
}
