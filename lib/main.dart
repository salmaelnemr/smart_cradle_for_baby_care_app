import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/services/notification_service.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Home/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Splash/view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_loading_indicator.dart';
import 'Core/caching_utils/caching_utils.dart';
import 'Core/network_utils/network_utils.dart';
import 'Core/route_utils/route_utils.dart';
import 'Core/utils.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   //print('Background message received: ${message.notification?.title}');
//   print("Handling a background message: ${message.messageId}");
// }

//final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//bool show = true;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //final prefs = await SharedPreferences.getInstance();
  //show = prefs.getBool("ON_BOARDING") ?? true;
  await NetworkUtils.init();
  //await CachingUtils.init();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  await NotificationService.instance.initialize();
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // const AndroidInitializationSettings androidInitializationSettings =
  // AndroidInitializationSettings('@mipmap/ic_launcher');
  //
  // const InitializationSettings initializationSettings = InitializationSettings(
  //   android: androidInitializationSettings,
  // );
  //
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  //getFCMToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CachingUtils.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: AppLoadingIndicator());
        }
        return MaterialApp(
          navigatorKey: RouteUtils.navigatorKey,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            ScreenUtil.init(
              context,
              designSize: const Size(393, 852),
            );
            return child!;
          },
          theme: Utils.appTheme,
          title: "IntelliNest",
          home: CachingUtils.isLogged ? const HomeView() : const SplashView(),
        );
      },
    );
  }
}

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:smart_cradle_for_baby_care_app/Core/services/notification_service.dart';
// import 'package:smart_cradle_for_baby_care_app/Features/Home/view.dart';
// import 'package:smart_cradle_for_baby_care_app/Features/Login/view.dart';
// import 'package:smart_cradle_for_baby_care_app/Features/Splash/view.dart';
// import 'Core/caching_utils/caching_utils.dart';
// import 'Core/network_utils/network_utils.dart';
// import 'Core/route_utils/route_utils.dart';
// import 'Core/utils.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await ScreenUtil.ensureScreenSize();
//   await CachingUtils.init(); // Initialize SharedPreferences
//   await NetworkUtils.init(); // Initialize Dio
//   await NotificationService.instance.initialize();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: RouteUtils.navigatorKey,
//       debugShowCheckedModeBanner: false,
//       builder: (context, child) {
//         ScreenUtil.init(
//           context,
//           designSize: const Size(414, 896),
//         );
//         return child!;
//       },
//       theme: Utils.appTheme,
//       home: FutureBuilder<bool>(
//         future: Future(() async => CachingUtils.isLogged), // Async check
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const SplashView(); // Show splash while waiting
//           }
//           if (snapshot.hasError) {
//             // Handle initialization error (e.g., log it or show an error screen)
//             print('Error in initialization: ${snapshot.error}');
//             return const SplashView(); // Fallback to SplashView
//           }
//           if (snapshot.hasData && snapshot.data == true) {
//             return const HomeView(); // Logged in
//           }
//           return const SplashView(); // Not logged in
//         },
//       ),
//     );
//   }
// }