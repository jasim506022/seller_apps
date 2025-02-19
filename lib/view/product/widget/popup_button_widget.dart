import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/product_controller.dart';
import '../../../model/product_model.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/network_utilis.dart';
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
        onSelected: (ProductAction productAction) =>
            _handleAction(productAction),
        itemBuilder: (BuildContext context) => _buildMenuItems());
  }

  /// Handles the selected action from the popup menu
  /// Performs either delete or update based on the selected action.
  Future<void> _handleAction(ProductAction productAction) async {
    NetworkUtils.executeWithInternetCheck(action: () async {
      final ProductController productController = Get.find<ProductController>();
      switch (productAction) {
        case ProductAction.delete:
          await productController.showDeleteProductDialog(
              productId: productModel.productId!);

          break;

        case ProductAction.update:
          Get.toNamed(RoutesName.uploadAndUpdateProduct, arguments: {
            AppStrings.isUpdate: true,
            AppStrings.productModel: productModel,
          });
          break;
      }
    });
  }

  /// Builds the menu items (Delete, Update) for the product action menu.
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
}
