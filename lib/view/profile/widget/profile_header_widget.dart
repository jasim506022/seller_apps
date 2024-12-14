import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../const/const.dart';
import '../../../const/global.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';

import '../../../res/routes/routes_name.dart';
import '../../../widget/custom_round_action_button_widget.dart';

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
              _buildProfileImage(),
              SizedBox(
                width: 30.w,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: defaulHieighSpace.h),
                  child: _buildProfileDetails(),
                ),
              )
            ],
          ),
        ));
  }

  Column _buildProfileDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(sharedPreference!.getString(AppString.nameSharedPreference)!,
            maxLines: 1, style: AppsTextStyle.titleTextStyle),
        Text(sharedPreference!.getString(AppString.emailSharedPreference)!,
            style: AppsTextStyle.subTitleTextStyle),
        SizedBox(
          height: defaulHieighSpace,
        ),
        CustomRoundActionButtonWidget(
          title: "Edit Profile",
          onTap: () async {
            if (!(await AppsFunction.verifyInternetStatus())) {
              Get.toNamed(RoutesName.editProfilePage, arguments: true);
            }
          },
        )
      ],
    );
  }

  Container _buildProfileImage() {
    return Container(
        height: 130.h,
        width: 130.h,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.red, width: 3.w)),
        child: ClipOval(
          child: FancyShimmerImage(
            imageUrl: sharedPreference!
                .getString(AppString.imageurlSharedPreference)!,
            errorWidget: const Icon(Icons.error),
          ),
        ));
  }
}
