import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/app_function.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/user_avatar_widget.dart';

/// Displays user profile information in the home header.
class UserProfileHeader extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String email;

  const UserProfileHeader({
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
        _buildUserInfo(),
        _buildIconsRow(),
      ],
    );
  }

  /// Builds the user avatar and profile details.
  Row _buildUserInfo() {
    return Row(
      children: [
        UserAvatarWidget(
          imageUrl: imageUrl,
          size: 70
        ),
        AppsFunction.horizontalSpace(15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
                child: Text(name,
                    style: AppsTextStyle.titleHomeProfileheader
                        .copyWith(color: AppColors.white))),
            FittedBox(
                child: Text(email,
                    style: AppsTextStyle.mediumBoldText
                        .copyWith(color: AppColors.white)))
          ],
        ),
      ],
    );
  }

  /// Builds the notification and profile icons.
  Row _buildIconsRow() {
    return Row(
      children: [
        Icon(Icons.notifications, color: AppColors.white, size: 25.h),
        AppsFunction.horizontalSpace(10),
        Icon(Icons.person, color: AppColors.white, size: 25.h),
      ],
    );
  }
}
