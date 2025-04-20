import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_img_button.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';

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
                      showMusicBottomSheet(0);
                    }),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                    imagePath: "Assets/Images/Rain.png",
                    onPressed: () {
                      handlePlayPause(1);
                      showMusicBottomSheet(1);
                    }),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                    imagePath: "Assets/Images/Woods.png",
                    onPressed: () {
                      handlePlayPause(2);
                      showMusicBottomSheet(2);
                    }),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                    imagePath: "Assets/Images/Waves.png",
                    onPressed: () {
                      handlePlayPause(3);
                      showMusicBottomSheet(3);
                    }),
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
                      showMusicBottomSheet(4);
                    }),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                    imagePath: "Assets/Images/Car.png",
                    onPressed: () {
                      handlePlayPause(5);
                      showMusicBottomSheet(5);
                    }),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                    imagePath: "Assets/Images/Plane.png",
                    onPressed: () {
                      handlePlayPause(6);
                      showMusicBottomSheet(6);
                    }),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                    imagePath: "Assets/Images/Train.png",
                    onPressed: () {
                      handlePlayPause(7);
                      showMusicBottomSheet(7);
                    }),
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
                      showMusicBottomSheet(8);
                    }),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                    imagePath: "Assets/Images/BlowDryer.png",
                    onPressed: () {
                      handlePlayPause(9);
                      showMusicBottomSheet(9);
                    }),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                    imagePath: "Assets/Images/Radio.png",
                    onPressed: () {
                      handlePlayPause(10);
                      showMusicBottomSheet(10);
                    }),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                    imagePath: "Assets/Images/Clock.png",
                    onPressed: () {
                      handlePlayPause(11);
                      showMusicBottomSheet(11);
                    }),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
              ),
              child: const AppText(
                title: "White Noise",
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
                      showMusicBottomSheet(12);
                    }),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                    imagePath: "Assets/Images/Note2.png",
                    onPressed: () {
                      handlePlayPause(13);
                      showMusicBottomSheet(13);
                    }),
                SizedBox(
                  width: 17.w,
                ),
                AppImageButton(
                    imagePath: "Assets/Images/Note3.png",
                    onPressed: () {
                      handlePlayPause(14);
                      showMusicBottomSheet(14);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

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

  void showMusicBottomSheet(int currentSoundNumber) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // <-- Wrap with StatefulBuilder
          builder: (BuildContext context, StateSetter setState) {
            // <-- Add
            return Column(
              children: [
                Expanded(child: Image.asset('Assets/Images/playing.png')),
                Center(
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: AppColors.primaryG,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                    child: Text(
                      musicNames[currentSoundNumber],
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto",
                          color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: AppImageButton(
                            imagePath: "Assets/Images/prev.png",
                            onPressed: () async {
                              currentSoundNumber = mediaNumb--;
                              player.setAsset(
                                  'Assets/Audios/$currentSoundNumber.mp3');
                              setState(() {}); // StateSetter
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded(
                          child: SizedBox(
                        width: 45,
                        height: 45,
                        child: AppImageButton(
                          imagePath: (player.playing)
                              ? "Assets/Images/pause.png"
                              : "Assets/Images/play.png",
                          onPressed: () {
                            if (player.playing) {
                              currentSoundNumber = mediaNumb;
                            }
                            handlePlayPause(currentSoundNumber);
                            setState(() {}); // StateSetter
                          },
                        ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: AppImageButton(
                            imagePath: "Assets/Images/next.png",
                            onPressed: () async {
                              currentSoundNumber = mediaNumb++;
                              player.setAsset(
                                  'Assets/Audios/$currentSoundNumber.mp3');
                              setState(() {}); // StateSetter
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
