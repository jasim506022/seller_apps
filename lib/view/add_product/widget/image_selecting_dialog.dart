import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_apps/res/app_string.dart';

import '../../../controller/add_product_controller.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';

class ImageSelectionDialog extends StatelessWidget {
  const ImageSelectionDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var addProductController = Get.find<AddProductController>();
    return SimpleDialog(
      title: Text(
        AppStrings.selectedImage,
        style: AppsTextStyle.titleTextStyle.copyWith(color: AppColors.green),
      ),
      children: [
        _buildDialogOption(() {
          addProductController.uploadProductImage(ImageSource.camera);
        }, AppStrings.captureWithCamera),
        _buildDialogOption(() {
          addProductController.uploadProductImage(ImageSource.gallery);
        }, AppStrings.captureWithGallery),
        _buildDialogOption(() {}, AppStrings.cancel,
            AppsTextStyle.titleTextStyle.copyWith(color: AppColors.red)),
      ],
    );
  }

  SimpleDialogOption _buildDialogOption(VoidCallback onPressed, String title,
      [TextStyle? textSyle]) {
    return SimpleDialogOption(
      onPressed: () {
        onPressed();
        Get.back();
      },
      child: Text(title, style: textSyle ?? AppsTextStyle.mediumBoldText),
    );
  }
}
