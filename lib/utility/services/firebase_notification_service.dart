import 'dart:convert';

import 'package:chapter/main.dart';
import 'package:chapter/utility/navigation/go_config.dart';
import 'package:chapter/utility/network/api_endpoints.dart';
import 'package:chapter/utility/network/api_request.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  static final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> updateFCMToken() async {
    _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();

    if (fcmToken != null) {
      prefs.setString("FCM_TOKEN", fcmToken);
      postRequest(
        apiEndPoint: ApiEndpoints.updateFCM,
        postData: {"fcm_token": fcmToken},
      );
    }

    debugPrint("----------  updateFCMTokenAPI Stopped FCM Token in $fcmToken ----------");
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) {
      try {
        debugPrint("Notification clicked ${details.payload}");

        final Map payload = json.decode(details.payload ?? "");
        onNotificationClicked(payload: payload);
      } catch (e) {
        debugPrint("onDidReceiveNotificationResponse error $e");
      }
    });
  }

  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    try {
      final Map payLoadMap = json.decode(payload ?? "");

      onNotificationClicked(payload: payLoadMap);
    } catch (e) {
      debugPrint("onDidReceiveNotificationResponse error $e");
    }
  }

  onNotificationClicked({required Map payload}) {
    if (payload.containsKey('route')) {
      goConfig.pushNamed(payload['route'], extra: payload);
    }
  }

  fcmListener() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        createNotification(message);
      },
    );
  }

  static void createNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const androidNotificationDetails = AndroidNotificationDetails(
        'pushnotification',
        'pushnotification',
        importance: Importance.max,
        priority: Priority.high,
        largeIcon: DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
      );

      const iosNotificationDetail = DarwinNotificationDetails();

      const notificationDetails = NotificationDetails(
        iOS: iosNotificationDetail,
        android: androidNotificationDetails,
      );

      await flutterLocalNotificationsPlugin.show(
        id,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        // payload: json.encode(message.data),
      );
    } catch (error) {
      debugPrint("Notification Create Error $error");
    }
  }
}
