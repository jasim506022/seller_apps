import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../const/approutes.dart';
import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  splashScreenTimer() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        FirebaseAuth.instance.currentUser != null
            ? Navigator.pushReplacementNamed(context, AppRouters.mainPage)
            : Navigator.pushReplacementNamed(
                context,
                isviewed != 0
                    ? AppRouters.onBaordingPage
                    : AppRouters.signPage);
      },
    );
  }

  @override
  void initState() {
    splashScreenTimer();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);

    return Material(
      child: Stack(
        children: [
          Image.asset(
            "asset/image/splash.png",
            height: mq.height,
            width: mq.width,
            fit: BoxFit.fill,
          ),
          Positioned(
            bottom: 0,
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "asset/image/icon.png",
                  height: mq.height * .176,
                  width: mq.height * .176,
                ),
                Text("Grocery Apps",
                    style: textstyle.largestText
                        .copyWith(color: greenColor, fontSize: 22)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
