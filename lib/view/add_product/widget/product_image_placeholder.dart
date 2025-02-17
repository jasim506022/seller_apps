import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seller_apps/res/app_function.dart';
import 'package:seller_apps/widget/app_button.dart';

import '../../../res/app_string.dart';
import 'image_selecting_dialog.dart';

/// **Placeholder UI when no product images are selected**
/// - Displays an icon and a button to prompt the user to add images.
/// - Clicking the button opens an `ImageSelectionDialog`.
class ProductImagePlaceholder extends StatelessWidget {
  const ProductImagePlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.addNewProduct)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 200.h,
            ),
            AppsFunction.verticalSpace(20),
            AppButton(
              width: .7.sw,
              title: AppStrings.addNewProduct,

              /// **Opens the Image Selection Dialog**
              onPressed: () => Get.dialog(
                const ImageSelectionDialog()
              ),
            )
          ],
        ),
      ),
    );
  }
}


/*
#: ProductImagePlaceholder  Place HOlder Means
*/