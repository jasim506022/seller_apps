import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/onboarding_controller.dart';
import '../../model/onboard_model.dart';
import '../../res/app_string.dart';
import '../../res/apps_color.dart';
import '../../res/apps_text_style.dart';
import 'widget/onboarding_screen_content_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    _setStatusBarStyle();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () => controller.markOnboardingAsViewedAndNavigate(),
              child: Text(
                AppString.skip,
                style: AppsTextStyle.largeBoldText
                    .copyWith(color: AppColors.black),
              )),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: PageView.builder(
          controller: controller.pageController,
          itemCount: onboardingData.length,
          onPageChanged: (index) => controller.currentIndex(index),
          itemBuilder: (context, index) {
            var item = onboardingData[index];
            return OnboardingPageContentWidget(onboardingItem: item);
          },
        ),
      ),
    );
  }

  void _setStatusBarStyle() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.white, statusBarBrightness: Brightness.dark));
  }
}





/*

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> onBoardingInfo() async {
    int isViewed = 0;
    await AppConstants.sharedPreference!.setInt(AppString.onBoarding, isViewed);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {
                onBoardingInfo();
                Navigator.pushReplacementNamed(context, RoutesName.signPage);
              },
              child: Text(
                AppString.skip,
                style: AppsTextStyle.largeBoldText
                    .copyWith(color: AppColors.black),
              )),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: PageView.builder(
          controller: _pageController,
          itemCount: onboardModeList.length,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) => setState(() => currentIndex = index),
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  onboardModeList[index].img,
                  height: 350.h,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: AppConstants.defaultHeightSpace,
                  child: ListView.builder(
                    itemCount: onboardModeList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 10.h,
                            width: 10.h,
                            margin: EdgeInsets.symmetric(horizontal: 3.h),
                            decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? AppColors.red
                                    : AppColors.black,
                                borderRadius: BorderRadius.circular(10.r)),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Text(
                  onboardModeList[index].text,
                  textAlign: TextAlign.center,
                  style: AppsTextStyle.largeTitleTextStyle
                      .copyWith(fontSize: 30.sp),
                ),
                Text(onboardModeList[index].desc,
                    textAlign: TextAlign.center,
                    style: AppsTextStyle.mediumBoldText),
                InkWell(
                  onTap: () async {
                    if (index == onboardModeList.length - 1) {
                      await onBoardingInfo();
                      if (mounted) {
                        // Navigator.pushReplacementNamed(
                        //     context, RoutesName.signPage);
                      }
                    }
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.bounceIn);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
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
          },
        ),
      ),
    );
  }
}

*/