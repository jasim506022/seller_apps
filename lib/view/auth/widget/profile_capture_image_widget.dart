import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/sign_up_controller.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_color.dart';
import '../../../widget/profile_photo_option_sheet_widget.dart';

class ProfileImageCaptureWidget extends StatelessWidget {
  const ProfileImageCaptureWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var signUpController = Get.find<SignUpController>();

    return InkWell(
      onTap: () async {
        if (!(await AppsFunction.verifyInternetStatus())) {
          Get.bottomSheet(
              backgroundColor: AppColors.white,
              const ProfilePhotoOptionSheetWidget());
        }
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.grey, width: 3.w)),
        child: Obx(() {
          var imageFile =
              signUpController.selectImageController.selectPhoto.value;
          return CircleAvatar(
            radius: 0.2.sw,
            backgroundImage: imageFile == null ? null : FileImage(imageFile),
            backgroundColor: AppColors.backgroundLightColor,
            child: imageFile == null
                ? Icon(
                    Icons.add_photo_alternate,
                    size: 0.2.sw,
                    color: AppColors.grey,
                  )
                : null,
          );
        }),
      ),
    );
  }
}
