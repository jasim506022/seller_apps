import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../res/app_function.dart';
import '../res/apps_color.dart';
import '../res/apps_text_style.dart';
import 'round_button_widget.dart';

/// A customizable error dialog widget that displays an icon, title,
/// optional content, and an optional button.
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
      /// Dismiss dialog if `barrierDismissible` is true.
      onTap: barrierDismissible ? () => Get.back() : null,
      behavior: barrierDismissible
          ? HitTestBehavior.opaque
          : HitTestBehavior.translucent,
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Displays the error icon.
              Image.asset(
                icon,
                height: 100.h,
                width: 100.h,
              ),
              AppsFunction.verticalSpacing(20),

              /// Displays the title text.

              Text(
                title,
                style: AppsTextStyle.titleText
                    .copyWith(color: AppColors.deepGreen),
                textAlign: TextAlign.center,
              ),

              /// Displays the optional content message if available.

              if (content?.isNotEmpty ?? false) ...[
                AppsFunction.verticalSpacing(15),
                Text(
                  content!,
                  textAlign: TextAlign.center,
                  style: AppsTextStyle.mediumNormalText,
                ),
              ],

              /// Displays the optional button if `buttonText` is provided.
              if (buttonText?.isNotEmpty ?? false) ...[
                AppsFunction.verticalSpacing(20),
                RoundButtonWidget(
                  buttonColors: AppColors.red,
                  width: double.infinity,
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
/*
Understand Null: ?.!. ??, ??=
Also Underst ...
content?.isNotEmpty ?? false) ...
*/
