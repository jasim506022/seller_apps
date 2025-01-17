import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/onboarding_controller.dart';
import '../../../model/onboard_model.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/next_action_button_widget.dart';
import 'onboarding_prograess_dots_widget.dart';

class OnboardingPageContentWidget extends StatelessWidget {
  const OnboardingPageContentWidget({
    super.key,
    required this.onboardingItem,
  });

  final OnboardModel onboardingItem;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          onboardingItem.img,
          height: 300.h,
          fit: BoxFit.fill,
        ),
        const OnboardingProgressDotsWidget(),
        Text(onboardingItem.text,
            textAlign: TextAlign.center,
            style: AppsTextStyle.largeTitleTextStyleForOnBoarding),
        Text(onboardingItem.desc,
            textAlign: TextAlign.center,
            style: AppsTextStyle.mediumBoldText.copyWith(height: 2)),
        NextActionButtonWidget(
          title: AppString.next,
          onTap: () {
            controller.navigateToNextPageOrSkip();
          },
        ),
      ],
    );
  }
}
