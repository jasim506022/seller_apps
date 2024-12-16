import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/onboarding_controller.dart';
import '../../../model/onboard_model.dart';
import '../../../res/app_constants.dart';
import '../../../res/apps_color.dart';

class DotIndicatorWidget extends StatelessWidget {
  const DotIndicatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    return SizedBox(
      height: AppConstants.defaultHeightSpace,
      child: ListView.builder(
        itemCount: onboardingData.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Container(
                  height: 10.h,
                  width: 10.h,
                  margin: EdgeInsets.symmetric(horizontal: 3.h),
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
