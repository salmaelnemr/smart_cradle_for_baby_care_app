import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/BabyInfo/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Login/view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text_field.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 68.h,
              ),
              const AppText(
                title: "logo",
                fontSize: 36,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
              SizedBox(
                height: 71.h,
              ),
              const AppText(
                title: "Create account",
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                fontSize: 32,
                color: AppColors.black,
              ),
              SizedBox(
                height: 40.86.h,
              ),
              const AppTextField(
                hint: 'Full Name',
                prefixIcon: 'Assets/Images/personIcon.png',
              ),
              SizedBox(
                height: 16.28.h,
              ),
              const AppTextField(
                hint: 'Email',
                prefixIcon: 'Assets/Images/emailIcon.png',
              ),
              SizedBox(
                height: 16.28.h,
              ),
              const AppTextField(
                hint: 'Phone number',
                prefixIcon: 'Assets/Images/phoneIcon.png',
              ),
              SizedBox(
                height: 16.28.h,
              ),
              const AppTextField(
                hint: 'Password',
                prefixIcon: 'Assets/Images/passIcon.png',
                suffixIcon: Icons.visibility,
              ),
              SizedBox(
                height: 16.28.h,
              ),
              const AppTextField(
                hint: 'Confirm password',
                prefixIcon: 'Assets/Images/passIcon.png',
                suffixIcon: Icons.visibility,
              ),
              SizedBox(
                height: 67.14.h,
              ),
              AppButton(
                width: 317.w,
                height: 50.86.h,
                title: "Sign up",
                onPressed: (){
                  RouteUtils.push(
                    const BabyInformationView(),
                  );
                },
              ),
              SizedBox(
                height: 16.14.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppText(
                    title: "Already have an account?",
                    fontFamily: "Roboto",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyLight,
                  ),
                  TextButton(
                    onPressed: () {
                      RouteUtils.push(
                        const LoginView(),
                      );
                    },
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: AppColors.primaryG,
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ).createShader(bounds),
                      child: const AppText(
                        title: "Login",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
