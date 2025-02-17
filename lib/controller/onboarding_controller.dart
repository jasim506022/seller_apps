import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/onboard_model.dart';
import '../res/app_constants.dart';
import '../res/app_string.dart';
import '../res/routes/routes_name.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController(initialPage: 0);
  var currentIndex = 0.obs;

  /// Marks the onboarding as viewed in shared preferences and navigates to the sign-in page
  void markOnboardingAsViewedAndNavigate() {
    AppConstants.isViewed = 0;
    AppConstants.sharedPreference!
        .setInt(AppStrings.onBoardingShareKey, AppConstants.isViewed!);
    Get.offNamed(RoutesName.signPage);
  }

  /// Navigates to the next page in the onboarding sequence
  void navigateToNextPageOrSkip() {
    if (currentIndex.value == onboardingData.length - 1) {
      markOnboardingAsViewedAndNavigate();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
