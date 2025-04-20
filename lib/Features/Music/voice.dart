import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_img_button.dart';

class VoiceView extends StatefulWidget {
  const VoiceView({super.key});

  @override
  State<VoiceView> createState() => _VoiceViewState();
}

class _VoiceViewState extends State<VoiceView> {
  int mediaNumb = 0;
  List<String> audioPaths = [];
  late SharedPreferences prefs;
  final AudioPlayer player = AudioPlayer();

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
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String? path = result.files.single.path;
      if (path != null) {
        // Copy to app directory
        Directory appDir = await getApplicationDocumentsDirectory();
        String fileName = path.split('/').last;
        File newFile = await File(path).copy('${appDir.path}/$fileName');

        // Save path
        audioPaths.add(newFile.path);
        await prefs.setStringList('audioPaths', audioPaths);

        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void playAudio(String path) async {
    await player.setFilePath(path);
    if (player.playing) {
      player.pause();
    } else {
      player.play();
      mediaNumb = audioPaths.indexOf(path);
    }
  }

  Future<void> deleteAudio(int index) async {
    try {
      File file = File(audioPaths[index]);
      if (await file.exists()) {
        await file.delete(); // Delete from storage
      }

      audioPaths.removeAt(index); // Remove from list
      await prefs.setStringList(
          'audioPaths', audioPaths); // Update shared prefs

      setState(() {}); // Refresh UI
    } catch (e) {
      print("Delete error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to delete audio.")),
      );
    }
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
                      children: [
                        const AppText(
                          title: "Empty voices!",
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto",
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
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
                              title: Text(name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Roboto",
                                      color: Colors.white)),
                              onTap: () {
                                playAudio(path);
                                showMusicBottomSheet(index);
                              },
                              trailing: IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.white),
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
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  void showMusicBottomSheet(int currentIndex) {
    String path = audioPaths[currentIndex];
    String name = path.split('/').last;
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
                      name,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto",
                          color: Colors.white),
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
                          ? "Assets/Images/play.png"
                          : "Assets/Images/puase.png",
                      onPressed: () {
                        if (player.playing) {
                          currentIndex = mediaNumb;
                        }
                        playAudio(audioPaths[currentIndex]);
                        setState(() {}); // StateSetter
                      },
                    ),
                  )),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
