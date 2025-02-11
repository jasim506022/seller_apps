import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_apps/controller/profile_controller.dart';

import '../../../model/profile_model.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_string.dart';
import '../../loading_widget/loading_profile_header_widget.dart';
import 'user_profile_content.dart';

class HomeProfileHeaderWidget extends StatelessWidget {
  const HomeProfileHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();
    final image = AppConstants.sharedPreference
        ?.getString(AppString.imageurlSharedPreference);
    var name = AppConstants.sharedPreference
        ?.getString(AppString.nameSharedPreference);
    var email = AppConstants.sharedPreference
        ?.getString(AppString.emailSharedPreference);

    if ((image == null || image.isEmpty) &&
        (name == null || name.isEmpty) &&
        (email == null || email.isEmpty)) {
      return FutureBuilder(
        future: profileController.fetchUserProfile(),
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
                email: profileModel.email!,
              );
            }
          }
          return const LoadingProfileHeaderWidget();
        },
      );
    } else {
      return UserProfileContent(imageUrl: image!, name: name!, email: email!);
    }
  }
}
