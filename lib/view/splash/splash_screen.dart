import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/splash_controller.dart';
import '../../res/app_asset/icon_asset.dart';
import '../../res/app_asset/image_asset.dart';
import '../../res/app_string.dart';
import '../../res/apps_color.dart';
import '../../res/apps_text_style.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage(ImagesAsset.splashPageBg))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                IconAsset.appIcon,
                height: 150.h,
                width: 150.h,
              ),
              Text(AppString.appsName,
                  style: AppsTextStyle.largeTitleTextStyle
                      .copyWith(color: AppColors.green, fontSize: 26.sp)),
            ],
          ),
        ),
      ),
    );
  }
}

/*
1. What is Page and Screen

2. What is different Between Scaffood and Materiali
*/