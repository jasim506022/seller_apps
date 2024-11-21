import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_apps/res/routes/routes_name.dart';

import '../model/app_exception.dart';
import '../model/productsmodel.dart';
import '../repository/product_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../view/auth/widget/error_dialog_widget.dart';
import '../widget/show_alert_dialog_widget.dart';
import 'category_controller.dart';

class ProductController extends GetxController {
  ProductRepository repository = ProductRepository();
  final categoryController = Get.find<CategoryController>();

  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots() {
    try {
      return repository.productSnapshots(
          category: categoryController.getCategory);
    } catch (e) {
      if (e is AppException) {
        Get.dialog(
          ErrorDialogWidget(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: AppString.okay,
          ),
        );
      }

      rethrow;
    }
  }

  Future<void> deleteProductSnapshot({required String productId}) async {
    Get.dialog(
      CustomAlertDialogWidget(
        title: "Are You want to Delete",
        content:
            "Do you Want to Delete The Product Produc. If you delete the Product it can not be undo",
        yesOnPress: () async {
          try {
            await repository.deleteProductSnapshot(productId: productId);

            Get.toNamed(RoutesName.mainPage, arguments: 0);
            AppsFunction.flutterToast(msg: "Delete Succesffully");
          } catch (error) {
            AppsFunction.flutterToast(msg: "An Error Occured: $error");
          }
        },
        icon: Icons.delete,
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> similarProductSnapshot(
      {required ProductModel productModel}) {
    return repository.similarProductSnapshot(productModel: productModel);
  }
}
