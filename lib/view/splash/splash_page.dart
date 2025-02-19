import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/splash_controller.dart';
import '../../res/app_asset/image_asset.dart';

import '../../widget/app_logo_widget.dart';

/// SplashPage is the initial screen of the app that is displayed when the app is launched.
/// This screen typically displays a logo or an introductory image while the app initializes.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Calling the SplashController to ensure it's loaded
    Get.find<SplashController>();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // Decoration to add background image to the container
          image: DecorationImage(
            fit: BoxFit.fill,
            // Makes sure the background image fills the entire container area
            image: AssetImage(AppImage.splashScreenBackground),
          ),
        ),
        // Center widget centers its child within the available space
        child: const Center(
          child: AppLogoWidget(),
        ),
      ),
    );
  }
}
