import 'package:flutter/material.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';

class DatePicker {
  static Future<DateTime?> show({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(3000),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.pink,
              onPrimary: AppColors.white,
              onSurface: AppColors.black,
            ),
            textTheme: const TextTheme(
              headlineLarge: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
              titleMedium: TextStyle(
                fontSize: 18,
                color: AppColors.black,
              ),
            ),
            dialogBackgroundColor: AppColors.white,
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppColors.white,
              headerBackgroundColor: AppColors.white,
              headerForegroundColor: AppColors.pink,
              dayBackgroundColor: WidgetStateProperty.all(Colors.transparent),
              dayForegroundColor: WidgetStateProperty.all(Colors.black),
              todayBackgroundColor: WidgetStateProperty.all(AppColors.pink),
              todayForegroundColor: WidgetStateProperty.all(AppColors.white),
              yearForegroundColor: WidgetStateProperty.all(Colors.black),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    return pickedDate;
  }
}
