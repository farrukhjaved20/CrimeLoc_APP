// import 'dart:io';
// import 'dart:math';

// import 'package:app_settings/app_settings.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationServices {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   void requestNotificationPermission() async {
//     NotificationSettings settings = await messaging.requestPermission(
//         alert: true,
//         announcement: true,
//         badge: true,
//         carPlay: true,
//         criticalAlert: true,
//         provisional: true,
//         sound: true);
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       if (kDebugMode) {
//         print("User granted permission ");
//       }
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       if (kDebugMode) {
//         print("User granted provisional permission ");
//       }
//     } else {
//       AppSettings.openAppSettings(type: AppSettingsType.settings);
//       if (kDebugMode) {
//         print("User permission denied");
//       }
//     }
//   }

//   void initLocalNotification(
//       BuildContext context, RemoteMessage message) async {
//     var androidInitializationSettings =
//         const AndroidInitializationSettings("@mipmap/ic_launcher");
//     var iosInitializationSettings = const DarwinInitializationSettings();

//     var initializationSetting = InitializationSettings(
//         android: androidInitializationSettings, iOS: iosInitializationSettings);

//     await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
//         onDidReceiveNotificationResponse: (payload) {});
//   }

//   void firebaseInit(BuildContext context) {
//     FirebaseMessaging.onMessage.listen((message) {
//       if (Platform.isAndroid) {
//         initLocalNotification(context, message);
//         showNotification(message);
//       }
//     });
//   }

//   Future<void> showNotification(RemoteMessage message) async {
//     AndroidNotificationChannel channel = AndroidNotificationChannel(
//         Random.secure().nextInt(10000).toString(),
//         "High Importance Notification",
//         importance: Importance.max); // Max importance to show the notification

//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//             channel.id.toString(), channel.name.toString(),
//             channelDescription: "Your channel description",
//             importance: Importance.high,
//             priority: Priority.high,
//             ticker: "ticker");

//     DarwinNotificationDetails darwinNotificationDetails =
//         const DarwinNotificationDetails(
//             presentAlert: true, presentBadge: true, presentSound: true);
//     NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails, iOS: darwinNotificationDetails);

//     Future.delayed(Duration.zero, () {
//       _flutterLocalNotificationsPlugin.show(
//           0,
//           message.notification!.title.toString(),
//           message.notification!.body.toString(),
//           notificationDetails);
//     });
//   }

//   Future<String> getDeviceToken() async {
//     String? token = await messaging.getToken();
//     return token!;
//   }

//   void isTokenRefresh() {
//     messaging.onTokenRefresh.listen((event) {
//       event.toString();
//     });
//   }
// }
