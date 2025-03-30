import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import '../../Widgets/app_button.dart';

class VoiceView extends StatefulWidget {
  const VoiceView({super.key});

  @override
  State<VoiceView> createState() => _VoiceViewState();
}

class _VoiceViewState extends State<VoiceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppText(
              title: "Empty Voices!",
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
            SizedBox(
              height: 50.h,
            ),
            AppButton(
              width: 227.w,
              height: 50.86.h,
              title: "Add Voice",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
