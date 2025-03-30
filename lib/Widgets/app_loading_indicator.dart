import 'package:flutter/material.dart';
import '../core/app_colors/app_colors.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.pinkLight,
        strokeWidth: 1.5,
      ),
    );
  }
}
