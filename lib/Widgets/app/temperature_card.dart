import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import '../../Core/app_colors/app_colors.dart';
import '../app_text.dart';

class TemperatureCard extends StatelessWidget {
  final List temperatureDegree;
  final String imgTitle;
  final String title;
  final String status;
  //final Color color;
  final String degree;

  const TemperatureCard({
    super.key,
    required this.temperatureDegree,
    required this.imgTitle,
    required this.status,
    required this.title,
    //required this.color,
    required this.degree,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 247.h,
      padding: EdgeInsets.only(
        top: 7.h,
        left: 4.w,
        right: 2.w,
        bottom: 15.h
      ),
      decoration: BoxDecoration(
        color: AppColors.white2,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            title: title,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.black,
          ),
          AppText(
            title: status,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: AppColors.greyLight,
          ),
          SizedBox(
            height: 15.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 17.w,
              ),
              SimpleAnimationProgressBar(
                height: 157.h,
                width: 34.w,
                backgroundColor: const Color(0xFFF6D2D3),
                foregrondColor: Colors.purple,
                ratio: 0.5,
                direction: Axis.vertical,
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(seconds: 3),
                borderRadius: BorderRadius.circular(35),
                gradientColor: LinearGradient(
                    colors: AppColors.primaryG,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imgTitle,
                    height: 64.14.h,
                    width: 52.71.w,
                  ),
                  SizedBox(height: 10.86.h,),
                  AppText(
                    title: degree,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: AppColors.black,
                  ),
                ],
              ),
              // SizedBox(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: temperatureDegree.map((wObj) {
              //       var isLast = wObj == temperatureDegree.last;
              //       return Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           Column(
              //             children: [
              //               Container(
              //                 width: 7,
              //                 height: 7,
              //                 decoration: BoxDecoration(
              //                   gradient: LinearGradient(
              //                     colors: AppColors.primaryG,
              //                     begin: Alignment.bottomCenter,
              //                     end: Alignment.topCenter,
              //                   ),
              //                   borderRadius: BorderRadius.circular(5),
              //                 ),
              //               ),
              //               if (!isLast)
              //                 DottedDashedLine(
              //                   height: 32.h,
              //                   width: 0,
              //                   dashColor: AppColors.black,
              //                   axis: Axis.vertical,
              //                 ),
              //             ],
              //           ),
              //           SizedBox(
              //             width: 7.5.w,
              //           ),
              //           Column(
              //             children: [
              //               AppText(
              //                 title: wObj["title"].toString(),
              //                 color: AppColors.black,
              //                 fontFamily: "Roboto",
              //                 fontSize: 13,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ],
              //           )
              //         ],
              //       );
              //     }).toList(),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
