import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Core/route_utils/route_utils.dart';
import 'package:smart_cradle_for_baby_care_app/Features/BottomNavBar/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Onboarding/view.dart';
import '../../Core/caching_utils/caching_utils.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double _logoOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimationSequence();
    _checkLoginStatus();
  }

  Future<void> _startAnimationSequence() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _logoOpacity = 1.0;
    });
  }

  Future<void> _checkLoginStatus() async {
    await CachingUtils.init();

    Timer(const Duration(seconds: 4), () {
      if (CachingUtils.isLogged) {
        RouteUtils.pushAndPopAll(const BottomNavBar());
      } else {
        RouteUtils.pushAndPopAll(const OnboardScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pinkLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _logoOpacity,
              duration: const Duration(seconds: 2),
              child: Image.asset(
                'Assets/Images/logo.png',
                height: 278.h,
                width: 278.w,
              ),
            ),
            SizedBox(height: 20.h),
            AnimatedOpacity(
              opacity: _logoOpacity,
              duration: const Duration(seconds: 2),
              child: Image.asset(
                'Assets/Images/IntelliNest.png',
                height: 44.h,
                width: 119.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
