import 'dart:io';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/manage_product_controller.dart';
import '../../../res/apps_color.dart';

class SingleImageRemoveWidget extends StatelessWidget {
  const SingleImageRemoveWidget({super.key, required this.index});

  final int index;
  @override
  Widget build(BuildContext context) {
    /// Access the ManageProductController using GetX
    final ManageProductController manageProductController =
        Get.find<ManageProductController>();

    /// Retrieve the selected image (can be a File or a URL String)
    var selectedImage = manageProductController.selectedImagesList[index];
    return Stack(
      children: [
        _buildImageContainer(context, selectedImage), // Image display
        _buildRemoveButton(manageProductController), // Remove button
      ],
    );
  }

  /// **Builds the remove button positioned at the top-right corner.**
  ///
  /// - Clicking this button removes the selected image from the list.
  ClipRRect _buildImageContainer(BuildContext context, selectedImage) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor, width: 1),
          ),
          child: SizedBox(
            height: 0.25.sh,
            width: 0.25.sh,
            child: selectedImage is String
                ? FancyShimmerImage(
                    imageUrl: selectedImage, boxFit: BoxFit.contain)
                : Image.file(File(selectedImage.path), fit: BoxFit.contain),
          )),
    );
  }

  /// **Builds the image container with a border and rounded corners.**
  ///
  /// - Supports displaying images from a **URL** (using `FancyShimmerImage`) or **local storage** (`Image.file`).
  /// - Uses `BoxFit.contain` to prevent distortion.
  Positioned _buildRemoveButton(
      ManageProductController manageProductController) {
    return Positioned(
      top: 2,
      right: 2,
      child: InkWell(
        onTap: () => manageProductController.removeProductImageFile(index),
        child: Container(
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.close,
            color: AppColors.red,
            size: 25.h,
          ),
        ),
      ),
    );
  }
}
