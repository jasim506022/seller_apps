import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/onboarding_controller.dart';
import '../../data/response/service/onboarding_list_data.dart';
import '../../model/onboard_model.dart';
import '../../res/app_string.dart';
import '../../res/apps_color.dart';
import '../../res/apps_text_style.dart';
import 'widget/onboarding_page_content_widget.dart';

/// This screen displays the onboarding flow with multiple pages.
/// Users can swipe through onboarding pages or skip them using the 'Skip' button.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController onboardingController =
        Get.find<OnboardingController>();
    final List<OnboardModel> onboardingList =
        OnBoardingListData.getOnboardingData();

    // Set the status bar style for better visibility
    _configureStatusBar();
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Skip Button: Navigates users to the next screen, marking onboarding as completed
          TextButton(
            onPressed: onboardingController.skipOnboarding,
            child: Text(
              AppStrings.btnSkip,
              style: AppsTextStyle.button.copyWith(color: AppColors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: PageView.builder(
            controller: onboardingController.pageController,
            itemCount: onboardingList.length,
            onPageChanged: (index) => onboardingController.currentIndex(index),
            itemBuilder: (context, index) => OnboardingPageContentWidget(
                onboardingItem: onboardingList[index])),
      ),
    );
  }

  /// Configures the status bar to have a light background with dark icons.
  void _configureStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.white, statusBarBrightness: Brightness.dark));
  }
}
