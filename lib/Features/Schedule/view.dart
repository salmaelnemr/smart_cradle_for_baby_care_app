import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/route_utils/route_utils.dart';
import 'package:smart_cradle_for_baby_care_app/Features/FeedingSchedule/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Medicine/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Stcky%20Notes/view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app/section_card.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/main_app_bar.dart';
import '../../Core/app_colors/app_colors.dart';
import '../Vaccines/view.dart';

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
        padding: EdgeInsets.symmetric(vertical: 31.h, horizontal: 80.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             InkWell(
              onTap: () {RouteUtils.push(const FeedingSchedule());},
              child: const SectionCard(
                title: "Feeding",
                icon: "Assets/Images/feedIcon.png",
              ),
            ),
            SizedBox(height: 18.h,),
            InkWell(
              onTap: () {RouteUtils.push(const VaccineSchedule());},
              child: const SectionCard(
                title: "Vaccines",
                icon: "Assets/Images/vaccines.png",
              ),
            ),
            SizedBox(height: 18.h,),
             InkWell(
              onTap: () {RouteUtils.push(const MedicineSchedule());},
              child: const SectionCard(
                title: "Medicine",
                icon: "Assets/Images/medicineIcon.png",
              ),
            ),
            SizedBox(height: 18.h,),
            InkWell(
              onTap: () {RouteUtils.push(const StickyNotesSchedule());},
              child: const SectionCard(
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
