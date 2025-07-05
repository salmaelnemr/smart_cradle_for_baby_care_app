import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_img_button.dart';
import '../../Widgets/app_text.dart';
import '../../Widgets/secondary_app_bar.dart';
import '../../Widgets/snack_bar.dart';

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
  StreamSubscription<bool>? _playingSubscription;
  StreamSubscription<ProcessingState>? _processingSubscription;
  DateTime? _lastPopTime;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    player = widget.player;
    _playingSubscription = player.playingStream
        .debounceTime(const Duration(milliseconds: 100))
        .listen((playing) {
      if (mounted) setState(() {});
    });
    _processingSubscription = player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed &&
          currentIndex < widget.audioPaths.length - 1) {
        if (mounted) nextTrack();
      }
    });
    _setCurrentFilePath();
  }

  Future<void> _setCurrentFilePath() async {
    try {
      await player.stop();
      await player.setFilePath(widget.audioPaths[currentIndex]);
      await player.play();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        showSnackBar('Failed to delete audio', error: true);
      }
    }
  }

  void playPause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
    if (mounted) {
      setState(() {});
    }
  }

  void nextTrack() async {
    if (currentIndex < widget.audioPaths.length - 1) {
      currentIndex++;
      await _setCurrentFilePath();
    }
  }

  void previousTrack() async {
    if (currentIndex > 0) {
      currentIndex--;
      await _setCurrentFilePath();
    }
  }

  void handlePop() {
    final now = DateTime.now();
    if (_lastPopTime != null &&
        now.difference(_lastPopTime!) < const Duration(milliseconds: 500)) {
      return;
    }
    _lastPopTime = now;
    player.pause();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _playingSubscription?.cancel();
    _processingSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String name = widget.audioPaths[currentIndex].split('/').last;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: 'Music',
        onTap: handlePop,
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              'Assets/Images/playing.png',
              height: 561.h,
              width: 359.w,
              fit: BoxFit.contain,
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
                    onPressed: currentIndex > 0 ? previousTrack : () {},
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
                    onPressed: playPause,
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
                    onPressed: currentIndex < widget.audioPaths.length - 1
                        ? nextTrack
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
