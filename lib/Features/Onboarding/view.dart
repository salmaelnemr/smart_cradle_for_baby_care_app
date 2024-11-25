import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/dimensions/dimentions.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Onboarding/second_view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Onboarding/third_view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/WelcomePage/view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app/custom_indicator.dart';
import '../../Widgets/app_button.dart';
import 'first_view.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                controller: _controller,
                children: const [
                  FirstScreen(),
                  SecondScreen(),
                  ThirdScreen(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 61.11.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIndicator(active: index == 0),
                  SizedBox(width: 5.width),
                  CustomIndicator(active: index == 1),
                  SizedBox(width: 5.width),
                  CustomIndicator(active: index == 2),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 81.h,
                bottom: 59.h,
                right: 35.w,
                left: 58.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (index == 2) {
                      } else {
                        index = 1;
                        _controller.animateToPage(index + 1,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.linear);
                      }
                    },
                    child: const AppText(
                      title: "Skip",
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                      color: AppColors.black,
                    ),
                  ),
                  AppButton(
                    width: 136.w,
                    height: 55.h,
                    title: index == 2 ? "Get started" : "Next",
                    onPressed: (){
                      if (index == 2) {
                        RouteUtils.push(
                          const WelcomePageView(),
                        );
                      } else {
                        _controller.animateToPage(index + 1,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.linear);
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
