import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/onboarding_controller.dart';
import '../../../model/onboard_model.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import 'dot_indicator_widget.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    super.key,
    required this.item,
  });

  final OnboardModel item;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          item.img,
          height: 350.h,
          fit: BoxFit.fill,
        ),
        const DotIndicatorWidget(),
        Text(
          item.text,
          textAlign: TextAlign.center,
          style: AppsTextStyle.largeTitleTextStyle.copyWith(fontSize: 30.sp),
        ),
        Text(item.desc,
            textAlign: TextAlign.center, style: AppsTextStyle.mediumBoldText),
        InkWell(
          onTap: () async {
            controller.nextPage();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
            decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(15.r)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Next",
                  style: AppsTextStyle.buttonTextStyle,
                ),
                SizedBox(
                  width: 10.w,
                ),
                const Icon(
                  Icons.arrow_forward_sharp,
                  color: AppColors.white,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
