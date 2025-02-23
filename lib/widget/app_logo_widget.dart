import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_asset/icon_asset.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../res/apps_text_style.dart';

/// `AppLogoWidget` is a reusable widget that displays the application logo along with its name.
/// This widget consists of an image (logo) and a text label (app name) arranged in a column.
class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppIcons.appLogo,
          height: 80.h,
          width: 100.w,
          fit: BoxFit.fill,
        ),

        AppsFunction.verticalSpacing(10),
        // App name displayed as text with a predefined style
        Text(AppStrings.appName, style: AppsTextStyle.logoText),
      ],
    );
  }
}
