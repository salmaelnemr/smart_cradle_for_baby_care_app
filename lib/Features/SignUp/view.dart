import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/validator_utils/validator_utils.dart';
import 'package:smart_cradle_for_baby_care_app/Features/BabyInfo/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Login/view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/dio/api_provider.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text_field.dart';
import '../../Widgets/snack_bar.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  var formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
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
              SizedBox(height: 43.h),
              Image.asset(
                'Assets/Images/logo.png',
                height: 146.h,
                width: 146.w,
              ),
              SizedBox(height: 4.h),
              const AppText(
                title: "Create Account!",
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                fontSize: 32,
                color: AppColors.black,
              ),
              SizedBox(height: 40.86.h),
              AppTextField(
                hint: 'Full Name',
                prefixIcon: 'Assets/Images/personIcon.png',
                controller: fullNameController,
                validator: ValidatorUtils.name,
              ),
              SizedBox(height: 16.28.h),
              AppTextField(
                hint: 'Email',
                prefixIcon: 'Assets/Images/emailIcon.png',
                controller: emailController,
                validator: ValidatorUtils.email,
              ),
              SizedBox(height: 16.28.h),
              AppTextField(
                hint: 'Phone Number',
                prefixIcon: 'Assets/Images/phoneIcon.png',
                controller: phoneNumberController,
                validator: ValidatorUtils.phone,
              ),
              SizedBox(height: 16.28.h),
              AppTextField(
                hint: 'Password',
                prefixIcon: 'Assets/Images/passIcon.png',
                suffixIcon: Icons.visibility,
                obscureText: true,
                controller: passwordController,
                validator: ValidatorUtils.password,
              ),
              SizedBox(height: 16.28.h),
              AppTextField(
                hint: 'Confirm Password',
                prefixIcon: 'Assets/Images/passIcon.png',
                suffixIcon: Icons.visibility,
                obscureText: true,
                controller: confirmPasswordController,
                validator: ValidatorUtils.password,
              ),
              SizedBox(height: 64.14.h),
              AppButton(
                width: 317.w,
                height: 50.86.h,
                title: "Sign Up",
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    String result = await ApiProvider().registerUser(
                      fullName: fullNameController.text,
                      email: emailController.text,
                      phoneNumber: phoneNumberController.text,
                      password: passwordController.text,
                      confirmPassword: confirmPasswordController.text,
                    );

                    showSnackBar(
                      result.contains("failed") ? result : "Registration Success",
                      error: false,
                    );

                    if (!result.contains("failed")) {
                      RouteUtils.push(
                        BabyInformationView(userId: result),
                      );
                    }
                  }
                },
              ),
              SizedBox(height: 16.14.h),
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

