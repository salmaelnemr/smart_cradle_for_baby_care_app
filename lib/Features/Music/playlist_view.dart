import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_img_button.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({super.key});

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: AppColors.primaryColor2,
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Song Info
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Play sound",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Media Controls
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.skip_previous, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.play_arrow, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Nature',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto"),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                AppImageButton(
                    imagePath: "Assets/Images/Fire.png", onPressed: numOne),
                AppImageButton(
                    imagePath: "Assets/Images/Rain.png", onPressed: numOne),
                AppImageButton(
                    imagePath: "Assets/Images/Woods.png", onPressed: numOne),
                AppImageButton(
                    imagePath: "Assets/Images/Waves.png", onPressed: numOne),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Transport',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto"),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                AppImageButton(
                    imagePath: "Assets/Images/Bus.png", onPressed: numOne),
                AppImageButton(
                    imagePath: "Assets/Images/Car.png", onPressed: numOne),
                AppImageButton(
                    imagePath: "Assets/Images/Plane.png", onPressed: numOne),
                AppImageButton(
                    imagePath: "Assets/Images/Train.png", onPressed: numOne),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'House',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto"),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                AppImageButton(
                    imagePath: "Assets/Images/Washing.png", onPressed: numOne),
                AppImageButton(
                    imagePath: "Assets/Images/BlowDryer.png", onPressed: numOne),
                AppImageButton(
                    imagePath: "Assets/Images/Radio.png", onPressed: numOne),
                AppImageButton(
                    imagePath: "Assets/Images/Clock.png", onPressed: numOne),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'White noise',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto"),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                AppImageButton(
                    imagePath: "Assets/Images/Note1.png", onPressed: numOne),
                AppImageButton(
                    imagePath: "Assets/Images/Note2.png", onPressed: numOne),
                AppImageButton(
                    imagePath: "Assets/Images/Note3.png", onPressed: numOne),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void numOne() {
    print('1');
  }
}
