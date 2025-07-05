import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/BottomNavBar/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Forgot%20Password/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/SignUp/view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/snack_bar.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/dio/api_provider.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Core/validator_utils/validator_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text.dart';
import '../../Widgets/app_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pinkLight,
      body: Form(
        key: formKey,
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
              AppText(
                title: "Welcome Back!",
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                fontSize: 32.sp,
                color: AppColors.black,
              ),
              SizedBox(
                height: 40.h,
              ),
              AppTextField(
                hint: 'Email',
                prefixIcon: 'Assets/Images/emailIcon.png',
                controller: emailController,
                validator: ValidatorUtils.email,
              ),
              SizedBox(
                height: 16.14.h,
              ),
              AppTextField(
                hint: 'Password',
                prefixIcon: 'Assets/Images/passIcon.png',
                suffixIcon: Icons.visibility,
                obscureText: true,
                controller: passwordController,
                validator: ValidatorUtils.password,
              ),
              SizedBox(
                height: 8.14.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 52.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
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
                        child: AppText(
                          title: "Forgot Password?",
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
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
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    String result = await ApiProvider().userLogin(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    showSnackBar(
                      result,
                      error: result == "Login success" ? false : true,
                    );

                    if (result == "Login success") {
                      RouteUtils.push(
                        const BottomNavBar(),
                      );
                    }
                  }
                },
              ),
              SizedBox(
                height: 16.14.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    title: "Don’t have an account?",
                    fontFamily: "Roboto",
                    fontSize: 16.sp,
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
                      child: AppText(
                        title: "Sign Up",
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
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
