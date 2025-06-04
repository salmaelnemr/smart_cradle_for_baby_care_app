import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_img_button.dart';
import '../../Widgets/app_text.dart';
import '../../Widgets/secondary_app_bar.dart';
import '../../Core/route_utils/route_utils.dart';

class PlayRecordView extends StatefulWidget {
  final List<String> audioPaths;
  final int currentIndex;
  final AudioPlayer player;

  const PlayRecordView({
    super.key,
    required this.audioPaths,
    required this.currentIndex,
    required this.player,
  });

  @override
  State<PlayRecordView> createState() => _PlayRecordViewState();
}

class _PlayRecordViewState extends State<PlayRecordView> {
  late int currentIndex;
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    player = widget.player;
    _setCurrentFile();
  }

  Future<void> _setCurrentFile() async {
    await player.setFilePath(widget.audioPaths[currentIndex]);
    player.play();
    setState(() {});
  }

  void playPause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
    setState(() {});
  }

  void nextTrack() async {
    if (currentIndex < widget.audioPaths.length - 1) {
      currentIndex++;
      await player.setFilePath(widget.audioPaths[currentIndex]);
      player.play();
      setState(() {});
    }
  }

  void previousTrack() async {
    if (currentIndex > 0) {
      currentIndex--;
      await player.setFilePath(widget.audioPaths[currentIndex]);
      player.play();
      setState(() {});
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String name = widget.audioPaths[currentIndex].split('/').last;
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
          Expanded(
            child: Image.asset(
              'Assets/Images/playing.png',
            ),
          ),
          Center(
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: AppColors.primaryG,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ).createShader(bounds),
              child: AppText(
                title: name,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppImageButton(
                  imagePath: "Assets/Images/prev.png",
                  onPressed: previousTrack,
                  height: 20.h,
                  width: 20.w,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppImageButton(
                  imagePath: player.playing
                      ? "Assets/Images/pause.png"
                      : "Assets/Images/Play.png",
                  onPressed: playPause,
                  height: 20.h,
                  width: 20.w,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppImageButton(
                  imagePath: "Assets/Images/next.png",
                  onPressed: nextTrack,
                  height: 20.h,
                  width: 20.w,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
