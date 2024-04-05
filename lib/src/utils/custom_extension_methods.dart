import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';

extension ColumnWithSpacing on Column {
  Column addSpacingBetweenElements(double height) {
    List<Widget> spacedChildren = [];
    for (var child in children) {
      spacedChildren.add(child);
      spacedChildren.add(SizedBox(height: height));
    }
    return Column(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: spacedChildren,
    );
  }
}

extension PoweredText on Text {
  Widget onTap(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }
}

extension BoldSubString on Text {
  Text boldSubString(String target, BuildContext context, bool isMe) {
    final color = Theme.of(context).colorScheme;

    final textSpans = List.empty(growable: true);
    final escapedTarget = RegExp.escape(target);
    final pattern = RegExp(escapedTarget, caseSensitive: false);
    final matches = pattern.allMatches(data!);

    int currentIndex = 0;
    for (final match in matches) {
      final beforeMatch = data!.substring(currentIndex, match.start);
      if (beforeMatch.isNotEmpty) {
        textSpans.add(TextSpan(text: beforeMatch));
      }

      final matchedText = data!.substring(match.start, match.end);
      textSpans.add(
        TextSpan(
          text: matchedText,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              fontSize: 16),
        ),
      ); 
      currentIndex = match.end;
    }

    if (currentIndex < data!.length) {
      final remainingText = data!.substring(currentIndex);
      textSpans.add(TextSpan(text: remainingText));
    } 
    return Text.rich(
      TextSpan(
          style: TextStyle(
            color: isMe ? color.onPrimary : color.onBackground,
            fontSize: 14,
          ),
          children: <TextSpan>[...textSpans]),
    );
  }
}

extension CustomContainer on Container {
  Widget onTap(VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }
}

extension CustomRow on Row {
  Widget onTap(VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }
}
