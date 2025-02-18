import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/onboarding_controller.dart';
import '../../../model/onboard_model.dart';
import '../../../res/apps_color.dart';

class OnboardingProgressDotsWidget extends StatelessWidget {
  const OnboardingProgressDotsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    return SizedBox(
      height: 10.h,
      child: ListView.builder(
        itemCount: onboardingData.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 10.h,
                  width: controller.currentIndex.value == index ? 12.h : 10.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                      color: controller.currentIndex.value == index
                          ? AppColors.red
                          : AppColors.black,
                      borderRadius: BorderRadius.circular(10.r)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
