import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seller_apps/res/app_function.dart';

import '../../../res/app_asset/image_asset.dart';
import '../../../res/apps_text_style.dart';

class AppSignInPageIntroWidget extends StatelessWidget {
  const AppSignInPageIntroWidget(
      {super.key, required this.title, required this.description, this.widget});

  final String title;
  final String description;

  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppsFunction.verticalSpacing(50),
        widget ??
            Image.asset(
              AppImage.appLogoImage,
              height: 140.h,
              width: 140.h,
            ),
        AppsFunction.verticalSpacing(10),
        Text(title, style: AppsTextStyle.titleSignPageTextStyle),
        AppsFunction.verticalSpacing(10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: AppsTextStyle.descrptionTextStyle,
        ),
        AppsFunction.verticalSpacing(40),
      ],
    );
  }
}
