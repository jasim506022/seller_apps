import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../../res/apps_color.dart';
import '../../../widget/profile_photo_option_sheet_widget.dart';

/// A widget that allows users to pick or update their profile picture.
class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Retrieve the AuthController instance from GetX
    final AuthController authController = Get.find<AuthController>();

    return InkWell(
      // When the container is tapped, show the bottom sheet for photo options
      onTap: () => Get.bottomSheet(
          backgroundColor: Theme.of(context).cardColor,
          const PhotoOptionSheetWidget()),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.red, width: 3.w)),
        child: Obx(() {
          // Observe changes in the selected profile photo
          var selectedPhoto =
              authController.selectImageController.selectPhoto.value;
          // Display the CircleAvatar widget with selected image (if available)
          return CircleAvatar(
            radius: 0.2.sw,
            backgroundImage:
                selectedPhoto != null ? FileImage(selectedPhoto) : null,
            backgroundColor: AppColors.backgroundLight,
            // If no image is selected, show an "Add Photo" icon

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

/*
Naming classes with Widget at the end is a common convention for Flutter widgets, making it clearer that this is a UI element.

# Understand Bottomsheet
#:  // ✅ Using `null` instead of `SizedBox.shrink()` for clarity

*/