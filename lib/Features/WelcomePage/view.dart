import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Login/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/SignUp/view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_button.dart';

class WelcomePageView extends StatelessWidget {
  const WelcomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pinkLight,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 182.h,),
            Image.asset(
              'Assets/Images/logo.png',
              height: 260.h,
              width: 260.w,
            ),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: AppColors.primaryG,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ).createShader(bounds),
              child: AppText(
                title: "Welcome to the app",
                fontFamily: "Roboto",
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 56.h,),
            AppButton(
              width: 317.w,
              height: 50.86.h,
              title: "Sign Up",
              onPressed: (){
                RouteUtils.push(
                  const SignUpView(),
                );
              },
            ),
            SizedBox(height: 24.14.h,),
            AppButton(
              width: 317.w,
              height: 50.86.h,
              title: "Login",
              onPressed: (){
                RouteUtils.push(
                  const LoginView(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
