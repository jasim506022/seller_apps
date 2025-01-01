import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/app_asset/image_asset.dart';
import '../../../res/app_string.dart';
import '../../../res/routes/routes_name.dart';
import 'grid_view_item.dart';

class GridViewList extends StatelessWidget {
  const GridViewList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: GridView.count(
        primary: false,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 15.h,
        childAspectRatio: .95,
        crossAxisCount: 2,
        children: [
          GridViewItem(
            image: ImagesAsset.allProductImage,
            text: AppString.allProduct,
            onTap: () => Get.offAndToNamed(RoutesName.mainPage, arguments: 1),
          ),
          GridViewItem(
              image: ImagesAsset.totalsalesImages,
              text: AppString.totalSales,
              onTap: () => Get.toNamed(
                    RoutesName.totalSales,
                  )),
          GridViewItem(
            image: ImagesAsset.runningOrderImages,
            text: AppString.runningOrder,
            onTap: () => Get.toNamed(
              RoutesName.runningOrder,
            ),
          ),
          GridViewItem(
              image: ImagesAsset.completeOrderImages,
              text: AppString.completeOrder,
              onTap: () => Get.toNamed(
                    RoutesName.completeOrderPage,
                  )),
        ],
      ),
    );
  }
}
