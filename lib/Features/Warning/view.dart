import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';

class WarningView extends StatefulWidget {
  const WarningView({super.key});

  @override
  State<WarningView> createState() => _WarningViewState();
}

class _WarningViewState extends State<WarningView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 219.h),
        child: Center(
          child: Column(
            children: [
              const AppText(
                title: "Your baby temperature is high",
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: AppColors.black,
              ),
              SizedBox(height: 47.h,),
              Container(
                height: 221.h,
                width: 220.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFDE3535),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset(
                  "Assets/Images/ThermometerHot.png",
                  height: 91.h,
                  width: 91.w,
                ),
              ),
              SizedBox(height: 67.h,),
              const AppText(
                title: "Stop",
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                fontSize: 36,
                color: AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
