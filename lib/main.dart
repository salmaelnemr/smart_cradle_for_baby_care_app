import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/services/notification_service.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Splash/view.dart';
import 'Core/caching_utils/caching_utils.dart';
import 'Core/route_utils/route_utils.dart';
import 'Core/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachingUtils.init();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  await NotificationService.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: RouteUtils.navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(393, 852),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return child!;
          },
          child: child,
        );
      },
      theme: Utils.appTheme,
      title: "IntelliNest",
      home: const SplashView(),
    );
  }
}