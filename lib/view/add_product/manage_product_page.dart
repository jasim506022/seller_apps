import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/add_product_controller.dart';
import '../../model/product_model.dart';

import '../../res/app_function.dart';
import '../../res/app_string.dart';
import 'widget/add_product_widget.dart';
import 'widget/detault_add_proudct_widget.dart';

/// **Page for Adding or Editing a Product**
/// - Displays a form to add a new product or edit an existing one.
/// - Uses `AddProductController` for state management with GetX
class ManageProductPage extends StatefulWidget {
  const ManageProductPage({
    super.key,
  });

  @override
  State<ManageProductPage> createState() => _ManageProductPageState();
}

class _ManageProductPageState extends State<ManageProductPage> {
  /// Whether the page is in edit mode (true) or add mode (false)
  late bool isUpdate;
  final addProductController = Get.find<AddProductController>();

  /// Stores the product being edited (only if in edit mode)
  late ProductModel productModel;
  @override
  void initState() {
    // Retrieve arguments passed to the page
    final arguments = Get.arguments;

    isUpdate = arguments?[AppStrings.isUpdate] ?? false;

    if (isUpdate) {
      productModel = arguments![AppStrings.productModel];
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

/*
#: Why use final in argument
#: WidgetsBinding.instance.addPostFrameCallback

*/