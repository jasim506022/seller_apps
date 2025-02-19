import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/onboarding_controller.dart';
import '../../../data/response/service/onboarding_list_data.dart';
import '../../../res/apps_color.dart';

/// A widget to display progress dots during the onboarding process.
/// The active dot is highlighted based on the current page.
class OnboardingProgressDotsWidget extends StatelessWidget {
  const OnboardingProgressDotsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final OnboardingController onboardingController =
        Get.find<OnboardingController>();
    return SizedBox(
      height: 15.h,
      child: ListView.builder(
        itemCount: OnBoardingListData.getOnboardingData().length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                // The current dot's active/inactive state
                bool isActive =
                    onboardingController.currentIndex.value == index;
                return AnimatedContainer(
                  duration:
                      const Duration(milliseconds: 300), //Smooth transition
                  height: 10.h,
                  width: isActive ? 12.h : 10.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                      color: isActive ? AppColors.red : AppColors.black,
                      borderRadius: BorderRadius.circular(10.r)),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
