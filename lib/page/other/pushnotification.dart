import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seller_apps/page/other/local_service.dart';
import 'package:http/http.dart';

class PushNotification {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print("Notification permission granted.");
      }
    } else {
      if (kDebugMode) {
        print("Notification permission not granted.");
      }
    }
  }

  initMessageInforUser(BuildContext context) {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        if (kDebugMode) {
          print("BAngladesh");
        }
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        if (kDebugMode) {
          print(message.notification!.body);
        }
        if (kDebugMode) {
          print(message.notification!.title);
        }
        LocalServiceNotification.display(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data['data'];
      if (kDebugMode) {
        print(routeFromMessage);
      }
      if (kDebugMode) {
        print("Bangla on Message onep");
      }
    });
  }

  Future<void> sendNotificationUser(
      String title, String body, String data) async {
    post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              "key=AAAAss2Sy-E:APA91bGkl-bkcLh9_XYIkj_f6_pWo8BRElO-8_U-buseYplgyd-lxMiiysx3ftR4lLgkZTYdWx3zgnigIuw2_JMUiW4ZnNKgeCYjlqYSPQLI7EhQkGgoHr3EdobNYNmuKmwUmWh7gNr8",
        },
        body: jsonEncode(
          <String, dynamic>{
            'to':
                "c_M-5llkSoC7Zt-W7_ZgEt:APA91bFA6DnkPzbFrK76DMixhKw1nhjttMsedw4F0chEWpSGcHX13UlwiN-SP96QWUQ8hwG2vqca3foMXrFHpk5nZdNvKhIpN90wUPFvEcUT2EC4Oou0Pb9Cjv3Bb25BQ2kbCoWNUbVq",
            'data': <String, dynamic>{
              'title': title,
              'body': body,
              'data': data
            },
            'notification': <String, dynamic>{
              'title': title,
              'body': body,
            },
          },
        ));
  }
}
