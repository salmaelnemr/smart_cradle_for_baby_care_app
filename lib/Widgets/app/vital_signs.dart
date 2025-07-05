import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app/temperature_card.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app/weight_card.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/models/sensor_status_model.dart';
import '../app_text.dart';
import 'heart_rate_card.dart';

class VitalSignsView extends StatelessWidget {
  final String babyTemperature;
  final String homeTemperature;
  final String heartRate;
  final String breathing;
  final String weight;
  final double babyTemperatureRatio;
  final double homeTemperatureRatio;
  final double breathingRatio;
  final double weightRatio;
  final List<FlSpot> heartRateSpots;
  final SensorDataStatusModel sensorDataStatusModel;

  const VitalSignsView({
    super.key,
    required this.babyTemperature,
    required this.homeTemperature,
    required this.heartRate,
    required this.breathing,
    required this.weight,
    required this.babyTemperatureRatio,
    required this.homeTemperatureRatio,
    required this.breathingRatio,
    required this.weightRatio,
    required this.heartRateSpots,
    required this.sensorDataStatusModel,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: 18.h,
        right: 20.w,
        left: 20.w,
        bottom: 25.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            title: "Vital Signs",
            fontSize: 24.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
          SizedBox(height: 25.h),
          Row(
            children: [
              Expanded(
                child: TemperatureCard(
                  temperatureDegree: const [],
                  imgTitle: 'Assets/Images/sticky_notes.png',
                  title: "Baby Temperature",
                  status: sensorDataStatusModel.babyTemp,
                  degree: babyTemperature,
                  progressRatio: babyTemperatureRatio,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: TemperatureCard(
                  temperatureDegree: const [],
                  imgTitle: 'Assets/Images/homeTemp.png',
                  title: "Home Temperature",
                  status: sensorDataStatusModel.roomTemp,
                  degree: homeTemperature,
                  progressRatio: homeTemperatureRatio,
                ),
              ),
            ],
          ),
          SizedBox(height: 25.h),
          HeartRateCard(
            title: "Heart rate",
            value: heartRate,
            status: sensorDataStatusModel.heartRate,
            allSpots: heartRateSpots,
          ),
          SizedBox(height: 25.h),
          Row(
            children: [
              WeightCard(
                title: "Breathing",
                subtitle: sensorDataStatusModel.sPo2,
                imgTitle: "Assets/Images/breatheIcon.png",
                value: breathing,
                progressRatio: breathingRatio,
              ),
              SizedBox(width: 14.w),
              WeightCard(
                title: "Weight",
                subtitle: sensorDataStatusModel.weight,
                imgTitle: "Assets/Images/weightIcon.png",
                value: weight,
                progressRatio: weightRatio,
              ),
            ],
          ),
        ],
      ),
    );
  }
}