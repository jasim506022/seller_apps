import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/select_image_controller.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../res/apps_color.dart';
import '../res/apps_text_style.dart';

class PhotoOptionSheetWidget extends StatelessWidget {
  const PhotoOptionSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SelectImageController selectImageController =
        Get.find<SelectImageController>();
    return Padding(
      padding: EdgeInsets.all(20.0.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 100.w,
              height: 4.h,
              decoration: BoxDecoration(
                  color: Theme.of(context).indicatorColor,
                  borderRadius: BorderRadius.circular(2.r)),
            ),
          ),
          AppsFunction.verticalSpacing(10),
          Align(
              alignment: Alignment.center,
              child: Text(AppStrings.selectPhoto,
                  style: AppsTextStyle.titleTextStyle)),
          AppsFunction.verticalSpacing(10),
          _buildPhotoOptions(selectImageController)
        ],
      ),
    );
  }

  Widget _buildPhotoOptions(SelectImageController selectImageController) {
    return Wrap(
      spacing: 30.w,
      runSpacing: 10.h,
      children: [
        _buildPhotoOptionButton(AppStrings.camera, Icons.camera_alt, () {
          Get.back();
          selectImageController.selectImage(imageSource: ImageSource.camera);
        }),
        _buildPhotoOptionButton(AppStrings.gallery, Icons.photo_album, () {
          Get.back();
          selectImageController.selectImage(imageSource: ImageSource.gallery);
        }),
      ],
    );
  }

  /// Builds a photo option button with icon and label.
  Padding _buildPhotoOptionButton(
      String title, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
      child: InkWell(
        onTap: onTap,
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
              style: AppsTextStyle.buttonTextStyle
                  .copyWith(color: AppColors.green),
            ),
          ],
        ),
      ),
    );
  }
}
