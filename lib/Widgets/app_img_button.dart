import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppImageButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const AppImageButton({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 70.w,
        height: 70.h,
        child: TextButton(
          onPressed: onPressed,
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
