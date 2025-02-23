import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/profile_controller.dart';
import '../../../res/apps_color.dart';
import '../../../widget/profile_photo_option_sheet_widget.dart';

/// **ProfileImageSectionWidget**
///
/// This widget displays the **user's profile image**.
/// - If `isEditMode` is **true**, the user can update the image.
/// - If `isEditMode` is **false**, it displays the profile image in **view-only mode**.
/// - Uses `FancyShimmerImage` for better image loading.
/// - Allows selecting a new profile image via `Get.bottomSheet()`.
class ProfileImageSectionWidget extends StatelessWidget {
  /// Indicates whether the profile is in **edit mode**.
  final bool isEditMode;

  /// The current **profile image URL**.
  final String imageUrl;

  const ProfileImageSectionWidget(
      {super.key, required this.isEditMode, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    /// Retrieve the `ProfileController` instance.
    final ProfileController profileController = Get.find<ProfileController>();

// Return a stack with an editable image if `isEditMode` is true.
    // Otherwise, show the profile image in view-only mode.
    return Stack(
      children: [
        /// Display **profile image** inside a bordered container.
        Obx(() =>
            _buildImageContainer(child: _buildImageWidget(profileController))),

        /// If in **edit mode**, show a camera button to update the image.
        if (isEditMode)
          Positioned(
              bottom: 5.h,
              right: 5.w,
              child: _buildSelectImageButton(context, profileController)),
      ],
    );
  }

  /// **Builds the profile image container**
  ///
  /// - Displays the **profile image** inside a circular container.
  /// - Adds a **border** around the image for styling.
  Widget _buildImageContainer({required Widget child}) {
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

  /// **Builds the image selection button (shown in edit mode)**
  ///
  /// - Opens the `PhotoOptionSheetWidget` when pressed.
  /// - Updates the profile image selection state.
  Widget _buildSelectImageButton(
      BuildContext context, ProfileController profileController) {
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

  /// **Builds the profile image widget**
  ///
  /// - Displays the **selected image** if available.
  /// - Otherwise, loads the **default profile image URL**.
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
