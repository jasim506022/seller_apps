import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/category_controller.dart';
import '../../res/app_constants.dart';
import '../../widget/drop_down_category_widget.dart';
import 'widget/product_list_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.find<CategoryController>();
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Products",
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.h),
        child: Column(
          children: [
            DropdownCategoryWidget(
              list: AppConstants.allCategoryList,
              value: categoryController.category.value,
              onChanged: (value) {
                categoryController.setCategory(value!.toString());
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            const Expanded(child: ProductListWidget())
          ],
        ),
      ),
    );
  }
}
