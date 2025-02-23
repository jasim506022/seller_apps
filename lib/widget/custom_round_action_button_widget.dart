import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/apps_color.dart';
import '../res/apps_text_style.dart';

class CustomRoundActionButtonWidget extends StatelessWidget {
  const CustomRoundActionButtonWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.horizontal,
  });
  final String title;
  final VoidCallback onTap;
  final double? horizontal;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(AppColors.green),
          padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
              horizontal: horizontal ?? 40.w, vertical: 12.h)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: AppsTextStyle.button,
        ));
  }
}
