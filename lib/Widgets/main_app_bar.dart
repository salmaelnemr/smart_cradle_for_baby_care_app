import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Notification/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Profile/view.dart';
import '../Core/app_colors/app_colors.dart';
import '../Core/route_utils/route_utils.dart';
import 'app_text.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.title,
    this.actions,
    this.enableBackButton = false,
    this.profileIcon,
    this.notificationIcon,
    this.appName,
  });

  final String? title;
  final List<Widget>? actions;
  final bool enableBackButton;
  final String? profileIcon;
  final String? notificationIcon;
  final String? appName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (appName != null)
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: AppColors.primaryG,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ).createShader(bounds),
            child: AppText(
              title: appName!,
              fontSize: 32,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
            ),
          ),
          if (title != null)
          AppText(
            title: title!,
            fontSize: 32,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          if (profileIcon != null && notificationIcon != null)
          Row(
            children: [
              InkWell(
                onTap: (){
                  RouteUtils.push(
                    const NotificationView(),
                  );
                },
                child: Image.asset(
                  notificationIcon!,
                  height: 26.h,
                  width: 24.w,
                ),
              ),
              SizedBox(width: 16.w),
              InkWell(
                onTap: (){
                  RouteUtils.push(
                      const ProfileView(),
                  );
                },
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
