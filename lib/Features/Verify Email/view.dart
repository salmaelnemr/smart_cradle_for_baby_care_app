import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Forgot%20Password/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Reset%20Password/view.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/passcode_input.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text.dart';
import '../../Widgets/secondary_app_bar.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: "Forgot Password",
        onTap: () {
          RouteUtils.push(
            const ForgotPasswordView(),
          );
        },
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 45.h,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'Assets/Images/verifyCode.png',
                  height: 252.28.h,
                  width: 350.w,
                ),
                SizedBox(
                  height: 54.72.h,
                ),
                AppText(
                  title: "Enter the 4 digit code that send to your email\naddress",
                  fontSize: 14.sp,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 23.h,
                ),
                Center(
                  child: PasscodeInput(
                    onCompleted: (passcode) {

                    },
                    color: AppColors.pinkLight,
                  ),
                ),
                SizedBox(height: 16.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      title: "Don’t receive code?",
                      fontFamily: "Roboto",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyLight,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: AppColors.primaryG,
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ).createShader(bounds),
                        child: AppText(
                          title: "Resend",
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 29.h,
                ),
                AppButton(
                  width: 317.w,
                  height: 50.86.h,
                  title: "Verify Code",
                  onPressed: (){
                    RouteUtils.push(
                      const ResetPasswordView(),
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
