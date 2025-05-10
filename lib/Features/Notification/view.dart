import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
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

      notifications.sort((a, b) => DateTime.parse(b['timestamp']).compareTo(DateTime.parse(a['timestamp'])));
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
                        Expanded(
                          child: AppText(
                            title: notification["body"],
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto",
                            fontSize: 16.sp,
                            color: AppColors.black,
                          ),
                        ),
                        AppText(
                          title: _formatTime(
                              DateTime.parse(notification["timestamp"])),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontSize: 16.sp,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  );
                }),
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
      final String? timeString = notification['timestamp'];

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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final dateFormat = DateFormat('d MMMM');
    final formattedDayMonth = dateFormat.format(date);

    if (DateUtils.isSameDay(date, now)) {
      return "Today, $formattedDayMonth";
    } else if (DateUtils.isSameDay(date, now.subtract(const Duration(days: 1)))) {
      return "Yesterday, $formattedDayMonth";
    } else {
      final dayOfWeek = DateFormat('EEEE').format(date);
      return "$dayOfWeek, $formattedDayMonth";
    }
  }

  String _formatTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return "$hour:$minute $period";
  }
}
