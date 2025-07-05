import 'package:flutter/material.dart';
import '../Core/app_colors/app_colors.dart';
import '../Core/route_utils/route_utils.dart';
import 'app_text.dart';

void showSnackBar(
    String message, {
      bool showDismissButton = false,
      bool error = false,
    }) {
  ScaffoldMessenger.of(RouteUtils.context).hideCurrentSnackBar();
  ScaffoldMessenger.of(RouteUtils.context).showSnackBar(
    SnackBar(
      content: AppText(title: message,),
      backgroundColor: error ? AppColors.red : AppColors.green,
      behavior: SnackBarBehavior.floating,
      action: showDismissButton
          ? SnackBarAction(
        onPressed: () {
          print('Dismiss');
        },
        textColor: AppColors.white,
        label: "Dismiss",
      )
          : null,
    ),
  );
}