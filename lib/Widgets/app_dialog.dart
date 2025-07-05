import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/dimensions/dimentions.dart';
import '../core/app_colors/app_colors.dart';
import 'app_text.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.message,
    required this.confirmTitle,
    required this.onConfirm,
    this.onCancel,
  });

  static void show(
    BuildContext context, {
    required String message,
    String confirmTitle = 'Yes',
    required void Function() onConfirm,
    void Function()? onCancel,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.white.withOpacity(0.1),
      builder: (context) => AppDialog(
        message: message,
        confirmTitle: confirmTitle,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }

  final String message;
  final String confirmTitle;
  final void Function() onConfirm;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 7.w,
          vertical: 4.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 23.height),
              child: AppText(
                title: message,
                fontSize: 20.sp,
                textAlign: TextAlign.center,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: onConfirm,
                    child: AppText(
                      title: confirmTitle,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                      fontSize: 22.sp,
                      color: AppColors.greyLight,
                    ),
                  ),
                ),
                SizedBox(width: 32.w),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if (onCancel == null) {
                        Navigator.pop(context);
                        return;
                      }
                      onCancel!();
                    },
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: AppColors.primaryG,
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ).createShader(bounds),
                      child: AppText(
                        title: "Cancel",
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                        fontSize: 22.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
