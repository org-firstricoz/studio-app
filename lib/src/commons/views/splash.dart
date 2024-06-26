import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/main.dart';
import 'package:flutter_riverpod_base/src/app.dart';
import 'package:flutter_riverpod_base/src/commons/views/onboarding/on_boarding_page.dart';
import 'package:flutter_riverpod_base/src/core/models/user_model.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/view/home.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:rive/rive.dart';
import 'package:upgrader/upgrader.dart';

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
      _cachedUser();
    });
  }

  _cachedUser() {
    final box = Hive.box('USER');
    if (box.isNotEmpty) {
      final token = box.get('token');
      if (token != null) {
        final bool val = Jwt.isExpired(token);

        if (val) {
          context.go(OnBoardingPage.routePath);
        } else {
          final userDetails = Jwt.parseJwt(token);
          user = User.fromMap(userDetails);

          context.go(HomeView.routePath);
        }
      } else {
        context.go(OnBoardingPage.routePath);
      }
    } else {
      context.go(OnBoardingPage.routePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorAssets.white,
        body: const RiveAnimation.asset(
          AnimationAssets.splashAnimation,
          fit: BoxFit.cover,
          animations: [],
        ));
  }
}
