import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/BottomNavBar/view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_button.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/passcode_input.dart';
import '../../Widgets/app_text.dart';

class PasscodeView extends StatefulWidget {
  const PasscodeView({super.key});

  @override
  State<PasscodeView> createState() => _PasscodeViewState();
}

class _PasscodeViewState extends State<PasscodeView> {
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
              Center(
                child: Image.asset(
                  'Assets/Images/logo.png',
                  height: 146.h,
                  width: 146.w,
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              const AppText(
                title: "Enter cradle passcode",
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
                fontSize: 22,
                color: AppColors.black,
              ),
              SizedBox(
                height: 8.h,
              ),
              const AppText(
                title: "you will find it on the cradle ",
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.grey2,
              ),
              SizedBox(
                height: 40.h,
              ),
              Center(
                child: PasscodeInput(
                  onCompleted: (passcode) {
                    print('Entered Passcode: $passcode');
                  },
                ),
              ),
              SizedBox(
                height: 266.h,
              ),
              AppButton(
                width: 317.w,
                height: 50.86.h,
                title: "Go home",
                onPressed: (){
                  RouteUtils.push(
                    const BottomNavBar(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
