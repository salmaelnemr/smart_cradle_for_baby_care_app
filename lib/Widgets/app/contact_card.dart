import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Core/app_colors/app_colors.dart';
import '../app_text.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.title,
    this.fontSize = 18,
    this.onPressed,
    required this.contactIcon,
  });

  final String title;
  final double fontSize;
  final void Function()? onPressed;
  final String contactIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            width: 343.w,
            height: 50.86.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.primaryG,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            width: 341.w,
            height: 48.h,
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  contactIcon,
                  height: 23.h,
                  width: 23.w,
                ),
                SizedBox(width: 6.w,),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: AppColors.primaryG,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ).createShader(bounds),
                  child: AppText(
                    title: title,
                    textAlign: TextAlign.center,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
