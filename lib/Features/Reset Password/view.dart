import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text.dart';
import '../../Widgets/app_text_field.dart';
import '../../Widgets/secondary_app_bar.dart';
import '../Login/view.dart';

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
        title: "Reset password",
        onTap: () {
          RouteUtils.push(
            const LoginView(),
          );
        },
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppText(
                  title: "Please enter your new password",
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.black,
                ),
                SizedBox(
                  height: 45.h,
                ),
                const AppTextField(
                  hint: 'New password',
                  prefixIcon: 'Assets/Images/passIcon.png',
                  suffixIcon: Icons.visibility,
                  obscureText: true,
                ),
                SizedBox(
                  height: 16.01.h,
                ),
                const AppTextField(
                  hint: 'Confirm password',
                  prefixIcon: 'Assets/Images/passIcon.png',
                  suffixIcon: Icons.visibility,
                  obscureText: true,
                ),
                SizedBox(
                  height: 76.28.h,
                ),
                AppButton(
                  width: 317.w,
                  height: 50.86.h,
                  title: "Continue",
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
      ),
    );
  }
}
