import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/dimensions/dimentions.dart';
import '../../Core/app_colors/app_colors.dart';
import '../app_text.dart';

class RateDialog extends StatelessWidget {
  const RateDialog({
    super.key,
    required this.message,
    required this.onConfirm,
    required this.confirmTitle,
  });

  static void show(
    BuildContext context, {
    required String message,
    required void Function() onConfirm,
    String confirmTitle = 'Maybe later',
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.white.withOpacity(0.1),
      builder: (context) => RateDialog(
        message: message,
        confirmTitle: confirmTitle,
        onConfirm: onConfirm,
      ),
    );
  }

  final String message;
  final String confirmTitle;
  final void Function() onConfirm;

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
            Container(
              color: AppColors.pinkLight,
              height: 120.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    title: "Rate the Product",
                    fontSize: 20.sp,
                    textAlign: TextAlign.center,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0.h),
                    itemBuilder: (context, _) => ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: AppColors.primaryG,
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ).createShader(bounds),
                      child: const Icon(
                        Icons.star,
                      ),
                    ),
                    onRatingUpdate: (rating) {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: onConfirm,
              child: AppText(
                title: confirmTitle,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                fontSize: 22.sp,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
