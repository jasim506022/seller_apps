import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_apps/res/app_string.dart';

import '../../../controller/product_controller.dart';
import '../../../model/productsmodel.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/internet_utilis.dart';
import '../../../res/routes/routes_name.dart';

/*
class PopupButtonWidget extends StatelessWidget {
  const PopupButtonWidget({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    return PopupMenuButton<ProductAction>(
      iconColor: Colors.white,
      onSelected: (ProductAction product) async {
        if (product.name == "detele") {
          if (!(await NetworkUtili.verifyInternetStatus())) {
            productController.deleteProductSnapshot(
                productId: productModel.productId!);
          }
        } else {
          if (!(await NetworkUtili.verifyInternetStatus())) {
            Get.toNamed(RoutesName.uploadProduct,
                arguments: {"isUpdate": true, "productModel": productModel});
          }
        }
      },
      itemBuilder: (BuildContext context) {
        return <PopupMenuItem<ProductAction>>[
          PopupMenuItem(
            value: ProductAction.delete,
            child: Text("Delete", style: AppsTextStyle.mediumBoldText),
          ),
          PopupMenuItem(
              value: ProductAction.edit,
              child: Text("Edit", style: AppsTextStyle.mediumBoldText)),
        ];
      },
    );
  }
}
*/

class ProductActionPopupMenu extends StatelessWidget {
  const ProductActionPopupMenu({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();

    return PopupMenuButton<ProductAction>(
      color: Theme.of(context).cardColor,
      iconColor: Colors.white,
      onSelected: (ProductAction action) =>
          _handleAction(context, action, productController),
      itemBuilder: (BuildContext context) => _buildMenuItems(),
    );
  }

  /// Handles the selected action from the popup menu
  Future<void> _handleAction(
    BuildContext context,
    ProductAction action,
    ProductController productController,
  ) async {
    // Check internet connectivity once for both actions
    if (!(await NetworkUtili.verifyInternetStatus())) {
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
    }
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
