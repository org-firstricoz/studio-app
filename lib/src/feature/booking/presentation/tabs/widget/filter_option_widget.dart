import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';

class FilterOptionsWidget extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;
  final Color backgroundColor;
  final Color textColor;

  const FilterOptionsWidget({
    Key? key,
    required this.label,
    required this.onTap,
    required this.isSelected,
    this.backgroundColor = ColorAssets.lightBlueGray,
    this.textColor = ColorAssets.blackFaded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 17, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color.primary : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isSelected ? Icon(Icons.tune, color: color.onPrimary) : Container(),
            isSelected ? const SizedBox(width: 8) : Container(),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color.onPrimary : null,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
