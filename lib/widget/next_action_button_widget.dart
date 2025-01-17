import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_function.dart';
import '../res/apps_color.dart';
import '../res/apps_text_style.dart';

class NextActionButtonWidget extends StatelessWidget {
  const NextActionButtonWidget({
    super.key,
    required this.onTap,
    required this.title,
  });

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
        decoration: BoxDecoration(
            color: AppColors.black, borderRadius: BorderRadius.circular(15.r)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: AppsTextStyle.buttonTextStyle,
            ),
            AppsFunction.horizontalSpace(10),
            const Icon(
              Icons.arrow_forward_sharp,
              color: AppColors.white,
            )
          ],
        ),
      ),
    );
  }
}
