import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/commons/views/onboarding/on_boarding_page.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/view/home.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  static const routePath = "/splash";

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      // context.go(HomeView.routePath);
      context.go(OnBoardingPage.routePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        backgroundColor: ColorAssets.white,
        body: const RiveAnimation.asset(
          AnimationAssets.splashAnimation,
          fit: BoxFit.cover,
      animations: [],

        ));
  }
}
