import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Core/route_utils/route_utils.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';

class WarningView extends StatefulWidget {
  const WarningView({super.key});

  @override
  State<WarningView> createState() => _WarningViewState();
}

class _WarningViewState extends State<WarningView> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();
    _playWarningSound();
    _dismissTimer = Timer(const Duration(minutes: 2), () {
      if (mounted) {
        RouteUtils.pop();
      }
    });
  }

  Future<void> _playWarningSound() async {
    try {
      await _audioPlayer.play(AssetSource('Assets/Audios/9.mp3'));
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    _dismissTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('warning_dismissible'),
      direction: DismissDirection.up,
      onDismissed: (direction) {
        RouteUtils.pop();
      },
      child: GestureDetector(
        onTap: () {
          RouteUtils.pop();
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: Padding(
            padding: EdgeInsets.only(top: 219.h),
            child: Center(
              child: Column(
                children: [
                  AppText(
                    title: "Your baby temperature is high",
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    fontSize: 24.sp,
                    color: AppColors.black,
                  ),
                  SizedBox(height: 47.h),
                  Container(
                    height: 221.h,
                    width: 220.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDE3535),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Center(
                      child: Image.asset(
                        "Assets/Images/ThermometerHot.png",
                        height: 91.h,
                        width: 91.w,
                      ),
                    ),
                  ),
                  SizedBox(height: 67.h),
                  AppText(
                    title: "Stop",
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontSize: 36.sp,
                    color: AppColors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
