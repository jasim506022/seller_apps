import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:seller_apps/const/approutes.dart';

class LocalServiceNotification {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initializeuser(BuildContext context) {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        Navigator.pushNamed(context, AppRouters.totalSales);
      },
    );
  }

  static void display(RemoteMessage message) async {
    try {
      AndroidNotificationDetails androidNotificationDetails =
          const AndroidNotificationDetails(
        'jasimgrocery',
        'jasimgrocery',
        importance: Importance.high,
        priority: Priority.high,
      );
      NotificationDetails details =
          NotificationDetails(android: androidNotificationDetails);

      await flutterLocalNotificationsPlugin.show(
          50, message.notification!.title, message.notification!.body, details,
          payload: message.data['data']);
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
