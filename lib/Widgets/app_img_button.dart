import 'package:flutter/material.dart';

class AppImageButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;
  final double height;
  final double width;

  const AppImageButton({
    super.key,
    required this.imagePath,
    required this.onPressed,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Image.asset(imagePath, height: height, width: width,),
    );
  }
}