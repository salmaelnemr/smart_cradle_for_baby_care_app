import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Rocking%20Guidelines/activate_rocking.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/main_app_bar.dart';

class MonitorView extends StatefulWidget {
  const MonitorView({super.key});

  @override
  State<MonitorView> createState() => _MonitorViewState();
}

class _MonitorViewState extends State<MonitorView> {

  bool isPopupNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const MainAppBar(
        title: 'Monitor',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 541.h,
                width: 345.w,
                decoration: BoxDecoration(
                  color: AppColors.pinkLight,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 15.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,),
              child: InkWell(
                onTap: () {
                  RouteUtils.push(
                    const ActivateRockingView(),
                  );
                },
                child: Row(
                  children: [
                    Image.asset(
                      'Assets/Images/infoIcon.png',
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(width: 5.w,),
                    const AppText(
                      title: "When to rock the cradle?",
                      textAlign: TextAlign.center,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                      color: AppColors.black,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 14.h,),
            Container(
              width: 345.w,
              height: 48.h,
              padding: const EdgeInsets.only(
                right: 12,
                left: 14,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const AppText(
                    title: "Soothing",
                    textAlign: TextAlign.center,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto",
                    color: AppColors.black,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: (){
                      isPopupNotificationsEnabled = true;
                    },
                    child: CupertinoSwitch(
                      value: isPopupNotificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          isPopupNotificationsEnabled = value;
                        });
                      },
                      activeColor: const Color(0xFF55C76C),
                    ),
                  ),
                ],
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       height: 47.h,
            //       width: 47.w,
            //       decoration: BoxDecoration(
            //         gradient: LinearGradient(
            //           colors: AppColors.primaryG,
            //           begin: Alignment.bottomCenter,
            //           end: Alignment.topCenter,
            //         ),
            //         borderRadius: BorderRadius.circular(50),
            //       ),
            //       child: Container(
            //         width: 44.w,
            //         height: 44.h,
            //         padding: const EdgeInsets.all(10),
            //         margin: const EdgeInsets.all(1.4),
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(50),
            //         ),
            //         child: Image.asset(
            //           "Assets/Images/music.png",
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: 24.w,),
            //     Container(
            //       height: 47.h,
            //       width: 47.w,
            //       decoration: BoxDecoration(
            //         gradient: LinearGradient(
            //           colors: AppColors.primaryG,
            //           begin: Alignment.bottomCenter,
            //           end: Alignment.topCenter,
            //         ),
            //         borderRadius: BorderRadius.circular(50),
            //       ),
            //       child: Container(
            //         width: 44.w,
            //         height: 44.h,
            //         padding: const EdgeInsets.all(10),
            //         margin: const EdgeInsets.all(1.4),
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(50),
            //         ),
            //         child: Center(
            //           child: Image.asset(
            //             "Assets/Images/crib.png",
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
