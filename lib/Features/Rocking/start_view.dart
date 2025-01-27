import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Rocking%20Guidelines/activate_rocking.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Rocking/end_view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/secondary_app_bar.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_button.dart';

class RockingStartView extends StatefulWidget {
  const RockingStartView({super.key});

  @override
  State<RockingStartView> createState() => _RockingStartViewState();
}

class _RockingStartViewState extends State<RockingStartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: "Rocking",
        onTap:  (){
          RouteUtils.pop();
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
                height: 104.6.h,
              ),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: AppColors.primaryG,
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ).createShader(bounds),
                child: InkWell(
                  onTap: (){
                    RouteUtils.push(
                      const ActivateRockingView(),
                    );
                  },
                  child: const AppText(
                    title: "When to rocking?",
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              AppButton(
                width: 278.w,
                height: 50.86.h,
                title: "Start",
                onPressed: (){
                  RouteUtils.push(
                    const RockingEndView(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
