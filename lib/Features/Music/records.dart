import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Core/route_utils/route_utils.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Music/play_record.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/snack_bar.dart';
import '../../Widgets/app_button.dart';

class RecordsView extends StatefulWidget {
  const RecordsView({super.key});

  @override
  State<RecordsView> createState() => _RecordsViewState();
}

class _RecordsViewState extends State<RecordsView> {
  List<String> audioPaths = [];
  late SharedPreferences prefs;
  final AudioPlayer player = AudioPlayer();
  DateTime? _lastTapTime;

  @override
  void initState() {
    super.initState();
    loadAudios();
  }

  Future<void> loadAudios() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      audioPaths = prefs.getStringList('audioPaths') ?? [];
    });
  }

  Future<void> pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (result != null) {
      String? path = result.files.single.path;
      if (path != null) {
        try {
          Directory appDir = await getApplicationDocumentsDirectory();
          String fileName = path.split('/').last;
          File newFile = await File(path).copy('${appDir.path}/$fileName');
          audioPaths.add(newFile.path);
          await prefs.setStringList('audioPaths', audioPaths);
          if (mounted) {
            setState(() {});
          }
        } catch (e) {
          if (mounted) {
            showSnackBar('Failed to add audio', error: true);
          }
        }
      }
    }
  }

  Future<void> handleTap(String path, int index) async {
    final now = DateTime.now();
    if (_lastTapTime != null &&
        now.difference(_lastTapTime!) < const Duration(milliseconds: 500)) {
      return;
    }
    _lastTapTime = now;

    if (player.playing) {
      await player.pause();
    }
    if (mounted) {
      RouteUtils.push(PlayRecordView(
        audioPaths: audioPaths,
        currentIndex: index,
        player: player,
      ),);
    }

    try {
      await player.setFilePath(path);
      await player.play();
    } catch (e) {
      // if (mounted) {
      //   showSnackBar('Failed to load audio: ${path.split('/').last}',
      //       error: true);
      // }
      print(e);
    }
  }

  Future<void> deleteAudio(int index) async {
    try {
      File file = File(audioPaths[index]);
      if (await file.exists()) {
        await file.delete();
      }

      audioPaths.removeAt(index);
      await prefs.setStringList('audioPaths', audioPaths);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        showSnackBar('Failed to delete audio', error: true);
      }
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: audioPaths.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppText(
                          title: "Empty voices!",
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto",
                        ),
                        SizedBox(height: 18.h),
                        const AppText(
                          title: "Add your voice or a song you prefer",
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: audioPaths.length,
                      itemBuilder: (context, index) {
                        String path = audioPaths[index];
                        String name = path.split('/').last;
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 8.h),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: AppColors.primaryG,
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: AppText(
                                title: name,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto",
                                color: Colors.white,
                              ),
                              onTap: () => handleTap(path, index),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColors.white,
                                ),
                                onPressed: () => deleteAudio(index),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppButton(
                width: 227.w,
                height: 50.86.h,
                title: "Add Voice",
                onPressed: pickAudio,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
