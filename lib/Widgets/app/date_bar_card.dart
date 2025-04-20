import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Core/app_colors/app_colors.dart';

class DateBarCard extends StatelessWidget {
  const DateBarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        //[selectedDate] the new date selected.
      },
      dayProps: EasyDayProps(
        todayHighlightColor: AppColors.pinkLight,
        height: 76.h,
        width: 67.w,
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.primaryG,
            ),
          ),
        ),
      ),
    );
  }
}
