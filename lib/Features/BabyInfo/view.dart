import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Passcode/view.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text.dart';
import '../../Widgets/app_text_field.dart';

class BabyInformationView extends StatelessWidget {
  const BabyInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pinkLight,
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(right: 40.w, left: 40.w, top: 68.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  title: "What’s your baby’s name?",
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                  color: AppColors.black,
                ),
                SizedBox(
                  height: 8.h,
                ),
                const AppTextField(
                  hint: 'Baby’s name',
                  prefixIcon: 'Assets/Images/babyIcon.png',
                ),
                SizedBox(
                  height: 34.14.h,
                ),
                const AppText(
                  title: "What’s your baby’s birthdate?",
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                  color: AppColors.black,
                ),
                SizedBox(
                  height: 8.h,
                ),
                const AppTextField(
                  hint: '3/10/2024',
                  prefixIcon: 'Assets/Images/calenderIcon.png',
                ),
                SizedBox(
                  height: 214.14.h,
                ),
                AppButton(
                  width: 317.w,
                  height: 50.86.h,
                  title: "Continue",
                  onPressed: (){
                    RouteUtils.push(
                      const PasscodeView(),
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
