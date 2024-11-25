import 'dart:async';
import 'package:flutter/material.dart';
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
    return const Scaffold(
      backgroundColor: AppColors.pinkLight,
      body: Center(
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Image.asset(
          //       'assets/images/to_do_list.png',
          //       height: 350,
          //       width: 400,
          //     ),
          //     const Text(
          //       "To Do List",
          //       style: TextStyle(
          //         fontSize: 32,
          //         fontWeight: FontWeight.w400,
          //         color: Colors.brown,
          //       ),
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
