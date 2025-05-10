import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
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
  final String streamUrl = "http://192.168.1.61"; //'http://192.168.1.100/mjpeg'

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
                    //color: AppColors.pinkLight,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
                      Mjpeg(
                        isLive: true,
                        stream: streamUrl,
                        error: (context, error, stack) {
                          return const Center(
                            child: AppText(
                              title: 'Error connecting to stream',
                              color: AppColors.black,
                            ),
                          );
                        },
                        fit: BoxFit.cover,
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
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.circle,
                                size: 9,
                                color: AppColors.green,
                              ),
                              SizedBox(width: 6.w),
                              const AppText(
                                title: 'Live',
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
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
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
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
                      SizedBox(
                        width: 5.w,
                      ),
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
              SizedBox(
                height: 14.h,
              ),
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
                      onTap: () {
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
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:smart_cradle_for_baby_care_app/Features/Rocking%20Guidelines/activate_rocking.dart';
// import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
// import '../../Core/app_colors/app_colors.dart';
// import '../../Core/route_utils/route_utils.dart';
// import '../../Widgets/main_app_bar.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/services.dart' show Uint8List, rootBundle;
//
// class MonitorView extends StatefulWidget {
//   const MonitorView({super.key});
//
//   @override
//   State<MonitorView> createState() => _MonitorViewState();
// }
//
// class _MonitorViewState extends State<MonitorView> {
//   bool isPopupNotificationsEnabled = true;
//   Uint8List? _imageBytes;
//   String? _analysisResult;
//   bool _isLoadingImage = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadDefaultImage();
//   }
//
//   Future<void> _loadDefaultImage() async {
//     try {
//       final byteData = await rootBundle.load('Assets/Images/safeSleep.jpg');
//       setState(() {
//         _imageBytes = byteData.buffer.asUint8List();
//         _isLoadingImage = false;
//       });
//       print("Image loaded successfully as bytes");
//     } catch (e) {
//       print("Error loading default image: $e");
//       setState(() {
//         _isLoadingImage = false;
//       });
//     }
//   }
//
//   Future<void> _analyzeSleepingPosition() async {
//     if (_isLoadingImage) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please wait, image is still loading")),
//       );
//       return;
//     }
//
//     if (_imageBytes == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("No image available to analyze")),
//       );
//       return;
//     }
//
//     String url = "http://babycradleapp.runasp.net/api/SleepingPosition/analyze";
//     Dio dio = Dio();
//
//     try {
//       FormData formData = FormData.fromMap({
//         "imageFile": MultipartFile.fromBytes(
//           _imageBytes!,
//           filename: "baby_image.jpg",
//         ),
//       });
//
//       Response response = await dio.post(
//         url,
//         data: formData,
//       );
//
//       bool success = response.data["success"];
//       bool isBabySafe = response.data["isBabySafe"];
//
//       String resultMessage;
//       if (success) {
//         resultMessage = isBabySafe
//             ? "The baby is in a safe sleeping position."
//             : "The baby is not in a safe sleeping position.";
//       } else {
//         resultMessage = "Failed to analyze the sleeping position.";
//       }
//
//       setState(() {
//         _analysisResult = resultMessage;
//       });
//
//       print("Analysis result: $resultMessage");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(resultMessage)),
//       );
//     } catch (e) {
//       print("Error analyzing image: $e");
//       setState(() {
//         _analysisResult = "Error occurred while analyzing.";
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Failed to analyze sleeping position")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: const MainAppBar(
//         title: 'Monitor',
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Center(
//                 child: Container(
//                   height: 541.h,
//                   width: 345.w,
//                   decoration: BoxDecoration(
//                     color: AppColors.pinkLight,
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   child: _imageBytes == null
//                       ? Image.asset(
//                     'Assets/Images/safeSleep.jpg',
//                     fit: BoxFit.cover,
//                   )
//                       : Image.memory(
//                     _imageBytes!,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 15.h),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: InkWell(
//                   onTap: () {
//                     RouteUtils.push(
//                       const ActivateRockingView(),
//                     );
//                   },
//                   child: Row(
//                     children: [
//                       Image.asset(
//                         'Assets/Images/infoIcon.png',
//                         height: 24.h,
//                         width: 24.w,
//                       ),
//                       SizedBox(width: 5.w),
//                       const AppText(
//                         title: "When to rock the cradle?",
//                         textAlign: TextAlign.center,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400,
//                         fontFamily: "Roboto",
//                         color: AppColors.black,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 14.h),
//               Container(
//                 width: 345.w,
//                 height: 48.h,
//                 padding: const EdgeInsets.only(right: 12, left: 14),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF0F0F0),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const AppText(
//                       title: "Soothing",
//                       textAlign: TextAlign.center,
//                       fontSize: 22,
//                       fontWeight: FontWeight.w400,
//                       fontFamily: "Roboto",
//                       color: AppColors.black,
//                     ),
//                     const Spacer(),
//                     CupertinoSwitch(
//                       value: isPopupNotificationsEnabled,
//                       onChanged: (value) {
//                         setState(() {
//                           isPopupNotificationsEnabled = value;
//                         });
//                       },
//                       activeColor: const Color(0xFF55C76C),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               ElevatedButton(
//                 onPressed: _analyzeSleepingPosition,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.pinkLight,
//                   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 child: const AppText(
//                   title: "Analyze Sleeping Position",
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: AppColors.black,
//                 ),
//               ),
//               SizedBox(height: 10.h),
//               if (_analysisResult != null)
//                 AppText(
//                   title: _analysisResult!,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                   color: _analysisResult!.contains("not safe")
//                       ? Colors.red
//                       : AppColors.black,
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
