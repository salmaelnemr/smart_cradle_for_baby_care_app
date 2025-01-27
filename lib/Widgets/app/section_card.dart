import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Core/app_colors/app_colors.dart';
import '../app_text.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final String icon;

  const SectionCard({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 132.h,
        width: 193.w,
        decoration: BoxDecoration(
          color: AppColors.pinkLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 56.h,
              width: 56.w,
            ),
            SizedBox(
              height: 18.h,
            ),
            AppText(
              title: title,
              fontFamily: "Roboto",
              fontSize: 20,
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
