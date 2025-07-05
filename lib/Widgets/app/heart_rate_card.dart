import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Core/app_colors/app_colors.dart';
import '../app_text.dart';
import '../line_chart.dart';

class HeartRateCard extends StatelessWidget {
  final String title;
  final String value;
  final String status;
  final List<FlSpot> allSpots;

  const HeartRateCard({
    super.key,
    required this.title,
    required this.value,
    required this.status,
    required this.allSpots,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        height: 130.h,
        decoration: BoxDecoration(
          color: AppColors.white2,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppText(
                        title: title,
                        fontFamily: "Roboto",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                      const Spacer(),
                      AppText(
                        title: value,
                        fontFamily: "Roboto",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF8A8A8A),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  AppText(
                    title: status,
                    fontFamily: "Roboto",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyLight,
                  ),
                ],
              ),
            ),
            LineChartWidget(
              allSpots: allSpots,
            ),
          ],
        ),
      ),
    );
  }
}