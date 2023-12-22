import 'package:flutter/material.dart';
import 'package:seller_apps/test/firebaseapi.dart';

class HomePageTestDart extends StatefulWidget {
  const HomePageTestDart({super.key});

  @override
  State<HomePageTestDart> createState() => _HomePageTestDartState();
}

class _HomePageTestDartState extends State<HomePageTestDart> {
  FirebaseApi firebaseApi = FirebaseApi();

  @override
  void initState() {
    firebaseApi.initNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Notification Tutoral"),
      ),
    );
  }
}
