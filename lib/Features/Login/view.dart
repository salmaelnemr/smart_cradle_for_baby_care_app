import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/BottomNavBar/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Forgot%20Password/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/SignUp/view.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text.dart';
import '../../Widgets/app_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pinkLight,
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 43.h,
              ),
              Image.asset(
                'Assets/Images/logo.png',
                height: 146.h,
                width: 146.w,
              ),
              SizedBox(
                height: 4.h,
              ),
              const AppText(
                title: "Welcome back",
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                fontSize: 32,
                color: AppColors.black,
              ),
              SizedBox(
                height: 40.h,
              ),
              const AppTextField(
                hint: 'Email / phone number',
                prefixIcon: 'Assets/Images/emailIcon.png',
              ),
              SizedBox(
                height: 16.14.h,
              ),
              const AppTextField(
                hint: 'Password',
                prefixIcon: 'Assets/Images/passIcon.png',
                suffixIcon: Icons.visibility,
                obscureText: true,
              ),
              SizedBox(
                height: 8.14.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 52.w,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        RouteUtils.push(
                          const ForgotPasswordView(),
                        );
                      },
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: AppColors.primaryG,
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ).createShader(bounds),
                        child: const AppText(
                          title: "Forgot password?",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 242.h,
              ),
              AppButton(
                width: 317.w,
                height: 50.86.h,
                title: "Login",
                onPressed: (){
                  RouteUtils.push(
                    const BottomNavBar(),
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
                    title: "Don’t have an account?",
                    fontFamily: "Roboto",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyLight,
                  ),
                  TextButton(
                    onPressed: () {
                      RouteUtils.push(
                        const SignUpView(),
                      );
                    },
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: AppColors.primaryG,
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ).createShader(bounds),
                      child: const AppText(
                        title: "Sign up",
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
