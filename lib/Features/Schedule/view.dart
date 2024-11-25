import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app/section_card.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/main_app_bar.dart';
import '../../Core/app_colors/app_colors.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const MainAppBar(
        title: 'Schedule',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 60.h, horizontal: 80.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const InkWell(
              child: SectionCard(
                title: "Feeding",
                icon: "Assets/Images/feedIcon.png",
              ),
            ),
            SizedBox(height: 22.h,),
            const InkWell(
              child: SectionCard(
                title: "Vaccines",
                icon: "Assets/Images/vaccines.png",
              ),
            ),
            SizedBox(height: 22.h,),
            const InkWell(
              child: SectionCard(
                title: "Sticky notes",
                icon: "Assets/Images/sticky_notes.png",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
