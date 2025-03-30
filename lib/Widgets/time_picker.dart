import 'package:flutter/material.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';

class TimePicker {
  static Future<TimeOfDay?> show({
    required BuildContext context,
    required String initialTime,
  }) async {
    return await showTimePicker(
      context: context,
      initialTime: _parseTimeString(initialTime),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.pink,
              onPrimary: AppColors.white,
              onSurface: Colors.black,
              onTertiaryContainer: AppColors.white,
              onSecondaryContainer: AppColors.pink,
            ),
            timePickerTheme: const TimePickerThemeData(
              entryModeIconColor: AppColors.pink,
              dayPeriodColor: AppColors.pink,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
  }

  static TimeOfDay _parseTimeString(String timeString) {
    try {
      final timeParts = timeString.split(':');
      final hour = int.parse(timeParts[0]);
      final minuteParts = timeParts[1].split(' ');
      final minute = int.parse(minuteParts[0]);
      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return TimeOfDay.now();
    }
  }
}
