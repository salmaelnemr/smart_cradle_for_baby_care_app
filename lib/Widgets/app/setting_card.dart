import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Core/app_colors/app_colors.dart';
import '../app_text.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({
    super.key,
    required this.title,
    required this.image,
    this.color = AppColors.black,
    this.value,
    this.onChanged,
    this.onTap,
    this.onPressed,
  });

  final String title;
  final String image;
  final Color? color;
  final bool? value;
  final ValueChanged<bool>? onChanged;
  final void Function()? onTap;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 341.w,
        height: 48.h,
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              image,
              height: 21.h,
              width: 21.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            AppText(
              title: title,
              textAlign: TextAlign.center,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
              color: color,
            ),
            const Spacer(),
            if (value != null && onChanged != null)
              InkWell(
                onTap: onTap,
                child: CupertinoSwitch(
                  value: value!,
                  onChanged: onChanged,
                  activeColor: const Color(0xFF55C76C),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
