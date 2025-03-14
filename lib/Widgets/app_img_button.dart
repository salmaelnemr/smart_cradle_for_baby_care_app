import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppImageButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const AppImageButton({
    super.key,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Image.asset(imagePath, height: 40.h, width: 40.w,),
    );
  }
}