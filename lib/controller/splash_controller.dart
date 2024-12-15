import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../res/app_constants.dart';
import '../../res/routes/routes_name.dart';
import '../repository/splash_repository.dart';

class SplashController extends GetxController {
  SplashRepository repository;

  SplashController({required this.repository});

  @override
  void onInit() {
    _navigateToNextScreen();

    _configureUI();
    super.onInit();
  }

  // Logic for determining the next screen
  void _navigateToNextScreen() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        var currentUser = repository.getCurrentUser();
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
  void onClose() {
    // Re-enable system UI overlays when splash screen is disposed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.onClose();
  }

  // Disable system UI overlays (e.g., status and navigation bars)
  void _configureUI() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }
}
