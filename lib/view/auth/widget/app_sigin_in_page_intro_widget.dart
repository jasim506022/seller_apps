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
        AppsFunction.verticalSpace(50),
        widget ??
            Image.asset(
              ImagesAsset.appLogoImage,
              height: 140.h,
              width: 140.h,
            ),
        AppsFunction.verticalSpace(10),
        Text(title, style: AppsTextStyle.titleSignPageTextStyle),
        AppsFunction.verticalSpace(10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: AppsTextStyle.descrptionTextStyle,
        ),
        AppsFunction.verticalSpace(40),
      ],
    );
  }
}
