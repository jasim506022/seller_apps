import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/app_function.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/user_avatar_widget.dart';

/// **User Profile Section**
/// - Displays the user's profile picture, name, email, and quick action icons (notifications and profile).
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
        // Profile details like name, email, and avatar
        _buildUserInfo(),
        // Icons for notifications and profile access
        _buildIconsRow(),
      ],
    );
  }

  /// **Builds the Profile Details Section**
  /// - Includes the user's avatar, name, and email.
  Row _buildUserInfo() {
    return Row(
      children: [
        UserAvatarWidget(imageUrl: imageUrl, diameter: 70),
        AppsFunction.horizontalSpacing(15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
                child: Text(name,
                    style: AppsTextStyle.homeProfileTitle
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

  /// **Builds Action Icons for Notifications and Profile**
  /// - Includes icons for notifications and the profile page.
  Row _buildIconsRow() {
    return Row(
      children: [
        Icon(Icons.notifications, color: AppColors.white, size: 25.h),
        AppsFunction.horizontalSpacing(10),
        Icon(Icons.person, color: AppColors.white, size: 25.h),
      ],
    );
  }
}

/*
Why use it crossAxisAlignment: CrossAxisAlignment.start,
*/