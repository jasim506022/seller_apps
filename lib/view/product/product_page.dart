import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/category_manager_controller.dart';
import '../../res/app_constants.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../widget/custom_drop_down_widget.dart';
import 'widget/product_list_widget.dart';

/// Represents the product listing screen where users can filter products by category.

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Find the CategoryManagerController using GetX
    final controller = Get.find<CategoryManagerController>();
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(AppStrings.productTitle)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            /// Dropdown to filter products by category
            CustomDropdownWidget(
              items: AppConstants.allCategories,
              value: controller.selectedAllCategory.value,
              onChanged: (value) {
                if (value != null) {
                  controller.updateAllCategory(value.toString());
                }
              },
            ),
            AppsFunction.verticalSpace(10),

            /// Displays the product list
            const Expanded(child: ProductListWidget())
          ],
        ),
      ),
    );
  }
}

/*
#: ProductPage	ProductScreen	"Screen" is more standard for pages in Flutter.
*/