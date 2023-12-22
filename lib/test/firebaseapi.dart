import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  if (kDebugMode) {
    print("title: ${message.notification!.title}");
  }
  if (kDebugMode) {
    print("Body: ${message.notification!.body}");
  }
  if (kDebugMode) {
    print("Paylodad: ${message.data}");
  }
}

class FirebaseApi {
  final _firebaseMessageing = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessageing.requestPermission();
    final fCMToken = await _firebaseMessageing.getToken();
    if (kDebugMode) {
      print("Token: $fCMToken");
    }

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
