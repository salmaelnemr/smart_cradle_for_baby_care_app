import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text.dart';
import '../Login/view.dart';

class SignUpSuccessfully extends StatefulWidget {
  const SignUpSuccessfully({super.key});

  @override
  State<SignUpSuccessfully> createState() => _SignUpSuccessfullyState();
}

class _SignUpSuccessfullyState extends State<SignUpSuccessfully> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pinkLight,
      body: Padding(
        padding: EdgeInsets.only(
          top: 74.h,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'Assets/Images/congratulations1.png',
                height: 376.75.h,
                width: 391.w,
              ),
              SizedBox(
                height: 33.25.h,
              ),
              const AppText(
                title: "Congratulations",
                fontSize: 24,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 9.h,
              ),
              const AppText(
                title: "You have signed in successfully",
                fontSize: 18,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.h,
              ),
              AppButton(
                width: 317.w,
                height: 50.86.h,
                title: "Login",
                onPressed: () {
                  RouteUtils.push(
                    const LoginView(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
