import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/product_controller.dart';
import '../../../model/product_model.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/network_utilis.dart';
import '../../../res/routes/routes_name.dart';

/// A widget that displays a popup menu with product actions (**Delete, Update**).

class ProductOptionsMenu extends StatelessWidget {
  const ProductOptionsMenu({
    super.key,
    required this.productModel,
  });

  /// The product model associated with this menu.

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ProductAction>(
        color: Theme.of(context).cardColor,
        iconColor: Colors.white,
        onSelected: (ProductAction productAction) =>
            _handleAction(productAction),
        itemBuilder: (BuildContext context) => _buildMenuItems());
  }

  /// **Handles the selected menu action.**
  ///
  /// - **Delete:** Calls `showDeleteProductDialog()` from `ProductController`.
  /// - **Update:** Navigates to the product update screen.
  ///
  /// This function ensures that an **internet connection** is available before performing the action.
  Future<void> _handleAction(ProductAction productAction) async {
    NetworkUtils.executeWithInternetCheck(action: () async {
      // Find the ProductController using GetX

      final ProductController productController = Get.find<ProductController>();
      // Calls the delete confirmation dialog

      if (productAction == ProductAction.delete) {
        await productController.showDeleteProductDialog(
          productId: productModel.productId!,
        );
      } else {
        // Navigates to the product update screen

        Get.toNamed(RoutesName.uploadAndUpdateProduct, arguments: {
          AppStrings.isUpdateArgument: true,
          AppStrings.productModelArgument: productModel,
        });
      }
    });
  }

  // **Builds the list of menu items for product actions.**
  ///
  /// - **Delete:** Removes the product.
  /// - **Update:** Edits the product details.
  ///
  /// Returns a list of `PopupMenuItem` widgets.
  List<PopupMenuEntry<ProductAction>> _buildMenuItems() {
    return ProductAction.values.map((action) {
      return PopupMenuItem(
        value: action,
        child: Text(
          action == ProductAction.delete
              ? AppStrings.btnDelete
              : AppStrings.btnUpdate,
          style: AppsTextStyle.mediumBoldText,
        ),
      );
    }).toList();
  }
}
/*
#: Where is best for using if else or switch 
#: Better use This:
List<PopupMenuItem<ProductAction>> _buildMenuItems() {
    return [
      PopupMenuItem(
        value: ProductAction.delete,
        child: Text(
          AppStrings.btnDelete,
          style: AppsTextStyle.mediumBoldText,
        ),
      ),
      PopupMenuItem(
        value: ProductAction.update,
        child: Text(
          AppStrings.btnUpdate,
          style: AppsTextStyle.mediumBoldText,
        ),
      ),
    ];
  }
*/