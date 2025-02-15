import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/splash_controller.dart';
import '../../res/app_asset/icon_asset.dart';
import '../../res/app_asset/image_asset.dart';
import '../../res/app_string.dart';
import '../../res/apps_text_style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage(AppImage.splashPageBg))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                IconAsset.appIcon,
                height: 120.h,
                width: 120.h,
                fit: BoxFit.fill,
              ),
              Text(AppString.appsName, style: AppsTextStyle.appsLogoTextStyole),
            ],
          ),
        ),
      ),
    );
  }
}
