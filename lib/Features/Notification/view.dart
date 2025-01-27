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

//----------------------------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_text.dart';
import '../../Widgets/secondary_app_bar.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<Map<String, String>> notifications = [];

  @override
  void initState() {
    super.initState();

    // استلام إشعار عند فتح التطبيق
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // إضافة الإشعار الجديد إلى القائمة
      setState(() {
        notifications.add({
          'title': message.notification?.title ?? 'No Title',
          'time': DateTime.now().toLocal().toString(),
        });
      });
    });

    // استلام إشعار في الخلفية
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // يمكنك معالجة ما يجب فعله عند النقر على الإشعار
      print("Notification clicked!");
    });
  }

  @override
  Widget build(BuildContext context) {
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
            ? const Center(child: Text("No Notifications"))
            : ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            var notification = notifications[index];
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
                    title: notification["title"]!,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto",
                    fontSize: 16.sp,
                    color: AppColors.black,
                  ),
                  AppText(
                    title: notification["time"]!,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto",
                    fontSize: 16.sp,
                    color: AppColors.black,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

//-----------------------------------------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
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
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: SecondaryAppBar(
//         title: "Notifications",
//         onTap: () {
//           RouteUtils.pop();
//         },
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//         child: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('notifications')
//               .orderBy('time', descending: true) // ترتيب الإشعارات حسب الوقت
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return const Center(child: Text("No Notifications"));
//             }
//
//             // قراءة الإشعارات من Firestore
//             final notifications = snapshot.data!.docs;
//
//             // تجميع الإشعارات حسب التاريخ
//             final groupedNotifications = _groupByDate(notifications);
//
//             return ListView.builder(
//               itemCount: groupedNotifications.keys.length,
//               itemBuilder: (context, index) {
//                 String date = groupedNotifications.keys.elementAt(index);
//                 List<Map<String, dynamic>> dailyNotifications =
//                 groupedNotifications[date]!;
//
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     AppText(
//                       title: date,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: "Roboto",
//                       fontSize: 16.sp,
//                       color: AppColors.black,
//                     ),
//                     SizedBox(height: 8.h),
//                     ...dailyNotifications.map((notification) {
//                       return Container(
//                         margin: EdgeInsets.only(bottom: 18.14.h),
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 16.w, vertical: 10.h),
//                         decoration: BoxDecoration(
//                           color: AppColors.pinkLight,
//                           borderRadius: BorderRadius.circular(10.r),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             AppText(
//                               title: notification["title"],
//                               fontWeight: FontWeight.w400,
//                               fontFamily: "Roboto",
//                               fontSize: 16.sp,
//                               color: AppColors.black,
//                             ),
//                             AppText(
//                               title: notification["time"],
//                               fontWeight: FontWeight.w400,
//                               fontFamily: "Roboto",
//                               fontSize: 16.sp,
//                               color: AppColors.black,
//                             ),
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                     SizedBox(height: 18.14.h),
//                   ],
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   // تجميع الإشعارات حسب التاريخ
//   Map<String, List<Map<String, dynamic>>> _groupByDate(
//       List<QueryDocumentSnapshot> notifications) {
//     final Map<String, List<Map<String, dynamic>>> grouped = {};
//
//     for (var notification in notifications) {
//       final data = notification.data() as Map<String, dynamic>;
//       final date = DateTime.parse(data['time']).toLocal();
//       final formattedDate = _formatDate(date);
//
//       final notificationData = {
//         "title": data['title'],
//         "time": _formatTime(date),
//       };
//
//       if (grouped.containsKey(formattedDate)) {
//         grouped[formattedDate]!.add(notificationData);
//       } else {
//         grouped[formattedDate] = [notificationData];
//       }
//     }
//
//     return grouped;
//   }
//
//   // تنسيق التاريخ (Today, Yesterday, ...)
//   String _formatDate(DateTime date) {
//     final now = DateTime.now();
//
//     if (DateUtils.isSameDay(date, now)) {
//       return "Today, ${_formatDay(date)}";
//     } else if (DateUtils.isSameDay(date, now.subtract(const Duration(days: 1)))) {
//       return "Yesterday, ${_formatDay(date)}";
//     } else {
//       return "${_dayOfWeek(date)}, ${_formatDay(date)}";
//     }
//   }
//
//   // تنسيق الوقت
//   String _formatTime(DateTime date) {
//     return "${date.hour % 12 == 0 ? 12 : date.hour % 12}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'PM' : 'AM'}";
//   }
//
//   // اسم اليوم
//   String _dayOfWeek(DateTime date) {
//     return ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
//     [date.weekday - 1];
//   }
//
//   // تنسيق اليوم والشهر
//   String _formatDay(DateTime date) {
//     return "${date.day} ${["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][date.month - 1]}";
//   }
// }

//----------------------------------------------------------------------------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import '../../Core/app_colors/app_colors.dart';
// import '../../Core/route_utils/route_utils.dart';
// import '../../Widgets/app_text.dart';
// import '../../Widgets/secondary_app_bar.dart';
// import '../../main.dart';
//
// class NotificationView extends StatefulWidget {
//   const NotificationView({super.key});
//
//   @override
//   _NotificationViewState createState() => _NotificationViewState();
// }
//
// class _NotificationViewState extends State<NotificationView> {
//   @override
//   void initState() {
//     super.initState();
//
//     // الاشتراك في الموضوع لتلقي الإشعارات
//     FirebaseMessaging.instance.subscribeToTopic('allUsers');
//
//     // استماع للإشعارات الفورية أثناء فتح التطبيق
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (message.notification != null) {
//         _showNotification(
//           title: message.notification!.title ?? "No Title",
//           body: message.notification!.body ?? "No Body",
//         );
//       }
//     });
//   }
//
//   Future<void> _showNotification(
//       {required String title, required String body}) async {
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'high_importance_channel', // يجب أن يكون مطابقًا لتعريف القناة
//       'High Importance Notifications',
//       importance: Importance.high,
//       priority: Priority.high,
//       sound: RawResourceAndroidNotificationSound('notification'), // صوت مخصص
//     );
//
//     const NotificationDetails notificationDetails = NotificationDetails(
//       android: androidDetails,
//     );
//
//     await flutterLocalNotificationsPlugin.show(
//       0, // ID الإشعار
//       title,
//       body,
//       notificationDetails,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: SecondaryAppBar(
//         title: "Notifications",
//         onTap: () {
//           RouteUtils.pop();
//         },
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//         child: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('notifications')
//               .orderBy('time', descending: true)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return const Center(child: Text("No Notifications"));
//             }
//
//             final notifications = snapshot.data!.docs;
//             final groupedNotifications = _groupByDate(notifications);
//
//             return ListView.builder(
//               itemCount: groupedNotifications.keys.length,
//               itemBuilder: (context, index) {
//                 String date = groupedNotifications.keys.elementAt(index);
//                 List<Map<String, dynamic>> dailyNotifications =
//                 groupedNotifications[date]!;
//
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     AppText(
//                       title: date,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: "Roboto",
//                       fontSize: 16.sp,
//                       color: AppColors.black,
//                     ),
//                     SizedBox(height: 8.h),
//                     ...dailyNotifications.map((notification) {
//                       return Container(
//                         margin: EdgeInsets.only(bottom: 18.14.h),
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 16.w, vertical: 10.h),
//                         decoration: BoxDecoration(
//                           color: AppColors.pinkLight,
//                           borderRadius: BorderRadius.circular(10.r),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             AppText(
//                               title: notification["title"],
//                               fontWeight: FontWeight.w400,
//                               fontFamily: "Roboto",
//                               fontSize: 16.sp,
//                               color: AppColors.black,
//                             ),
//                             AppText(
//                               title: notification["time"],
//                               fontWeight: FontWeight.w400,
//                               fontFamily: "Roboto",
//                               fontSize: 16.sp,
//                               color: AppColors.black,
//                             ),
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                     SizedBox(height: 18.14.h),
//                   ],
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Map<String, List<Map<String, dynamic>>> _groupByDate(
//       List<QueryDocumentSnapshot> notifications) {
//     final Map<String, List<Map<String, dynamic>>> grouped = {};
//
//     for (var notification in notifications) {
//       final data = notification.data() as Map<String, dynamic>;
//       final date = DateTime.parse(data['time']).toLocal();
//       final formattedDate = _formatDate(date);
//
//       final notificationData = {
//         "title": data['title'],
//         "time": _formatTime(date),
//       };
//
//       if (grouped.containsKey(formattedDate)) {
//         grouped[formattedDate]!.add(notificationData);
//       } else {
//         grouped[formattedDate] = [notificationData];
//       }
//     }
//
//     return grouped;
//   }
//
//   String _formatDate(DateTime date) {
//     final now = DateTime.now();
//
//     if (DateUtils.isSameDay(date, now)) {
//       return "Today, ${_formatDay(date)}";
//     } else if (DateUtils.isSameDay(date, now.subtract(const Duration(days: 1)))) {
//       return "Yesterday, ${_formatDay(date)}";
//     } else {
//       return "${_dayOfWeek(date)}, ${_formatDay(date)}";
//     }
//   }
//
//   String _formatTime(DateTime date) {
//     return "${date.hour % 12 == 0 ? 12 : date.hour % 12}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'PM' : 'AM'}";
//   }
//
//   String _dayOfWeek(DateTime date) {
//     return ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
//     [date.weekday - 1];
//   }
//
//   String _formatDay(DateTime date) {
//     return "${date.day} ${["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][date.month - 1]}";
//   }
// }
//
//
