import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/app_function.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';

class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({
    super.key,
    required this.tap,
    required this.color,
    required this.image,
    required this.title,
  });

  final VoidCallback tap; 
  final Color color;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap, 
      child: Container(
        alignment: Alignment.center,
        height: 60.h,
        width: 1.sw,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 0.04.sh,
              width: 0.04.sh,
              color: AppColors.white,
            ),
            AppsFunction.horizontalSpace(10),
            Text(
              title,
              style: AppsTextStyle.buttonTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
