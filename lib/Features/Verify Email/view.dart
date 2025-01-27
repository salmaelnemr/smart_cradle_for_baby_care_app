import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Reset%20Password/view.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/passcode_input.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text.dart';
import '../../Widgets/secondary_app_bar.dart';
import '../Login/view.dart';

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
        title: "Forgot password",
        onTap: () {
          RouteUtils.push(
            const LoginView(),
          );
        },
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 16.h,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppText(
                  title: "Please send the 4 digit code that send to your\nemail address",
                  fontSize: 14,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 53.h,
                ),
                Center(
                  child: PasscodeInput(
                    onCompleted: (passcode) {
                      print('Entered Passcode: $passcode');
                    },
                  ),
                ),
                SizedBox(height: 16.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppText(
                      title: "Don’t receive code?",
                      fontFamily: "Roboto",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyLight,
                    ),
                    TextButton(
                      onPressed: () {
                        // RouteUtils.push(
                        //   const LoginView(),
                        // );
                      },
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: AppColors.primaryG,
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ).createShader(bounds),
                        child: const AppText(
                          title: "Resend",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 73.h,
                ),
                AppButton(
                  width: 317.w,
                  height: 50.86.h,
                  title: "Send",
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
