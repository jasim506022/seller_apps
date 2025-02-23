import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/manage_product_controller.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';

/// **ImageSelectionDialog**
/// - Displays a dialog for selecting an image source (Camera or Gallery).
/// - Calls `uploadProductImage()` from `AddProductController` based on user selection.
class ImagePickerDialog extends StatelessWidget {
  const ImagePickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final ManageProductController manageProductController =
        Get.find<ManageProductController>();
    return SimpleDialog(
      title:
          Text(AppStrings.selectPhotoTitle, style: AppsTextStyle.dialogTitle),
      children: [
        _buildDialogOption(() {
          manageProductController.pickProductImage(ImageSource.camera);
        }, AppStrings.takePhotoCameraTitle),
        _buildDialogOption(() {
          manageProductController.pickProductImage(ImageSource.gallery);
        }, AppStrings.chooseFromGalleryTitle),
        _buildDialogOption(() {}, AppStrings.btnCancel, true),
      ],
    );
  }

  /// **Creates an individual dialog option with tap functionality.**
  SimpleDialogOption _buildDialogOption(VoidCallback onPressed, String title,
      [bool isCancel = false]) {
    return SimpleDialogOption(
      onPressed: () {
        Get.back();
        onPressed();
      },
      child: Text(title,
          style: isCancel
              ? AppsTextStyle.mediumBoldText.copyWith(color: AppColors.red)
              : AppsTextStyle.mediumBoldText),
    );
  }
}
