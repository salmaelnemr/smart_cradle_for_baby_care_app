import 'package:flutter/material.dart';
import '../core/app_colors/app_colors.dart';
import 'app_loading_indicator.dart';
import 'app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.fontSize = 18,
    this.onPressed,
    this.color = AppColors.darkGrey,
    this.isLoading = false,
    required this.height,
    required this.width,
  });

  final String title;
  final double fontSize;
  final void Function()? onPressed;
  final Color color ;
  final bool isLoading;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const AppLoadingIndicator();
    }
    return InkWell(
      onTap: onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.primaryG,
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            AppText(
              textAlign: TextAlign.center,
              title: title,
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
              color: AppColors.grey,
            ),
          ],
        ),
    );
  }
}
