import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/add_product_controller.dart';
import '../../../res/apps_color.dart';
import 'single_image_remove_widget.dart';

class GridImageListWidget extends StatelessWidget {
  const GridImageListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var addProductController = Get.find<AddProductController>();
    return Obx(
      () => Container(
        height: 0.25.sh,
        width: 1.sw,
        padding: EdgeInsets.all(3.r),
        margin: EdgeInsets.all(5.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.green, width: 3.h),
        ),
        child: GridView.builder(
          itemCount: addProductController.selectedProductImagesList.length,
          itemBuilder: (context, index) {
            return SingleImageRemove(
              index: index,
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.5,
            crossAxisSpacing: 15.w,
            mainAxisSpacing: 15.h,
            crossAxisCount: 2,
          ),
        ),
      ),
    );
  }
}
