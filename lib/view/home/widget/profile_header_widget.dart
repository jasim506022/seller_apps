import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seller_apps/controller/profile_controller.dart';

import 'package:seller_apps/res/apps_color.dart';

import '../../../res/apps_text_style.dart';

/*
class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();
    var image = AppConstants.sharedPreference!
        .getString(AppString.imageurlSharedPreference);
    var name = AppConstants.sharedPreference!
        .getString(AppString.nameSharedPreference);
    var email = AppConstants.sharedPreference!
        .getString(AppString.emailSharedPreference);

    if (image == null && name == null && email == null) {
      return FutureBuilder(
        future: profileController.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Bangladesh");
          } else if (snapshot.hasData) {
            var profileModel =
                ProfileModel.fromMap(snapshot.data as Map<String, dynamic>);
                 return _buildProfileWidget(profileModel.imageurl!, profileModel.name!,  email!);
          }
          return CircularProgressIndicator();
        },
      );
    } else {
      return _buildProfileWidget(image!, name!, email!);
    }
  }

  Row _buildProfileWidget(String image, String name, String email) {
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
                  imageUrl: image,
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
                  name,
                  style: AppsTextStyle.largeTitleTextStyle
                      .copyWith(color: AppColors.white),
                ),
                Text(
                  email,
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

*/

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

    return Obx(() {
      if (profileController.isLoading.value) {
        print("bangladesh");
        return Center(
          child: CircularProgressIndicator(color: AppColors.deepGreen),
        );
      }

      final profile = profileController.profileModel.value;

      return UserProfileContent(
        imageUrl: profile.imageurl!,
        name: profile.name!,
        email: profile.email!,
      );
    });
  }
}

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
            SizedBox(
              height: 70.h,
              width: 70.h,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      CircularProgressIndicator(color: AppColors.white),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppsTextStyle.largeTitleTextStyle
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
            SizedBox(width: 10.w),
            Icon(Icons.person, color: AppColors.white, size: 25.h),
          ],
        ),
      ],
    );
  }
}
