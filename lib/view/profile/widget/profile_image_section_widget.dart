import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/profile_controller.dart';
import '../../../res/apps_color.dart';
import '../../../widget/profile_photo_option_sheet_widget.dart';

class ProfileImageSectionWidget extends StatelessWidget {
  final bool isEditMode;
  final String imageUrl;

  const ProfileImageSectionWidget(
      {super.key, required this.isEditMode, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

// Return a stack with an editable image if `isEditMode` is true.
    // Otherwise, show the profile image in view-only mode.
    return Stack(
      children: [
        Obx(() {
          return _buildProfileImage(
              child: _buildImageWidget(profileController));
        }),
        if (isEditMode)
          Positioned(
              bottom: 5, right: 5, child: _buildSelectImageButton(context)),
      ],
    );
  }

  /// Builds the profile image view

  Widget _buildProfileImage({required Widget child}) {
    return Container(
      height: 180.h,
      width: 180.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.red, width: 2),
      ),
      child: ClipOval(child: child),
    );
  }

  /// Builds the image selection button

  Widget _buildSelectImageButton(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return Container(
      decoration:
          BoxDecoration(color: Colors.red.shade400, shape: BoxShape.circle),
      child: IconButton(
        icon: const Icon(Icons.camera_alt, color: AppColors.white),
        onPressed: () {
          profileController.isDataChanged(true);
          Get.bottomSheet(
              backgroundColor: Theme.of(context).cardColor,
              const PhotoOptionSheetWidget());
        },
      ),
    );
  }

  /// Builds the image widget depending on whether an image is selected
  Widget _buildImageWidget(ProfileController profileController) {
    final selectedImage =
        profileController.selectImageController.selectPhoto.value;
    return selectedImage == null
        ? FancyShimmerImage(
            imageUrl: imageUrl,
            errorWidget: const Icon(Icons.error),
          )
        : CircleAvatar(backgroundImage: FileImage(selectedImage));
  }
}
