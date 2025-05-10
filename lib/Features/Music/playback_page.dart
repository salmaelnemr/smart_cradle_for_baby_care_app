import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_img_button.dart';

import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/secondary_app_bar.dart';

class PlaybackPage extends StatefulWidget {
  final int soundNumber;
  final AudioPlayer player;

  const PlaybackPage({super.key, required this.soundNumber, required this.player});

  @override
  State<PlaybackPage> createState() => _PlaybackPageState();
}

class _PlaybackPageState extends State<PlaybackPage> {
  late int currentSoundNumber;
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    currentSoundNumber = widget.soundNumber;
    player = widget.player;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: 'Now Playing: ${musicNames[currentSoundNumber]}',
        onTap: () {
          RouteUtils.pop();
          player.pause();

        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.asset('Assets/Images/playing.png'),
          ),
          Center(
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: AppColors.primaryG,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
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
                child: AppImageButton(
                  imagePath: "Assets/Images/prev.png",
                  onPressed: () {
                    if (currentSoundNumber > 0) {
                      setState(() {
                        currentSoundNumber--;
                      });
                      player.setAsset('Assets/Audios/$currentSoundNumber.mp3');
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppImageButton(
                  imagePath: player.playing ? "Assets/Images/pause.png" : "Assets/Images/play.png",
                  onPressed: () {
                    if (player.playing) {
                      player.pause();
                    } else {
                      player.play();
                    }
                    setState(() {});
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppImageButton(
                  imagePath: "Assets/Images/next.png",
                  onPressed: () {
                    if (currentSoundNumber < musicNames.length - 1) {
                      setState(() {
                        currentSoundNumber++;
                      });
                      player.setAsset('Assets/Audios/$currentSoundNumber.mp3');
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<String> musicNames = [
    'Fire', 'Rain', 'Woods', 'Waves', 'Bus', 'Car', 'Plane', 'Train',
    'Washing', 'Blow dryer', 'Radio', 'Clock', 'Note1', 'Note2', 'Note3'
  ];
}
