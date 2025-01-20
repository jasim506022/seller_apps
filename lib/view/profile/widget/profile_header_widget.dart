import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/app_constants.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';

import '../../../res/internet_utilis.dart';
import '../../../res/routes/routes_name.dart';
import '../../../widget/custom_round_action_button_widget.dart';
import '../../../widget/user_avatar_widget.dart';

class ProifleHeaderWidget extends StatelessWidget {
  const ProifleHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 153.h,
        width: 1.sw,
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              UserAvatarWidget(
                height: 130,
                imageUrl: AppConstants.sharedPreference!
                    .getString(AppString.imageurlSharedPreference)!,
              ),
              AppsFunction.horizontalSpace(30),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppConstants.defaultHeightSpace.h),
                  child: _buildProfileDetails(),
                ),
              )
            ],
          ),
        ));
  }

  // Build Profile Details Section
  Widget _buildProfileDetails() {
    final String name = AppConstants.sharedPreference!
        .getString(AppString.nameSharedPreference)!;

    final String email = AppConstants.sharedPreference!
        .getString(AppString.emailSharedPreference)!;

/*
final String email = AppConstants.sharedPreference
            ?.getString(AppString.emailSharedPreference)
*/
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppsTextStyle.titleTextStyle,
        ),
        Text(
          email,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppsTextStyle.subTitleTextStyle,
        ),
        SizedBox(height: AppConstants.defaultHeightSpace),
        CustomRoundActionButtonWidget(
          title: AppString.editProfile,
          onTap: () async {
            if (!await NetworkUtili.verifyInternetStatus()) {
              Get.toNamed(RoutesName.editProfilePage, arguments: true);
            }
          },
        ),
      ],
    );
  }

 
}
