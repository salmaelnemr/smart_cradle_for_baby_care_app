// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../Core/app_colors/app_colors.dart';
// import '../../Core/route_utils/route_utils.dart';
// import '../../Widgets/app_text.dart';
// import '../../Widgets/secondary_app_bar.dart';
//
// class NotificationView extends StatelessWidget {
//   const NotificationView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final notifications = {
//       "Today, 5 July": [
//         {"title": "Cradle is rocking", "time": "6:22 PM"},
//         {"title": "Baby is crying", "time": "6:10 PM"},
//         {"title": "Baby's position is wrong", "time": "5:00 PM"},
//         {"title": "Baby's temperature is high", "time": "3:40 PM"},
//         {"title": "You need to change diaper", "time": "3:20 PM"},
//         {"title": "Feeding time", "time": "12:05 PM"},
//         {"title": "Baby is awake", "time": "12:00 PM"},
//       ],
//       "Yesterday, 4 July": [
//         {"title": "Baby has been placed in cradle", "time": "12:05 AM"},
//         {"title": "Shower time", "time": "11:00 PM"},
//         {"title": "Cradle is rocking", "time": "9:50 PM"},
//       ],
//     };
//
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: SecondaryAppBar(
//         title: "Notifications",
//         onTap: () {
//           RouteUtils.pop();
//         },
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h,),
//         child: ListView.builder(
//           itemCount: notifications.keys.length,
//           itemBuilder: (context, index) {
//             String date = notifications.keys.elementAt(index);
//             List<Map<String, String>> dailyNotifications = notifications[date]!;
//
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 AppText(
//                   title: date,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: "Roboto",
//                   fontSize: 16.sp,
//                   color: AppColors.black,
//                 ),
//                 SizedBox(height: 8.h),
//                 ...dailyNotifications.map((notification) {
//                   return Container(
//                     margin: EdgeInsets.only(bottom: 18.14.h),
//                     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
//                     decoration: BoxDecoration(
//                       color: AppColors.pinkLight,
//                       borderRadius: BorderRadius.circular(10.r),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         AppText(
//                           title: notification["title"]!,
//                           fontWeight: FontWeight.w400,
//                           fontFamily: "Roboto",
//                           fontSize: 16.sp,
//                           color: AppColors.black,
//                         ),
//                         AppText(
//                           title: notification["time"]!,
//                           fontWeight: FontWeight.w400,
//                           fontFamily: "Roboto",
//                           fontSize: 16.sp,
//                           color: AppColors.black,
//                         ),
//                       ],
//                     ),
//                   );
//                 },),
//                 SizedBox(height: 18.14.h),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_text.dart';
import '../../Widgets/secondary_app_bar.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> storedData = prefs.getStringList('notifications') ?? [];

    setState(() {
      notifications = storedData
          .map((notify) => jsonDecode(notify) as Map<String, dynamic>)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final groupedNotifications = _groupByDate(notifications);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: "Notifications",
        onTap: () {
          RouteUtils.pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: notifications.isEmpty
            ? const Center(child: AppText(title: "No Notifications"))
            : ListView.builder(
                itemCount: groupedNotifications.keys.length,
                itemBuilder: (context, index) {
                  String date = groupedNotifications.keys.elementAt(index);
                  List<Map<String, dynamic>> dailyNotifications =
                      groupedNotifications[date]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        title: date,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Roboto",
                        fontSize: 16.sp,
                        color: AppColors.black,
                      ),
                      SizedBox(height: 8.h),
                      ...dailyNotifications.map((notification) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 18.14.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: AppColors.pinkLight,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                title: notification["title"],
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                                fontSize: 16.sp,
                                color: AppColors.black,
                              ),
                              AppText(
                                title: _formatTime(
                                    DateTime.parse(notification["time"])),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                                fontSize: 16.sp,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      SizedBox(height: 18.14.h),
                    ],
                  );
                },
              ),
      ),
    );
  }

  Map<String, List<Map<String, dynamic>>> _groupByDate(
      List<Map<String, dynamic>> notifications) {
    final Map<String, List<Map<String, dynamic>>> grouped = {};

    for (var notification in notifications) {
      final String? timeString = notification['time'];

      if (timeString == null || timeString.isEmpty) {
        continue;
      }

      final date = DateTime.tryParse(timeString);
      if (date == null) {
        continue;
      }

      final formattedDate = _formatDate(date);

      if (grouped.containsKey(formattedDate)) {
        grouped[formattedDate]!.add(notification);
      } else {
        grouped[formattedDate] = [notification];
      }
    }

    return grouped;
  }

  // Map<String, List<Map<String, dynamic>>> _groupByDate(
  //     List<Map<String, dynamic>> notifications) {
  //   final Map<String, List<Map<String, dynamic>>> grouped = {};
  //
  //   for (var notification in notifications) {
  //     final date = DateTime.parse(notification['time']).toLocal();
  //     final formattedDate = _formatDate(date);
  //
  //     if (grouped.containsKey(formattedDate)) {
  //       grouped[formattedDate]!.add(notification);
  //     } else {
  //       grouped[formattedDate] = [notification];
  //     }
  //   }
  //
  //   return grouped;
  // }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (DateUtils.isSameDay(date, now)) {
      return "Today, ${_formatDay(date)}";
    } else if (DateUtils.isSameDay(
        date, now.subtract(const Duration(days: 1)))) {
      return "Yesterday, ${_formatDay(date)}";
    } else {
      return "${_dayOfWeek(date)}, ${_formatDay(date)}";
    }
  }

  String _formatTime(DateTime date) {
    return "${date.hour % 12 == 0 ? 12 : date.hour % 12}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'PM' : 'AM'}";
  }

  String _dayOfWeek(DateTime date) {
    return [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
    ][date.weekday - 1];
  }

  String _formatDay(DateTime date) {
    return "${date.day} ${[
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ][date.month - 1]}";
  }
}
