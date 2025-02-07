import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Music/Voice.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Music/playlist_view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/secondary_app_bar.dart';
import '../../Core/route_utils/route_utils.dart';

class MusicView extends StatefulWidget {
  const MusicView({super.key});

  @override
  State<MusicView> createState() => _MusicViewState();
}

class _MusicViewState extends State<MusicView> {
  bool isPlaylist = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: "Music",
        onTap: () {
          RouteUtils.pop();
        },
      ),
      body: Center(
        child: Column(
          children: [
            AnimatedToggleSwitch<bool>.size(
              current: isPlaylist,
              values: const [false, true],
              iconOpacity: 0.2,
              indicatorSize: const Size.fromWidth(150),
              height: 40,
              onChanged: (value) => setState(() => isPlaylist = value),
              customIconBuilder: (context, local, global) => Text(
                local.value ? 'Voice' : 'Playlist',
                style: TextStyle(
                    color: Color.lerp(
                        Colors.black, Colors.white, local.animationValue),
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto"),
              ),
              borderWidth: 0,
              iconAnimationType: AnimationType.onHover,
              style: ToggleStyle(
                  indicatorGradient: LinearGradient(
                    colors: AppColors.primaryG,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  backgroundColor:  Colors.grey[300],
                  borderColor: Colors.transparent,
                  ),
              selectedIconScale: 1.0,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isPlaylist ? const VoiceView() : const PlaylistView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
