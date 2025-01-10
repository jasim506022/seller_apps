import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seller_apps/res/app_string.dart';

import 'image_selecting_dialog.dart';
import '../../../widget/custom_elevated_widget.dart';

class DefaultAddProductView extends StatelessWidget {
  const DefaultAddProductView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppString.addNewProduct)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 0.23.sh,
            ),
            CustomElevatedButton(
              title: AppString.addNewProduct,
              onPressed: () {
                Get.dialog(
                  const ImageSelectionDialog(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
