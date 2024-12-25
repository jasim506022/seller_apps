import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seller_apps/res/app_function.dart';

import '../../../res/app_asset/image_asset.dart';
import '../../../res/apps_text_style.dart';

class AppSignInPageIntro extends StatelessWidget {
  const AppSignInPageIntro({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppsFunction.verticalSpace(50),
        Image.asset(
          ImagesAsset.appLogoImage,
          height: 140.h,
          width: 140.h,
        ),
        AppsFunction.verticalSpace(10),
        Text(title, style: AppsTextStyle.largeTitleTextStyle),
        AppsFunction.verticalSpace(10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: AppsTextStyle.largeNormalText,
        ),
        AppsFunction.verticalSpace(40),
      ],
    );
  }
}
