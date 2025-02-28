import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/manage_product_controller.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import 'single_image_remove_widget.dart';

/// A widget that displays a grid of selected product images with the ability to remove them.

class GridImageListWidget extends StatelessWidget {
  const GridImageListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    /// Access the ManageProductController using GetX

    final ManageProductController manageProductController =
        Get.find<ManageProductController>();
    return Obx(() {
      /// List of selected images

      List<dynamic> selectedImages = manageProductController.selectedImagesList;
      return Container(
          height: 0.25.sh,
          width: 1.sw,
          padding: EdgeInsets.all(3.r),
          margin: EdgeInsets.all(5.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: AppColors.green, width: 3.h),
          ),

          /// Show empty state if no images are selected, otherwise show the grid

          child: selectedImages.isEmpty
              ? _buildEmptyState()
              : _buildImageGrid(selectedImages));
    });
  }

  /// **Displays an empty state when no images are selected.**
  ///
  /// - Shows a message in the center indicating that no images are selected.
  Widget _buildEmptyState() {
    return Center(
      child: Text(
        AppStrings.noImageSelectedToast,
        style: AppsTextStyle.mediumBoldText.copyWith(color: AppColors.red),
      ),
    );
  }

  /// **Builds the grid of selected images.**
  Widget _buildImageGrid(List<dynamic> images) {
    return GridView.builder(
      itemCount: images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
      ),
      itemBuilder: (context, index) => SingleImageRemoveWidget(index: index),
    );
  }
}
