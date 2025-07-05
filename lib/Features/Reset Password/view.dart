import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Update%20Password%20Successfully/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Verify%20Email/view.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text.dart';
import '../../Widgets/app_text_field.dart';
import '../../Widgets/secondary_app_bar.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: "Reset Password",
        onTap: () {
          RouteUtils.push(
            const VerifyEmailView(),
          );
        },
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 61.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'Assets/Images/savePassword.png',
                  height: 269.h,
                  width: 404.w,
                ),
                SizedBox(
                  height: 30.h,
                ),
                AppText(
                  title: "Please, Enter your new password!",
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: AppColors.black,
                ),
                SizedBox(
                  height: 18.h,
                ),
                const AppTextField(
                  hint: 'New Password',
                  prefixIcon: 'Assets/Images/passIcon.png',
                  suffixIcon: Icons.visibility,
                  obscureText: true,
                ),
                SizedBox(
                  height: 16.01.h,
                ),
                const AppTextField(
                  hint: 'Confirm New Password',
                  prefixIcon: 'Assets/Images/passIcon.png',
                  suffixIcon: Icons.visibility,
                  obscureText: true,
                ),
                SizedBox(
                  height: 21.28.h,
                ),
                AppButton(
                  width: 317.w,
                  height: 50.86.h,
                  title: "Save Password",
                  onPressed: () {
                    RouteUtils.push(
                      const UpdatePasswordSuccessfully(),
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
