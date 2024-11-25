import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/secondary_app_bar.dart';
import '../Monitor/view.dart';
import '../Relaxation/view.dart';


class RockingEndView extends StatefulWidget {
  const RockingEndView({super.key});

  @override
  State<RockingEndView> createState() => _RockingEndViewState();
}

class _RockingEndViewState extends State<RockingEndView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: "Rocking",
        onTap:  (){
          RouteUtils.pushAndPopAll(
             const RelaxationView(),
          );
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 197.h,
        ),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                "Assets/Images/bigCrib.png",
                height: 131.4.h,
                width: 174.w,
              ),
              SizedBox(
                height: 146.6.h,
              ),
              AppButton(
                width: 278.w,
                height: 50.86.h,
                title: "Go to camera ",
                onPressed: (){
                  RouteUtils.push(
                    const MonitorView(),
                  );
                },
              ),
              SizedBox(
                height: 19.14.h,
              ),
              AppButton(
                width: 278.w,
                height: 50.86.h,
                title: "Stop",
                onPressed: (){
                  // RouteUtils.push(
                  //   const HomeView(),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
