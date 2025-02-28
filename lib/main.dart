import 'dart:developer' as developer;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'my_app.dart';
import 'res/app_constants.dart';
import 'res/app_string.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeFirebase(); //Initialize Firebase
  await _loadSharedPreferences(); // Load shared preferences and onboarding status
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

// Firebase Initialization with error handling
Future<void> _initializeFirebase() async {
  try {
    await Firebase.initializeApp();
  } catch (e, stackTrace) {
    developer.log("Firebase initialization failed: $e", stackTrace: stackTrace);
  }
}

// Firebase Initialization with error handling
Future<void> _loadSharedPreferences() async {
  try {
    AppConstants.sharedPreference = await SharedPreferences.getInstance();

// Check onboarding status
    AppConstants.isViewed =
        AppConstants.sharedPreference?.getInt(AppStrings.prefOnboarding) ?? 0;
  } catch (e) {
    developer.log("Error loading SharedPreferences: $e");
  }
}

// Handles Firebase background messages
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    developer.log("Background Message Data: ${message.data}");
    if (message.notification != null) {
      developer.log("Title: ${message.notification?.title}");
      developer.log("Body: ${message.notification?.body}");
    }
  } catch (e) {
    developer.log("Error handling background message: $e");
  }
}
