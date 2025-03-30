import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Login/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Verify%20Email/view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text_field.dart';
import '../../Widgets/secondary_app_bar.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: "Forgot Password",
        onTap: () {
          RouteUtils.push(
            const LoginView(),
          );
        },
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 64.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'Assets/Images/forget.png',
                  height: 274.5.h,
                  width: 294.w,
                ),
                SizedBox(
                  height: 61.5.h,
                ),
                const AppText(
                  title: "Please, Enter your email to send you reset code!",
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.black,
                ),
                SizedBox(
                  height: 18.h,
                ),
                const AppTextField(
                  hint: 'Email',
                  prefixIcon: 'Assets/Images/emailIcon.png',
                ),
                SizedBox(
                  height: 48.14.h,
                ),
                AppButton(
                  width: 317.w,
                  height: 50.86.h,
                  title: "Send Email",
                  onPressed: () {
                    RouteUtils.push(
                      const VerifyEmailView(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
