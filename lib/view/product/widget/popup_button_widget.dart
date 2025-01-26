import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/product_controller.dart';
import '../../../model/productsmodel.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/internet_utilis.dart';
import '../../../res/routes/routes_name.dart';

class ProductActionPopupMenu extends StatelessWidget {
  const ProductActionPopupMenu({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ProductAction>(
      color: Theme.of(context).cardColor,
      iconColor: Colors.white,
      onSelected: (ProductAction action) => _handleAction(
        action,
      ),
      itemBuilder: (BuildContext context) => _buildMenuItems(),
    );
  }

  /// Handles the selected action from the popup menu
  Future<void> _handleAction(
    ProductAction action,
  ) async {
    NetworkUtili.internetCheckingWFunction(function: () async {
      final ProductController productController = Get.find<ProductController>();
      switch (action) {
        case ProductAction.delete:
          await productController.showDeleteProductDialog(
            productId: productModel.productId!,
          );

          break;

        case ProductAction.update:
          Get.toNamed(
            RoutesName.uploadAndUpdateProduct,
            arguments: {
              AppString.isUpdate: true,
              AppString.productModel: productModel,
            },
          );
          break;
      }
    });
  }

  /// Builds the menu items for the popup button
  List<PopupMenuItem<ProductAction>> _buildMenuItems() {
    return [
      PopupMenuItem(
        value: ProductAction.delete,
        child: Text(
          AppString.delete,
          style: AppsTextStyle.mediumBoldText,
        ),
      ),
      PopupMenuItem(
        value: ProductAction.update,
        child: Text(
          AppString.update,
          style: AppsTextStyle.mediumBoldText,
        ),
      ),
    ];
  }
}

/// Enum for product actions
enum ProductAction { delete, update }
