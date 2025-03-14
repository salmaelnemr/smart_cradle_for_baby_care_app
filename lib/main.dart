import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cradle_for_baby_care_app/Core/services/notification_service.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Login/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Splash/view.dart';
import 'Core/route_utils/route_utils.dart';
import 'Core/utils.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   //print('Background message received: ${message.notification?.title}');
//   print("Handling a background message: ${message.messageId}");
// }

//final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
bool show = true;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  show = prefs.getBool("ON_BOARDING") ?? true;
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
    return MaterialApp(
      navigatorKey: RouteUtils.navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child){
        ScreenUtil.init(
          context,
          designSize: const Size(414, 896),
        );
        return child!;
      },
      theme: Utils.appTheme,
      home: show ? const SplashView() : const LoginView(),
      // title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
    );
  }
}
