import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Splash/view.dart';
import 'Core/route_utils/route_utils.dart';
import 'Core/utils.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //print('Background message received: ${message.notification?.title}');
  print("Handling a background message: ${message.messageId}");
}

//final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // const AndroidInitializationSettings androidInitializationSettings =
  // AndroidInitializationSettings('@mipmap/ic_launcher');
  //
  // const InitializationSettings initializationSettings = InitializationSettings(
  //   android: androidInitializationSettings,
  // );
  //
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings);
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
      home: const SplashView(),
      // title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
    );
  }
}
