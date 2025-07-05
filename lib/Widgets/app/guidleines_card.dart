import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Core/app_colors/app_colors.dart';
import '../app_text.dart';

class GuidelinesCard extends StatelessWidget {
  const GuidelinesCard({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final List<String> content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 11.h,
                width: 11.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColors.primaryG,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(32.r),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: AppText(
                  title: title,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: const Color(0xFF000000),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          ...content.map(
            (text) => Padding(
              padding: EdgeInsets.only(left: 24.0.w, bottom: 12.0.h, top: 24.h,),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 4.h,
                    width: 4.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Baseline(
                      baseline: 0,
                      baselineType: TextBaseline.alphabetic,
                      child: AppText(
                        title: text,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: const Color(0xFF000000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
