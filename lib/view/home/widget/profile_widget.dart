import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seller_apps/res/apps_color.dart';

import '../../../res/app_constants.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              height: 70.h,
              width: 70.h,
              child: ClipOval(
                child: CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(
                    backgroundColor: AppColors.white,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageUrl: AppConstants.sharedPreference!
                      .getString(AppString.imageurlSharedPreference)!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.h,
            ),
            FittedBox(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppConstants.sharedPreference!
                      .getString(AppString.nameSharedPreference)!,
                  style: AppsTextStyle.largeTitleTextStyle
                      .copyWith(color: AppColors.white),
                ),
                Text(
                  AppConstants.sharedPreference!
                      .getString(AppString.nameSharedPreference)!,
                  style: AppsTextStyle.mediumBoldText
                      .copyWith(color: AppColors.white),
                ),
              ],
            )),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.notifications,
              color: AppColors.white,
              size: 25.h,
            ),
            SizedBox(
              width: 10.w,
            ),
            Icon(
              Icons.person,
              color: AppColors.white,
              size: 25.h,
            ),
          ],
        )
      ],
    );
  }
}
