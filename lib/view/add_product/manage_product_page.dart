import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/add_product_controller.dart';
import '../../model/productsmodel.dart';

import '../../res/app_function.dart';
import '../../res/app_string.dart';
import 'widget/add_product_widget.dart';
import 'widget/detault_add_proudct_widget.dart';

class ManageProductPage extends StatefulWidget {
  const ManageProductPage({
    super.key,
  });

  @override
  State<ManageProductPage> createState() => _ManageProductPageState();
}

class _ManageProductPageState extends State<ManageProductPage> {
  late bool isUpdate;
  final addProductController = Get.find<AddProductController>();
  late ProductModel productModel;
  @override
  void initState() {
    var data = Get.arguments;

    isUpdate = data?[AppString.isUpdate] ?? false;

    if (isUpdate) {
      productModel = data![AppString.productModel];
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => addProductController.updateProductsField(productModel),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppsFunction.setSystemUIOverlayStyle(context);

    return Obx(() {
      final isPlaceholderVisible =
          addProductController.selectedProductImagesList.isEmpty &&
              !isUpdate &&
              !addProductController.isProductUpdated.value;

      return isPlaceholderVisible
          ? const DefaultAddProductView()
          : AddEditProductForm(
              isUpdate: isUpdate,
            );
    });
  }
}
