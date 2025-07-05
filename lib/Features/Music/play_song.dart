import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Core/route_utils/route_utils.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_img_button.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/snack_bar.dart';
import '../../Widgets/app_text.dart';
import '../../Widgets/secondary_app_bar.dart';

class PlaySongView extends StatefulWidget {
  final int soundNumber;
  final AudioPlayer player;
  final List<String> musicNames;

  const PlaySongView({
    super.key,
    required this.soundNumber,
    required this.player,
    required this.musicNames,
  });

  @override
  State<PlaySongView> createState() => _PlaySongViewState();
}

class _PlaySongViewState extends State<PlaySongView> {
  late int currentSoundNumber;
  late AudioPlayer player;
  StreamSubscription<bool>? _playingSubscription;
  StreamSubscription<ProcessingState>? _processingSubscription;

  @override
  void initState() {
    super.initState();
    currentSoundNumber = widget.soundNumber;
    player = widget.player;
    _playingSubscription = player.playingStream
        .debounceTime(const Duration(milliseconds: 100))
        .listen((playing) {
      if (mounted) {
        setState(() {});
      }
    });
    _processingSubscription = player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed &&
          currentSoundNumber < widget.musicNames.length - 1) {
        if (mounted) {
          playNext();
        }
      }
    });
    loadAudio();
  }

  Future<void> loadAudio() async {
    try {
      await player.stop();
      await player.setAsset('Assets/Audios/$currentSoundNumber.mp3');
      await player.play();
    } catch (e) {
      if (mounted) {
        showSnackBar(
          'Failed to load audio: $currentSoundNumber.mp3',
          error: true,
        );
      }
    }
  }

  void playPrevious() {
    if (currentSoundNumber > 0) {
      setState(() {
        currentSoundNumber--;
      });
      loadAudio();
    }
  }

  void playNext() {
    if (currentSoundNumber < widget.musicNames.length - 1) {
      setState(() {
        currentSoundNumber++;
      });
      loadAudio();
    }
  }

  void togglePlayPause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
    if (mounted) {
      setState(() {});
    }
  }

  void handlePop() {
    player.pause();
    RouteUtils.pop();
  }

  @override
  void dispose() {
    _playingSubscription?.cancel();
    _processingSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: 'Music',
        onTap: handlePop,
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
                title: widget.musicNames[currentSoundNumber],
                fontSize: 24.sp,
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 8.h,
                  ),
                  child: AppImageButton(
                    imagePath: "Assets/Images/prev.png",
                    onPressed: currentSoundNumber > 0 ? playPrevious : () {},
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 8.h,
                  ),
                  child: AppImageButton(
                    imagePath: player.playing
                        ? "Assets/Images/pause.png"
                        : "Assets/Images/Play.png",
                    onPressed: togglePlayPause,
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 8.h,
                  ),
                  child: AppImageButton(
                    imagePath: "Assets/Images/next.png",
                    onPressed: currentSoundNumber < widget.musicNames.length - 1
                        ? playNext
                        : () {},
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
