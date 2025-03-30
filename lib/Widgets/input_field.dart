import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const MyInputField({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              title: title,
              color: Colors.grey[800],
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: "Roboto",
            ),
            Container(
              margin: EdgeInsets.only(
                top: 4.h,
              ),
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyLight, width: 1.w,),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: widget == null ? false : true,
                      autofocus: false,
                      cursorColor: AppColors.pink,
                      controller: controller,
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.black,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        hintText: hint,
                        hintStyle: const TextStyle(
                          color: AppColors.greyLight,
                          fontSize: 18,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                        ),
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  widget == null
                      ? Container()
                      : Container(
                          child: widget,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
