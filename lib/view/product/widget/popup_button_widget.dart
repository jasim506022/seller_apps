import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/global.dart';
import '../../../controller/product_controller.dart';
import '../../../model/productsmodel.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/routes/routes_name.dart';

class PopupButtonWidget extends StatelessWidget {
  const PopupButtonWidget({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    var productController = Get.put(ProductController());
    return PopupMenuButton<ProductSelect>(
      color: Theme.of(context).cardColor,
      iconColor: Colors.white,
      onSelected: (ProductSelect product) async {
        if (product.name == "detele") {
          if (!(await AppsFunction.verifyInternetStatus())) {
            productController.deleteProductSnapshot(
                productId: productModel.productId!);
          }
        } else {
          if (!(await AppsFunction.verifyInternetStatus())) {
            Get.toNamed(RoutesName.uploadProduct,
                arguments: {"isUpdate": true, "productModel": productModel});
          }
        }
      },
      itemBuilder: (BuildContext context) {
        return <PopupMenuItem<ProductSelect>>[
          PopupMenuItem(
            value: ProductSelect.detele,
            child: Text("Delete", style: AppsTextStyle.mediumBoldText),
          ),
          PopupMenuItem(
              value: ProductSelect.edit,
              child: Text("Edit", style: AppsTextStyle.mediumBoldText)),
        ];
      },
    );
  }
}
