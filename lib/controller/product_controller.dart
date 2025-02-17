import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../model/product_model.dart';
import '../repository/product_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../res/routes/routes_name.dart';
import '../widget/error_dialog_widget.dart';
import '../widget/show_alert_dialog_widget.dart';
import 'category_manager_controller.dart';

/// **ProductController**
/// Handles fetching, deleting, and managing products in Firestore.
class ProductController extends GetxController {
  final ProductRepository repository;

  ProductController({required this.repository});

  final categoryManagerController = Get.find<CategoryManagerController>();

  /// **Fetch Product Snapshots**
  /// Retrieves product data from Firestore based on the selected category.

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchProductSnapshots() {
    try {
      return repository.productSnapshots(
          category: categoryManagerController.selectedAllCategory.value);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  /// **Show Delete Confirmation Dialog**
  /// Displays a confirmation dialog before deleting a product.
  ///
  /// ✅ **Enhancement**: Allows an **optional callback** after deletion instead of **hardcoding navigation**.
  Future<void> showDeleteProductDialog({required String productId}) async {
    Get.dialog(
      ShowAlertDialogWidget(
        title: AppStrings.areYouWantDelete,
        content: AppStrings.deleteMessage,
        onConfirmPressed: () async {
          try {
            await repository.deleteProductSnapshot(productId: productId);
            Get.toNamed(RoutesName.mainPage, arguments: 0);
            AppsFunction.flutterToast(msg: AppStrings.deleteSuccessFully);
          } catch (e) {
            Get.back();
            _handleException(e);
          }
        },
        icon: Icons.delete,
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSimilarProductsStream(
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
          buttonText: AppStrings.okay,
        ),
      );
    }
  }
}
