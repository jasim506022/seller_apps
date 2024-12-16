import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_apps/res/app_constants.dart';

import '../../../controller/product_controller.dart';
import '../../../model/productsmodel.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/internet_utilis.dart';
import '../../../res/routes/routes_name.dart';

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
      color: Theme.of(context).cardColor,
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
