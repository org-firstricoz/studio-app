import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_svg/svg.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(45.0),
      child: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                ImageAssets.page2,
                height: 200,
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
                      text: "Arrange Tours",
                      children: [
                        TextSpan(
                            text: " to View\nStudio",
                            style: textTheme.titleLarge!
                                .copyWith(color: color.primary, fontSize: 16)),
                      ],
                      style: textTheme.titleLarge!.copyWith(fontSize: 16)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // description
                // Text(
                //   "Keep track of your booking , stay, organized, & never miss a creative opportunity.",
                //   style: textTheme.titleMedium!.copyWith(
                //       color: color.tertiary,

                //       fontSize: 18,
                //       fontWeight: FontWeight.w600
                //       ),)
              ],
            ),
          )),
        ],
      ),
    );
  }
}
