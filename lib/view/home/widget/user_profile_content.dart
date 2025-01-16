import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/app_function.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';

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
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.yellow, width: 2),
                  shape: BoxShape.circle),
              height: 70.h,
              width: 70.h,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(color: AppColors.white),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            AppsFunction.horizontalSpace(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppsTextStyle.largeTitleTextStyleForOnBoarding
                      .copyWith(color: AppColors.white),
                ),
                Text(
                  email,
                  style: AppsTextStyle.mediumBoldText
                      .copyWith(color: AppColors.white),
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
