import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/profile_controller.dart';
import '../../../res/apps_color.dart';
import '../../../widget/profile_photo_option_sheet_widget.dart';

class ProfileImageSectionWidget extends StatelessWidget {
  final bool isEditMode;

  const ProfileImageSectionWidget({super.key, required this.isEditMode});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

// Return a stack with an editable image if `isEditMode` is true.
    // Otherwise, show the profile image in view-only mode.
    return isEditMode
        ? Stack(
            children: [
              // Observes changes to the selected photo in the controller.

              Obx(() {
                final image =
                    profileController.selectImageController.selectPhoto.value;
                return _buildProfileImage(
                  child: image == null
                      ? FancyShimmerImage(
                          imageUrl:
                              profileController.profileModel.value.imageurl!,
                          errorWidget: const Icon(Icons.error),
                        )
                      : CircleAvatar(backgroundImage: FileImage(image)),
                );
              }),
              Positioned(
                bottom: 5,
                right: 5,
                child: _buildSelectImageButton(context),
              ),
            ],
          )
        : _buildProfileImage(
            child: FancyShimmerImage(
              imageUrl: profileController.profileModel.value.imageurl ?? "",
              errorWidget: const Icon(Icons.error),
            ),
          );
  }

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

  Widget _buildSelectImageButton(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: Colors.red.shade400, shape: BoxShape.circle),
      child: IconButton(
        icon: const Icon(Icons.camera_alt, color: AppColors.white),
        onPressed: () {
          Get.bottomSheet(
              backgroundColor: Theme.of(context).cardColor,
              const ProfilePhotoOptionSheetWidget());
        },
      ),
    );
  }
}
