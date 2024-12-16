import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    Widget verticalSpace(double height) => SizedBox(height: height.h);
    return Column(
      children: [
        verticalSpace(50),
        Image.asset(
          ImagesAsset.appLogoImage,
          height: 140.h,
          width: 140.h,
        ),
        verticalSpace(10),
        Text(title, style: AppsTextStyle.largeTitleTextStyle),
        verticalSpace(10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: AppsTextStyle.largeNormalText,
        ),
        verticalSpace(40),
      ],
    );
  }
}
//     android:windowSoftInputMode="adjustResize"