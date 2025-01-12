
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/apps_color.dart';
import '../res/apps_text_style.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    this.width,
    required this.title,
  });

  final double? width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 45.h,
      width: width?.w ?? 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: AppColors.green,
      ),
      child: Text(
        title,
        style: AppsTextStyle.buttonTextStyle,
      ),
    );
  }
}
