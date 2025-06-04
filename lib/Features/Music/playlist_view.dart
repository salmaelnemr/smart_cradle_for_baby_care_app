import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
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
    'Blow dryer',
    'Radio',
    'Clock',
    'Note1',
    'Note2',
    'Note3'
  ];

  int mediaNumb = 0;
  final player = AudioPlayer();

  void handlePlayPause(int soundNumber) {
    player.setAsset('Assets/Audios/$soundNumber.mp3');

    if (player.playing) {
      player.pause();
    } else {
      player.play();
      mediaNumb = soundNumber;
    }
  }

  void navigateToPlaybackPage(int soundNumber) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaySongView(
          soundNumber: soundNumber,
          player: player,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.only(
          right: 15.w,
          left: 15.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText(
              title: "Nature",
              fontSize: 24,
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
              color: AppColors.black,
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                AppImageButton(
                  imagePath: "Assets/Images/Fire.png",
                  onPressed: () {
                    handlePlayPause(0);
                    navigateToPlaybackPage(0);
                  },
                  height: 40.h,
                  width: 40.w,
                ),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                  imagePath: "Assets/Images/Rain.png",
                  onPressed: () {
                    handlePlayPause(1);
                    navigateToPlaybackPage(1);
                  },
                  height: 40.h,
                  width: 40.w,
                ),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                  imagePath: "Assets/Images/Woods.png",
                  onPressed: () {
                    handlePlayPause(2);
                    navigateToPlaybackPage(2);
                  },
                  height: 40.h,
                  width: 40.w,
                ),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                  imagePath: "Assets/Images/Waves.png",
                  onPressed: () {
                    handlePlayPause(3);
                    navigateToPlaybackPage(3);
                  },
                  height: 40.h,
                  width: 40.w,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: const AppText(
                title: "Transport",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                color: AppColors.black,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                AppImageButton(
                  imagePath: "Assets/Images/Bus.png",
                  onPressed: () {
                    handlePlayPause(4);
                    navigateToPlaybackPage(4);
                  },
                  height: 40.h,
                  width: 40.w,
                ),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                  imagePath: "Assets/Images/Car.png",
                  onPressed: () {
                    handlePlayPause(5);
                    navigateToPlaybackPage(5);
                  },
                  height: 40.h,
                  width: 40.w,
                ),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                  imagePath: "Assets/Images/Plane.png",
                  onPressed: () {
                    handlePlayPause(6);
                    navigateToPlaybackPage(6);
                  },
                  height: 40.h,
                  width: 40.w,
                ),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                  imagePath: "Assets/Images/Train.png",
                  onPressed: () {
                    handlePlayPause(7);
                    navigateToPlaybackPage(7);
                  },
                  height: 40.h,
                  width: 40.w,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
              ),
              child: const AppText(
                title: "House",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                color: AppColors.black,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                AppImageButton(
                  imagePath: "Assets/Images/Washing.png",
                  onPressed: () {
                    handlePlayPause(8);
                    navigateToPlaybackPage(8);
                  },
                  height: 40.h,
                  width: 40.w,
                ),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                  imagePath: "Assets/Images/BlowDryer.png",
                  onPressed: () {
                    handlePlayPause(9);
                    navigateToPlaybackPage(9);
                  },
                  height: 40.h,
                  width: 40.w,
                ),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                  imagePath: "Assets/Images/Radio.png",
                  onPressed: () {
                    handlePlayPause(10);
                    navigateToPlaybackPage(10);
                  },
                  height: 40.h,
                  width: 40.w,
                ),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                  imagePath: "Assets/Images/Clock.png",
                  onPressed: () {
                    handlePlayPause(11);
                    navigateToPlaybackPage(11);
                  },
                  height: 40.h,
                  width: 40.w,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
              ),
              child: const AppText(
                title: "White noise",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                color: AppColors.black,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                AppImageButton(
                  imagePath: "Assets/Images/Note1.png",
                  onPressed: () {
                    handlePlayPause(12);
                    navigateToPlaybackPage(12);
                  },
                  height: 40.h,
                  width: 40.w,
                ),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                  imagePath: "Assets/Images/Note2.png",
                  onPressed: () {
                    handlePlayPause(13);
                    navigateToPlaybackPage(13);
                  },
                  height: 40.h,
                  width: 40.w,
                ),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                  imagePath: "Assets/Images/Note3.png",
                  onPressed: () {
                    handlePlayPause(14);
                    navigateToPlaybackPage(14);
                  },
                  height: 40.h,
                  width: 40.w,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
