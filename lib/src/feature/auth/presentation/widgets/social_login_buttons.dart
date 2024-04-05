import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/feature/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:go_router/go_router.dart';

class SocialAuthenticationButtons extends StatelessWidget {
  final Widget? widget;
  const SocialAuthenticationButtons({
    super.key,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
        TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Divider(
                thickness: 1,
                color: ColorAssets.lightGray,
              )),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  "or Sign in with",
                  style: textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                     ),
                ),
              ),
              Expanded(
                  child: Divider(
                thickness: 1,
                color: ColorAssets.lightGray,
              )),
            ],
          ),

          // social buttons
          const SizedBox(height: 30),

          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    ImageAssets.google,
                    width: 40,
                    height: 40,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    ImageAssets.facebook,
                    width: 40,
                    height: 40,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    ImageAssets.apple,
                    width: 40,
                    height: 40,
                  )),
            ],
          ),
          if (widget != null)
            Column(
              children: [
                const SizedBox(height: 50),
                widget!,
              ],
            )
        ],
      ),
    );
  }
}
