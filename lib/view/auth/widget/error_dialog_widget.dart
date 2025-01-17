import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/app_function.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/round_button_widget.dart';

class ErrorDialogWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String? content;
  final String? buttonText;
  final bool barrierDismissible;

  const ErrorDialogWidget({
    super.key,
    required this.icon,
    required this.title,
    this.content,
    this.buttonText,
    this.barrierDismissible = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: barrierDismissible ? () => Get.back() : null,
      child: Dialog(
        backgroundColor: AppColors.white,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                icon,
                height: 100.h,
                width: 100.h,
              ),
              AppsFunction.verticalSpace(20),
              Text(
                title,
                style: AppsTextStyle.titleTextStyle
                    .copyWith(color: AppColors.deepGreen),
                textAlign: TextAlign.center,
              ),
              if (content != null) ...[
                AppsFunction.verticalSpace(15),
                Text(
                  content!,
                  textAlign: TextAlign.center,
                  style: AppsTextStyle.subTitleTextStyle,
                ),
              ],
              if (buttonText != null) ...[
                AppsFunction.verticalSpace(20),
                RoundButtonWidget(
                  buttonColors: AppColors.red,
                  width: Get.width,
                  title: buttonText!,
                  onTap: () => Get.back(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
