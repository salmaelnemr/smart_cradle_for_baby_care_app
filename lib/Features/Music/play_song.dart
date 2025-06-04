import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_img_button.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/snack_bar.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_text.dart';
import '../../Widgets/secondary_app_bar.dart';

class PlaySongView extends StatefulWidget {
  final int soundNumber;
  final AudioPlayer player;

  const PlaySongView(
      {super.key, required this.soundNumber, required this.player});

  @override
  State<PlaySongView> createState() => _PlaySongViewState();
}

class _PlaySongViewState extends State<PlaySongView> {
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
  late int currentSoundNumber;
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    currentSoundNumber = widget.soundNumber;
    player = widget.player;
  }

  Future<void> loadAudio() async {
    try {
      await player
          .setAsset('Assets/Audios/${musicNames[currentSoundNumber]}.mp3');
      await player.play();
    } catch (e) {
      showSnackBar(
        'Failed to load audio: ${musicNames[currentSoundNumber]}',
        error: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: 'Music',
        onTap: () {
          RouteUtils.pop();
          player.pause();
        },
      ),
      body: Column(
        children: [
          Image.asset(
            'Assets/Images/playing.png',
            height: 561.8.h,
            width: 359.14.w,
          ),
          Center(
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: AppColors.primaryG,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ).createShader(bounds),
              child: AppText(
                title: musicNames[currentSoundNumber],
                fontSize: 24,
                fontWeight: FontWeight.w500,
                fontFamily: "Roboto",
                color: Colors.white,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppImageButton(
                    imagePath: "Assets/Images/prev.png",
                    onPressed: () {
                      if (currentSoundNumber > 0) {
                        setState(() {
                          currentSoundNumber--;
                        });
                        loadAudio();
                      }
                    },
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppImageButton(
                    imagePath: player.playing
                        ? "Assets/Images/pause.png"
                        : "Assets/Images/Play.png",
                    onPressed: () {
                      if (player.playing) {
                        player.pause();
                      } else {
                        loadAudio();
                      }
                      setState(() {});
                    },
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppImageButton(
                    imagePath: "Assets/Images/next.png",
                    onPressed: () {
                      if (currentSoundNumber < musicNames.length - 1) {
                        setState(() {
                          currentSoundNumber++;
                        });
                        loadAudio();
                      }
                    },
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
