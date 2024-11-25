import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Core/app_colors/app_colors.dart';
import 'app_text.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.title,
    this.actions,
    this.enableBackButton = false,
    this.profileIcon,
    this.notificationIcon,
  });

  final String title;
  final List<Widget>? actions;
  final bool enableBackButton;
  final String? profileIcon;
  final String? notificationIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            title: title,
            fontSize: 32,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          if (profileIcon != null && notificationIcon != null)
          Row(
            children: [
              InkWell(
                child: Image.asset(
                  notificationIcon!,
                  height: 26.h,
                  width: 24.w,
                ),
              ),
              SizedBox(width: 16.w),
              InkWell(
                child: Image.asset(
                  profileIcon!,
                  height: 25.h,
                  width: 25.w,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
