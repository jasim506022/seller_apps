import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/loading_controller.dart';
import '../res/apps_color.dart';
import '../res/apps_text_style.dart';

class CustomAuthButtonWidget extends StatelessWidget {
  const CustomAuthButtonWidget(
      {super.key, required this.onPressed, required this.title});

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    LoadingController loadingController = Get.put(LoadingController());
    return SizedBox(
      width: 1.sw,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.greenColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          ),
          onPressed: onPressed,
          child: Obx(
            () => loadingController.loading.value
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: AppColors.white,
                    ),
                  )
                : Text(
                    title,
                    style: AppsTextStyle.buttonTextStyle
                        .copyWith(color: AppColors.white),
                  ),
          )),
    );
  }
}
