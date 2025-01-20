import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/app_function.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/user_avatar_widget.dart';

class UserProfileContent extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String email;

  const UserProfileContent({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            UserAvatarWidget(
              imageUrl: imageUrl,
              height: 70,
            ),
            AppsFunction.horizontalSpace(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    name,
                    style: AppsTextStyle.titleHomeProfileheader
                        .copyWith(color: AppColors.white),
                  ),
                ),
                FittedBox(
                  child: Text(
                    email,
                    style: AppsTextStyle.mediumBoldText
                        .copyWith(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.notifications, color: AppColors.white, size: 25.h),
            AppsFunction.horizontalSpace(10),
            Icon(Icons.person, color: AppColors.white, size: 25.h),
          ],
        ),
      ],
    );
  }
}
