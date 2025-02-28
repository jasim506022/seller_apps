import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/manage_product_controller.dart';
import '../../model/product_model.dart';

import '../../res/app_function.dart';
import '../../res/app_string.dart';
import 'widget/manage_product_form.dart';
import 'widget/product_image_placeholder.dart';

/// **Page for Adding or Editing a Product**
/// - Displays a form to add a new product or edit an existing one.
/// - Uses `AddProductController` for state management with GetX
class ManageProductPage extends StatefulWidget {
  const ManageProductPage({super.key});

  @override
  State<ManageProductPage> createState() => _ManageProductPageState();
}

class _ManageProductPageState extends State<ManageProductPage> {
  /// Indicates whether the page is in 'edit mode' or 'add mode'.
  /// `true` for edit mode, `false` for add mode.
  late bool isEditMode;

  /// Controller for handling ManageProductController logic
  late final ManageProductController manageProductController;

  /// Stores the product being edited (only if in edit mode)
  late ProductModel productModel;
  @override
  void initState() {
    // Retrieve arguments passed to the page
    final arguments = Get.arguments;
    isEditMode = arguments?[AppStrings.isUpdateArgument] ?? false;

    /// Get the `ManageProductController` instance for managing AddProduct.
    manageProductController = Get.find<ManageProductController>();

    // If in edit mode, initialize productModel with passed product details
    if (isEditMode) {
      productModel = arguments![AppStrings.productModelArgument];

      // Update the fields of the form with existing product data
      manageProductController.updateProductsFields(productModel);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Set system UI styles (e.g., status bar and navigation bar appearance)
    AppsFunction.setSystemUIOverlayStyle(context);

// Return a widget based on whether a product has been selected or not
    return Obx(() {
      final isPlaceholderVisible =
          manageProductController.selectedImagesList.isEmpty &&
              !isEditMode &&
              !manageProductController.hasProductsChanged.value;

      // Show placeholder if no product images are selected and the page is in 'add' mode.
      return isPlaceholderVisible
          ? const ProductImagePlaceholder()
          : ManageProductForm(
              isEditMode: isEditMode,
            );
    });
  }
}
