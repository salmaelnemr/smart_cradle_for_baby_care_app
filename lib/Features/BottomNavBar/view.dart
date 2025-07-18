import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Music/view.dart';
import '../../Core/app_colors/app_colors.dart';
import '../Chat Bot/view.dart';
import '../Home/view.dart';
import '../Monitor/view.dart';
import '../Schedule/view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeView(),
    const MusicView(),
    const MonitorView(),
    const ScheduleView(),
    const ChatBotView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.pinkLight,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('Assets/Images/homeIcon.png', 0),
            _buildNavItem('Assets/Images/musicIcon.png', 1),
            _buildNavItem('Assets/Images/videoIcon.png', 2),
            _buildNavItem('Assets/Images/scheduleIcon.png', 3),
            _buildNavItem('Assets/Images/chatIcon.png', 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String imagePath, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return isSelected
                  ? LinearGradient(
                colors: AppColors.primaryG,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds)
                  : const LinearGradient(
                colors: [AppColors.greyLight, AppColors.greyLight],
              ).createShader(bounds);
            },
            child: Image.asset(
              imagePath,
              width: 24.w,
              height: 24.h,
              color: AppColors.white2,
            ),
          ),
          if (isSelected)
            Container(
              margin: EdgeInsets.only(top: 4.h),
              width: 49.w,
              height: 5.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.primaryG,
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
        ],
      ),
    );
  }
}
