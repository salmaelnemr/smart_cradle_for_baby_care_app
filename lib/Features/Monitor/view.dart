import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Rocking%20Guidelines/activate_rocking.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_loading_indicator.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/snack_bar.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/main_app_bar.dart';

class MonitorView extends StatefulWidget {
  const MonitorView({super.key});

  @override
  State<MonitorView> createState() => _MonitorViewState();
}

class _MonitorViewState extends State<MonitorView> {
  bool isPopupNotificationsEnabled = false;
  final String streamUrl = "http://192.168.21.161:81/stream";
  static const _firebasePath = "motor/control";
  final _databaseRef = FirebaseDatabase.instance.ref(_firebasePath);

  Future<void> _updateFirebase(bool value) async {
    try {
      await _databaseRef.set(value);
    } catch (e) {
      showSnackBar("Failed to update: $e", error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const MainAppBar(
        title: 'Monitor',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 18.h,
            horizontal: 24.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 541.h,
                  width: 345.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
                      SizedBox.expand(
                        child: Mjpeg(
                          isLive: true,
                          stream: streamUrl,
                          fit: BoxFit.cover,
                          error: (context, error, stack) {
                            print("MJPEG Error: $error");
                            return const Center(
                              child: AppText(
                                title: 'Error connecting to stream',
                                color: AppColors.black,
                              ),
                            );
                          },
                          loading: (context) => const Center(
                            child: AppLoadingIndicator(),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 28.h,
                        left: 12.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            //color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.circle,
                                size: 9,
                                color: AppColors.green,
                              ),
                              SizedBox(width: 6.w),
                              AppText(
                                title: 'Live',
                                fontWeight: FontWeight.w400,
                                fontSize: 24.sp,
                                fontFamily: "Roboto",
                                color: AppColors.greyLight,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: InkWell(
                  onTap: () {
                    RouteUtils.push(const ActivateRockingView());
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'Assets/Images/infoIcon.png',
                        height: 24.h,
                        width: 24.w,
                      ),
                      SizedBox(width: 5.w),
                      AppText(
                        title: "When to rock the cradle?",
                        textAlign: TextAlign.center,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Container(
                width: 345.w,
                height: 48.h,
                padding: EdgeInsets.only(right: 12.w, left: 14.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(
                      title: "Soothing",
                      textAlign: TextAlign.center,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                      color: AppColors.black,
                    ),
                    const Spacer(),
                    CupertinoSwitch(
                      value: isPopupNotificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          isPopupNotificationsEnabled = value;
                          _updateFirebase(value);
                        });
                      },
                      activeColor: const Color(0xFF55C76C),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



