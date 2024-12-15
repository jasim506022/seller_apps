import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:seller_apps/res/apps_text_style.dart';

import '../../res/app_constants.dart';
import '../../res/apps_color.dart';
import '../../res/routes/routes_name.dart';

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
        var currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          Get.offNamed(RoutesName.mainPage);
        } else {
          if (AppConstants.isViewed != 0) {
            Get.offNamed(RoutesName.onBaordingPage);
          } else {
            Get.offNamed(RoutesName.signPage);
          }
        }
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
   
    var mq = MediaQuery.of(context).size;
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
                    style: AppsTextStyle.largeTitleTextStyle
                        .copyWith(color: AppColors.green, fontSize: 22)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
