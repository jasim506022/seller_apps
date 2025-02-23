import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/apps_color.dart';
import '../res/apps_text_style.dart';
import '../res/network_utilis.dart';

/// A customizable primary button with internet connectivity check.
/// Ensures the action is only performed when the device is online.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.width,
    required this.title,
    required this.onPressed,
  });

  final double? width;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      width: width?.w ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: AppColors.green,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r))),
        onPressed: () =>
            NetworkUtils.executeWithInternetCheck(action: () => onPressed()),

        /// Ensures button action is only performed if internet is available.
        child: Text(
          title,
          style: AppsTextStyle.button,
        ),
      ),
    );
  }
}
/*
can we are use OnPressed Button With parent threiss ();
#: Why we doesn't use onpRess (); present threis 
*/
