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
  final ProductRepository repository;

  ProductController({required this.repository});

  final categoryManagerController = Get.find<CategoryManagerController>();

// Okay
  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots() {
    try {
      return repository.productSnapshots(
          category: categoryManagerController.selectedForAllCategory.value);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  Future<void> showDeleteProductDialog({required String productId}) async {
    Get.dialog(
      ShowAlertDialogWidget(
        title: AppString.areYouWantDelete,
        content: AppString.deleteMessage,
        onYesPressed: () async {
          try {
            await repository.deleteProductSnapshot(productId: productId);

            Get.toNamed(RoutesName.mainPage, arguments: 0);
            AppsFunction.flutterToast(msg: AppString.deleteSuccessFully);
          } catch (e) {
            Get.back();
            _handleException(e);
          }
        },
        icon: Icons.delete,
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> similarProductSnapshot(
      {required ProductModel productModel}) {
    try {
      return repository.similarProductSnapshot(productModel: productModel);
    } catch (e) {
      if (e is AppException) {
        _handleException(e);
      }

      rethrow;
    }
  }

  /// Handles exceptions by showing a dialog with error details
  void _handleException(dynamic e) {
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
  }
}
