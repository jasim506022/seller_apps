import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/category_controller.dart';
import '../../res/app_constants.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../widget/drop_down_category_widget.dart';
import 'widget/product_list_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.find<CategoryManagerController>();
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(AppString.productTitle)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.h),
        child: Column(
          children: [
            DropdownWidget(
              items: AppConstants.allCategories,
              value: categoryController.selectedForAllCategory.value,
              onChanged: (value) {
                categoryController.updateAllCategory(value!.toString());
              },
            ),
            AppsFunction.verticalSpace(10),
            const Expanded(child: ProductListWidget())
          ],
        ),
      ),
    );
  }
}
