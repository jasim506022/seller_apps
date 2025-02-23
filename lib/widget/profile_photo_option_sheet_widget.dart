import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/select_image_controller.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../res/apps_color.dart';
import '../res/apps_text_style.dart';

/// A bottom sheet widget that provides options for selecting a profile photo.

class PhotoOptionSheetWidget extends StatelessWidget {
  const PhotoOptionSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Retrieve the selectImageController instance from GetX
    final SelectImageController selectImageController =
        Get.find<SelectImageController>();
    return Padding(
      padding: EdgeInsets.all(20.0.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Ensures the bottom sheet fits content
        children: [
          _buildDragHandle(context),
          AppsFunction.verticalSpacing(10),
          Align(
              alignment: Alignment.center,
              child:
                  Text(AppStrings.selectPhoto, style: AppsTextStyle.titleText)),
          AppsFunction.verticalSpacing(10),
          _buildPhotoOptions(selectImageController)
        ],
      ),
    );
  }

  Align _buildDragHandle(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 100.w,
        height: 4.h,
        decoration: BoxDecoration(
            color: Theme.of(context).indicatorColor,
            borderRadius: BorderRadius.circular(2.r)),
      ),
    );
  }

  Widget _buildPhotoOptions(SelectImageController selectImageController) {
    return Wrap(
      spacing: 30.w,
      runSpacing: 10.h,
      children: [
        _buildPhotoOptionButton(AppStrings.btnCamera, Icons.camera_alt, () {
          _onPhotoOptionSelected(selectImageController, ImageSource.camera);
        }),
        _buildPhotoOptionButton(AppStrings.btnGallery, Icons.photo_album, () {
          _onPhotoOptionSelected(selectImageController, ImageSource.gallery);
        }),
      ],
    );
  }

  /// Handles photo option selection and closes the bottom sheet.
  void _onPhotoOptionSelected(
      SelectImageController controller, ImageSource source) {
    Get.back();
    controller.selectImage(imageSource: source);
  }

  /// Builds a photo option button with icon and label.
  Widget _buildPhotoOptionButton(
      String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.green)),
              child: Icon(
                icon,
                color: AppColors.green,
              ),
            ),
            AppsFunction.horizontalSpacing(30),
            Text(
              title,
              style: AppsTextStyle.button.copyWith(color: AppColors.green),
            ),
          ],
        ),
      ),
    );
  }
}

/*
#: Understand Wrap
*/

/*
instread of Wrap
/// Builds the photo selection options.
  Widget _buildPhotoOptions(SelectImageController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPhotoOptionButton(AppStrings.camera, Icons.camera_alt, () {
          _onPhotoOptionSelected(controller, ImageSource.camera);
        }),
        _buildPhotoOptionButton(AppStrings.gallery, Icons.photo_album, () {
          _onPhotoOptionSelected(controller, ImageSource.gallery);
        }),
      ],
    );
  }
*/