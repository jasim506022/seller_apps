import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_apps/controller/profile_controller.dart';

import '../../../model/profile_model.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_string.dart';
import '../../loading_widget/loading_profile_header_widget.dart';
import 'user_profile_content.dart';

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
            return const LoadingProfileHeaderWidget();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            var data = snapshot.data!.data();
            if (data != null) {
              var profileModel = ProfileModel.fromMap(data);
              return UserProfileContent(
                  imageUrl: profileModel.imageurl!,
                  name: profileModel.name!,
                  email: profileModel.email!);
            }
          }
          return const LoadingProfileHeaderWidget();
        },
      );
    } else {
      return UserProfileContent(imageUrl: image!, name: name!, email: email!);
    }
  }

/*
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
}
/*
class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

    return Obx(() {
      if (profileController.loadingController.loading.value) {
        return const Center(
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
*/
