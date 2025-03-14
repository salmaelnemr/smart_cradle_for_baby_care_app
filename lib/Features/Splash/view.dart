import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Onboarding/view.dart';
import '../../Core/route_utils/route_utils.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 4), () {
      RouteUtils.push(
        const OnboardScreen(),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pinkLight,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'Assets/Images/logo.png',
                height: 278.h,
                width: 278.w,
              ),
              //SizedBox(height: 16.h,),
              Image.asset(
                'Assets/Images/IntelliNest.png',
                height: 44.h,
                width: 119.w,
              ),
            ],
          ),
          ),
    );
  }
}
