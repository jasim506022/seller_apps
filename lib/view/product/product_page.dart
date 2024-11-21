import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/global.dart';
import '../../controller/category_controller.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            DropdownCategoryWidget(
              list: allCategoryList,
              value: categoryController.getCategory,
              onChangeds: (value) {
                categoryController.setCategory(category: value!.toString());
              },
            ),
            const Expanded(child: ProductListWidget())
          ],
        ),
      ),
    );
  }
}
