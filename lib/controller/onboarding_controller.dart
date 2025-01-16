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
  Future<void> markOnboardingAsViewedAndNavigate() async {
    AppConstants.isViewed = 0;
    AppConstants.sharedPreference!
        .setInt(AppString.onBoardingShareKey, AppConstants.isViewed!);
    Get.offNamed(RoutesName.signPage);
  }

  /// Navigates to the next page in the onboarding sequence
  void navigateToNextPageOrSkip() async {
    if (currentIndex.value == onboardingData.length - 1) {
      await markOnboardingAsViewedAndNavigate();
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

/*
currentIndex is an observable (obs), which allows the UI to automatically update whenever it changes.
The onClose method ensures the PageController is disposed of when the controller is removed from memory, preventing potential memory leak
The controller focuses on the business logic (navigation and shared preferences) and not UI logic, making it easier to maintain and test independently of the UI.


*/