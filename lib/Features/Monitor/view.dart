import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Widgets/main_app_bar.dart';

class MonitorView extends StatefulWidget {
  const MonitorView({super.key});

  @override
  State<MonitorView> createState() => _MonitorViewState();
}

class _MonitorViewState extends State<MonitorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const MainAppBar(
        title: 'Monitor',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 572.h,
                width: 345.w,
                decoration: BoxDecoration(
                  color: AppColors.pinkLight,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 17.h,),
            const AppText(
              title: "Baby status is normal",
              fontFamily: "Roboto",
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
