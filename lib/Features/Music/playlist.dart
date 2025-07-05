import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Core/route_utils/route_utils.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_img_button.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import 'play_song.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({super.key});

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  List<String> musicNames = [
    'Fire',
    'Rain',
    'Woods',
    'Waves',
    'Bus',
    'Car',
    'Plane',
    'Train',
    'Washing',
    'BlowDryer',
    'Radio',
    'Clock',
    'Note1',
    'Note2',
    'Note3'
  ];

  final AudioPlayer player = AudioPlayer();
  int? currentSoundNumber;

  Future<void> handleTap(int soundNumber) async {
    if (mounted) {
      RouteUtils.push(
        PlaySongView(
          soundNumber: soundNumber,
          player: player,
          musicNames: musicNames,
        ),
      );
    }

    try {
      if (currentSoundNumber != soundNumber) {
        await player.setAsset('Assets/Audios/$soundNumber.mp3');
        currentSoundNumber = soundNumber;
      }
      if (player.playing) {
        await player.pause();
      } else {
        await player.play();
      }
    } catch (e) {
      return;
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.only(right: 15.w, left: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              title: "Nature",
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
              color: AppColors.black,
            ),
            SizedBox(height: 20.h),
            Row(
              children: List.generate(4, (index) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: index < 3 ? 17.w : 0),
                    child: AppImageButton(
                      imagePath: "Assets/Images/${musicNames[index]}.png",
                      onPressed: () => handleTap(index),
                      height: 40.h,
                      width: 40.w,
                    ),
                  ),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: AppText(
                title: "Transport",
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: List.generate(4, (index) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: index < 3 ? 17.w : 0),
                    child: AppImageButton(
                      imagePath: "Assets/Images/${musicNames[index + 4]}.png",
                      onPressed: () => handleTap(index + 4),
                      height: 40.h,
                      width: 40.w,
                    ),
                  ),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: AppText(
                title: "House",
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: List.generate(4, (index) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: index < 3 ? 17.w : 0),
                    child: AppImageButton(
                      imagePath: "Assets/Images/${musicNames[index + 8]}.png",
                      onPressed: () => handleTap(index + 8),
                      height: 40.h,
                      width: 40.w,
                    ),
                  ),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: AppText(
                title: "White noise",
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: List.generate(3, (index) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: index < 2 ? 17.w : 0),
                    child: AppImageButton(
                      imagePath: "Assets/Images/${musicNames[index + 12]}.png",
                      onPressed: () => handleTap(index + 12),
                      height: 40.h,
                      width: 40.w,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
