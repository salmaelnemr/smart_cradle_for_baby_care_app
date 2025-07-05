import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Sign%20Up%20Successfully/view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_button.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/snack_bar.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/dio/api_provider.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/passcode_input.dart';
import '../../Widgets/app_text.dart';

class PasscodeView extends StatefulWidget {
  final String userId;
  const PasscodeView({super.key, required this.userId});

  @override
  State<PasscodeView> createState() => _PasscodeViewState();
}

class _PasscodeViewState extends State<PasscodeView> {
  String enteredPasscode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pinkLight,
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 43.h),
              Center(
                child: Image.asset(
                  'Assets/Images/logo.png',
                  height: 146.h,
                  width: 146.w,
                ),
              ),
              SizedBox(height: 32.h),
              AppText(
                title: "Enter Cradle Passcode",
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
                fontSize: 22.sp,
                color: AppColors.black,
              ),
              SizedBox(height: 8.h),
              AppText(
                title: "You will find it on the cradle ",
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.grey2,
              ),
              SizedBox(height: 40.h),
              Center(
                child: PasscodeInput(
                  onCompleted: (passcode) {
                    setState(() {
                      enteredPasscode = passcode;
                    });
                    print('Entered Passcode: $passcode');
                  },
                ),
              ),
              SizedBox(height: 266.h),
              AppButton(
                width: 317.w,
                height: 50.86.h,
                title: "Verify Code",
                onPressed: () async {
                  if (enteredPasscode.isNotEmpty) {
                    String message = await ApiProvider().cradlePasscode(
                      userId: widget.userId,
                      passCode: enteredPasscode,
                    );
                    showSnackBar(
                      message,
                      error: false,
                    );

                    if (message == "Passcode submitted successfully") {
                      RouteUtils.push(
                        const SignUpSuccessfully(),
                      );
                    }
                  } else {
                    showSnackBar(
                      "Please enter a passcode",
                      error: true,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
