import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Music/Voice.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Music/playlist_view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/main_app_bar.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/secondary_app_bar.dart';
import '../../Core/route_utils/route_utils.dart';

class MusicView extends StatefulWidget {
  const MusicView({super.key});

  @override
  State<MusicView> createState() => _MusicViewState();
}

class _MusicViewState extends State<MusicView> {
  bool isPlaylist = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const MainAppBar(
        title: "Music",
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 26.h,
          right: 24.w,
          left: 24.w,
        ),
        child: Center(
          child: Column(
            children: [
              AnimatedToggleSwitch<bool>.size(
                current: isPlaylist,
                values: const [true, false],
                iconOpacity: 0.2,
                indicatorSize: Size.fromWidth(173.w),
                height: 56,
                onChanged: (value) => setState(() => isPlaylist = value),
                customIconBuilder: (context, local, global) => AppText(
                  title: local.value ? 'Playlist' : 'Voice',
                  color: Color.lerp(
                    AppColors.black,
                    AppColors.white,
                    local.animationValue,
                  ),
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                ),
                borderWidth: 0,
                iconAnimationType: AnimationType.onHover,
                style: ToggleStyle(
                  indicatorGradient: LinearGradient(
                    colors: AppColors.primaryG,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  backgroundColor: const Color(0xFFE1E1E1,),
                ),
                selectedIconScale: 1.0,
              ),
              const SizedBox(height: 45),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: isPlaylist ? const PlaylistView() : const VoiceView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
