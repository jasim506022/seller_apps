import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/app_function.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/network_utilis.dart';

/// A reusable social login button with an icon, label, and customizable background color.
///
/// This button is designed for social authentication (e.g., Google, Facebook).
/// It consists of an icon and a text label, both centered inside a rounded container.
class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.iconPath,
    required this.label,
  });

  final VoidCallback onTap;
  final Color color;
  final String iconPath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async =>
          await NetworkUtils.executeWithInternetCheck(action: onTap),
      child: Container(
        alignment: Alignment.center,
        height: 60.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              height: 34.h,
              width: 34.h,
              color: AppColors.white,
            ),
            AppsFunction.horizontalSpacing(10),
            Text(
              label,
              style: AppsTextStyle.button,
            ),
          ],
        ),
      ),
    );
  }
}
