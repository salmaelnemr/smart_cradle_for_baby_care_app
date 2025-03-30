import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_img_button.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({super.key});

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.only(right: 24.w, left: 21.w,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText(
              title: "Nature",
              fontSize: 24,
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
              color: AppColors.black,
            ),
            SizedBox(height: 20.h,),
            Row(
              children: [
                AppImageButton(
                    imagePath: "Assets/Images/Fire.png", onPressed: numOne),
                SizedBox(width: 14.w,),
                AppImageButton(
                    imagePath: "Assets/Images/Rain.png", onPressed: numOne),
                SizedBox(width: 14.w,),
                AppImageButton(
                    imagePath: "Assets/Images/Woods.png", onPressed: numOne),
                SizedBox(width: 14.w,),
                AppImageButton(
                    imagePath: "Assets/Images/Waves.png", onPressed: numOne),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: const AppText(
                title: "Transport",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 20.h,),
            Row(
              children: [
                AppImageButton(
                    imagePath: "Assets/Images/Bus.png", onPressed: numOne),
                SizedBox(width: 14.w,),
                AppImageButton(
                    imagePath: "Assets/Images/Car.png", onPressed: numOne),
                SizedBox(width: 14.w,),
                AppImageButton(
                    imagePath: "Assets/Images/Plane.png", onPressed: numOne),
                SizedBox(width: 14.w,),
                AppImageButton(
                    imagePath: "Assets/Images/Train.png", onPressed: numOne),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h,),
              child: const AppText(
                title: "House",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 20.h,),
            Row(
              children: [
                AppImageButton(
                    imagePath: "Assets/Images/Washing.png", onPressed: numOne),
                SizedBox(width: 14.w,),
                AppImageButton(
                    imagePath: "Assets/Images/BlowDryer.png",
                    onPressed: numOne),
                SizedBox(width: 14.w,),
                AppImageButton(
                    imagePath: "Assets/Images/Radio.png", onPressed: numOne),
                SizedBox(width: 14.w,),
                AppImageButton(
                    imagePath: "Assets/Images/Clock.png", onPressed: numOne),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h,),
              child: const AppText(
                title: "White Noise",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 20.h,),
            Row(
              children: [
                AppImageButton(
                    imagePath: "Assets/Images/Note1.png", onPressed: numOne),
                SizedBox(width: 14.w,),
                AppImageButton(
                    imagePath: "Assets/Images/Note2.png", onPressed: numOne),
                SizedBox(width: 14.w,),
                AppImageButton(
                    imagePath: "Assets/Images/Note3.png", onPressed: numOne),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void numOne() {
    print('1');
  }
}
