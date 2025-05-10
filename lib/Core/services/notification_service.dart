import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../route_utils/route_utils.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Notification/view.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize() async {
    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request permission for notifications
    await _requestPermission();

    // Set up foreground and background message handlers
    await _setupMessageHandlers();

    // Get the FCM token for debugging
    final token = await _messaging.getToken();
    print('FCM Token: $token');
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    print("Permission status: ${settings.authorizationStatus}");
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) return;

    const channel = AndroidNotificationChannel(
      "high_importance_channel",
      "High Importance Notifications",
      description: "This channel is used for important notifications.",
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        _navigateToNotificationView();
      },
    );

    _isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            "high_importance_channel",
            "High Importance Notifications",
            channelDescription: "This channel is used for important notifications.",
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );

      // Save the notification with timestamp
      await saveNotification(
        notification.title ?? "No Title",
        notification.body ?? "No Body",
      );
    }
  }

  Future<void> _setupMessageHandlers() async {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });

    // Handle notifications when the app is opened from a notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _navigateToNotificationView();
    });

    // Handle notifications when the app is launched from a terminated state
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _navigateToNotificationView();
    }
  }

  void _navigateToNotificationView() {
    RouteUtils.push(const NotificationView());
  }

  Future<void> saveNotification(String title, String body) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> notifications = prefs.getStringList('notifications') ?? [];

    final newNotification = jsonEncode({
      'title': title,
      'body': body,
      'timestamp': DateTime.now().toIso8601String(), // Store timestamp
    });

    // Add the new notification to the beginning of the list
    notifications.insert(0, newNotification);

    // Limit the number of notifications to 50
    if (notifications.length > 50) {
      notifications.removeLast();
    }

    await prefs.setStringList('notifications', notifications);
  }

  Future<List<Map<String, dynamic>>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> notifications = prefs.getStringList('notifications') ?? [];

    return notifications.map((notify) => jsonDecode(notify) as Map<String, dynamic>).toList();
  }
}


