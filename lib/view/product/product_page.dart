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
/// This screen allows users to view and filter a list of products based on their selected category.
class ProductPage extends StatelessWidget {
  /// Constructor for ProductPage.
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Find the CategoryManagerController using GetX
    final CategoryManagerController categoryController =
        Get.find<CategoryManagerController>();
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(AppStrings.productsTitle)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            /// Dropdown to filter products by category.
            /// The dropdown allows users to select a category from a predefined list.
            CustomDropdownWidget(
              items: AppConstants.allCategories,
              value: categoryController.selectedAllCategory.value,
              onChanged: (category) {
                if (category != null) {
                  categoryController.updateAllCategory(category.toString());
                  // Updates the selected category in the controller.
                }
              },
            ),
            AppsFunction.verticalSpacing(10),

            /// Displays the product list.
            /// The product list is dynamically updated based on the selected category.
            const Expanded(child: ProductGridViewStream())
          ],
        ),
      ),
    );
  }
}
