import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Widgets/app_text.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: AppColors.primaryG,
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ).createShader(bounds),
          child: const AppText(
            title: "Peace of mind &\ntime for yourself",
            textAlign: TextAlign.center,
            fontSize: 36,
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
          ),
        ),
        SizedBox(height: 73.h,),
        Image.asset(
          "Assets/Images/3Onboard.png",
          height: 272.h,
          width: 272.w,
        ),
      ],
    );
  }
}
