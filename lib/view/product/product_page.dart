import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/category_manager_controller.dart';
import '../../res/app_constants.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../widget/custom_drop_down_widget.dart';
import 'widget/product_list_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryManagerController = Get.find<CategoryManagerController>();
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(AppString.productTitle)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.h),
        child: Column(
          children: [
            CustomDropdownWidget(
              items: AppConstants.allCategories,
              value: categoryManagerController.selectedAllCategory.value,
              onChanged: (value) {
                if (value != null) {
                  categoryManagerController.updateAllCategory(value.toString());
                }
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
