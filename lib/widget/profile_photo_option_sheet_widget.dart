import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/select_image_controller.dart';
import '../res/app_string.dart';
import '../res/apps_color.dart';
import '../res/apps_text_style.dart';

class ProfilePhotoOptionSheetWidget extends StatelessWidget {
  const ProfilePhotoOptionSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget verticalSpace(double height) => SizedBox(height: height.h);
    return Padding(
      padding: EdgeInsets.all(20.0.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Shrink to fit content
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 100.w,
              height: 3.h,
              decoration: BoxDecoration(
                  color: Theme.of(context).indicatorColor,
                  borderRadius: BorderRadius.circular(2.r)),
            ),
          ),
          verticalSpace(10),
          Align(
              alignment: Alignment.center,
              child: Text(AppString.selectPhoto,
                  style: AppsTextStyle.titleTextStyle)),
          verticalSpace(10),
          _selectPhotoOption()
        ],
      ),
    );
  }

  Row _selectPhotoOption() {
    var selectImageController = Get.find<SelectImageController>();
    return Row(
      children: [
        _buildTakePhotoOption(AppString.camera, Icons.camera_alt, () {
          Get.back();
          selectImageController.selectImage(imageSource: ImageSource.camera);
        }),
        SizedBox(
          width: 30.w,
        ),
        _buildTakePhotoOption(AppString.gallery, Icons.photo_album, () {
          Get.back();
          selectImageController.selectImage(imageSource: ImageSource.gallery);
        }),
      ],
    );
  }

  Padding _buildTakePhotoOption(
      String title, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(
              height: 5.w,
            ),
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
