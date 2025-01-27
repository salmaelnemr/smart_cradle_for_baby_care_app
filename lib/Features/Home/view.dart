import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/main_app_bar.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app/temperature_card.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Widgets/app/heart_rate_card.dart';
import '../../Widgets/circular_progress_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<FlSpot> get allSpots => const [
        FlSpot(0, 20),
        FlSpot(1, 25),
        FlSpot(2, 40),
        FlSpot(3, 50),
        FlSpot(4, 35),
        FlSpot(5, 40),
        FlSpot(6, 30),
        FlSpot(7, 20),
        FlSpot(8, 25),
        FlSpot(9, 40),
        FlSpot(10, 50),
        FlSpot(11, 35),
        FlSpot(12, 50),
        FlSpot(13, 60),
        FlSpot(14, 40),
        FlSpot(15, 50),
        FlSpot(16, 20),
        FlSpot(17, 25),
        FlSpot(18, 40),
        FlSpot(19, 50),
        FlSpot(20, 35),
        FlSpot(21, 80),
        FlSpot(22, 30),
        FlSpot(23, 20),
        FlSpot(24, 25),
        FlSpot(25, 40),
        FlSpot(26, 50),
        FlSpot(27, 35),
        FlSpot(28, 50),
        FlSpot(29, 60),
        FlSpot(30, 40)
      ];
  List temperatureDegree = [
    {"title": "42 C"},
    {"title": "39 C"},
    {"title": "37 C"},
    {"title": "35 C"},
    {"title": "30 C"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const MainAppBar(
        appLogo: 'Assets/Images/AppLogo.png',
        profileIcon: 'Assets/Images/profileIcon.png',
        notificationIcon: 'Assets/Images/notificationIcon.png',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 18.h,
          right: 21.w,
          left: 21.w,
          bottom: 27.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const AppText(
                  title: "Vital signs",
                  fontSize: 24,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
                SizedBox(
                  width: 160.w,
                ),
                Container(
                  height: 25.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.pinkLight,
                  ),
                  child: const Center(
                    child: AppText(
                      title: "Weekly",
                      fontFamily: "Roboto",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 18.h,
            ),
            Row(
              children: [
                Expanded(
                  child: TemperatureCard(
                    temperatureDegree: temperatureDegree,
                    imgTitle: "Assets/Images/babyTemp.png",
                    status: "Normal",
                    subtitle: 'Baby',
                    color: const Color(0xFF26B57E),
                  ),
                ),
                SizedBox(
                  width: 37.w,
                ),
                Expanded(
                  child: TemperatureCard(
                    temperatureDegree: temperatureDegree,
                    imgTitle: "Assets/Images/homeTemp.png",
                    status: "Hot",
                    subtitle: 'Room',
                    color: const Color(0xFFFF210D),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            HeartRateCard(
              title: "Heart rate",
              value: "78 BPM",
              status: "Normal",
              allSpots: allSpots,
              color: const Color(0xFF26B57E),
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              children: [
                const CircularProgressBar(
                  title: "Breathing",
                  subtitle: "Normal",
                  color: Color(0xFF26B57E),
                  imgTitle: "Assets/Images/breatheIcon.png",
                  value: "98 SpO2",
                ),
                SizedBox(
                  width: 37.w,
                ),
                const CircularProgressBar(
                  title: "Weight",
                  subtitle: "Normal",
                  color: Color(0xFF26B57E),
                  imgTitle: "Assets/Images/weightIcon.png",
                  value: "2.4 kg",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
