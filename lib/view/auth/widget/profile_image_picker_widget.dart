import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../../res/apps_color.dart';
import '../../../widget/profile_photo_option_sheet_widget.dart';

class ProfileImagePickerWidget extends StatelessWidget {
  const ProfileImagePickerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return InkWell(
      onTap: () => Get.bottomSheet(
          backgroundColor: AppColors.white,
          const ProfilePhotoOptionSheetWidget()),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.red, width: 3.w)),
        child: Obx(() {
          var selectedPhoto =
              authController.selectImageController.selectPhoto.value;
          return CircleAvatar(
            radius: 0.2.sw,
            backgroundImage:
                selectedPhoto != null ? FileImage(selectedPhoto) : null,
            backgroundColor: AppColors.backgroundLight,
            child: selectedPhoto == null
                ? Icon(
                    Icons.add_photo_alternate,
                    size: 0.2.sw,
                    color: AppColors.grey,
                  )
                : const SizedBox.shrink(),
          );
        }),
      ),
    );
  }
}
