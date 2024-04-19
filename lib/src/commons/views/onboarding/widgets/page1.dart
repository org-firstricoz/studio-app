import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
      child: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                ImageAssets.page1,
                height: 150,
              ),
            ],
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Using\nThe Map",
                            style: textTheme.titleLarge!
                                .copyWith(color: color.primary, fontSize: 16)),
                      ],
                      text: "Discover Studios ",
                      style: textTheme.titleLarge!.copyWith(fontSize: 16)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // description
                // Text(
                //   "Browse through a variety of studio categories tailored to your creative needs.",
                //   style: textTheme.titleMedium!.copyWith(
                //       color: color.tertiary,
                //       fontSize: 18,
                //       fontWeight: FontWeight.w600),
                // )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
