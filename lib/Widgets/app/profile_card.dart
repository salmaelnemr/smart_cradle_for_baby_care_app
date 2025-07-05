import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Core/app_colors/app_colors.dart';
import '../app_text.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 343.w,
        height: 97.h,
        decoration: BoxDecoration(
          color: AppColors.pinkLight,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade300, width: 1.5.w,),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 15.h, left: 12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                image,
                height: 68.h,
                width: 68.w,
              ),
              SizedBox(
                width: 18.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      title: title,
                      fontFamily: "Roboto",
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    AppText(
                      title: subtitle,
                      fontFamily: "Roboto",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyLight,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
