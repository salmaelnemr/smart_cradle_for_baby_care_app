import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import '../../Core/app_colors/app_colors.dart';
import '../app_text.dart';

class WeightCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imgTitle;
  final String value;
  final double progressRatio;

  const WeightCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imgTitle,
    required this.value,
    required this.progressRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 192.h,
        padding: EdgeInsets.only(
          top: 13.h,
          left: 10.w,
          right: 9.w,
        ),
        decoration: BoxDecoration(
          color: AppColors.white2,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.r,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  title: title,
                  fontFamily: "Roboto",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
                AppText(
                  title: value,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp,
                  color: const Color(0xFF8A8A8A),
                ),
              ],
            ),
            AppText(
              title: subtitle,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w400,
              fontSize: 13.sp,
              color: AppColors.greyLight,
            ),
            SizedBox(height: 10.h),
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: 96.11.w,
                height: 96.11.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 77.h,
                      height: 77.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(29.r),
                      ),
                      child: Container(
                        width: 61.h,
                        height: 61.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: AppColors.primaryG),
                          borderRadius: BorderRadius.circular(29.r),
                        ),
                        child: Container(
                          width: 58.h,
                          height: 58.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(29.r),
                          ),
                          child: FittedBox(
                            child: Image.asset(
                              imgTitle,
                              height: 40.h,
                              width: 40.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SimpleCircularProgressBar(
                      progressStrokeWidth: 17,
                      backStrokeWidth: 17,
                      progressColors: AppColors.primaryG,
                      backColor: const Color(0xFFF6D2D3),
                      valueNotifier: ValueNotifier(progressRatio * 100),
                      startAngle: -180,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}