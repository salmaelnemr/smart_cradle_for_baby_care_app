import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Core/app_colors/app_colors.dart';

class CustomIndicator extends StatelessWidget {
  final bool active;
  const CustomIndicator({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.r),
        gradient: active
            ? LinearGradient(
                colors: AppColors.primaryG,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )
            : LinearGradient(
                colors: AppColors.dGray,
                transform: GradientRotation(180.r),
              ),
      ),
      width: active ? 20.w : 9.w,
      height: 9.h,
    );
  }
}
