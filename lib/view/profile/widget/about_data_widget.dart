import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_apps/res/app_string.dart';

import '../../../controller/profile_controller.dart';
import 'about_data_item.dart';

class AboutDataWidget extends StatelessWidget {
  const AboutDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return Obx(() {
      var profileModel = profileController.profileModel.value;

      // Show loading indicator if any of the fields are null
      if ([
        profileModel.name,
        profileModel.phone,
        profileModel.email,
        profileModel.address
      ].contains(null)) {
        return const Center(child: CircularProgressIndicator());
      }

      // Profile data to be displayed
      final profileData = [
        {
          'icon': Icons.person,
          'label': AppString.name,
          'value': profileModel.name,
        },
        {
          'icon': Icons.phone,
          'label': AppString.phone,
          'value': "0${profileModel.phone}",
        },
        {
          'icon': Icons.email,
          'label': AppString.email,
          'value': profileModel.email,
        },
        {
          'icon': Icons.place,
          'label': AppString.address,
          'value': profileModel.address,
        },
      ];

      return Column(
        children: profileData
            .map((item) => AboutDataItem(
                  item: item,
                ))
            .toList(),
      );
    });
  }
}
