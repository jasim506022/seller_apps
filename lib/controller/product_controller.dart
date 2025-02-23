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

// Get the instance of CategoryManagerController
  final CategoryManagerController categoryManagerController =
      Get.find<CategoryManagerController>();

// Injecting the ProductRepository via the constructor
  ProductController({required this.repository});

  /// **Fetch Product Snapshots**
  /// Retrieves a stream of product data from Firestore for the selected category.
  ///
  /// Returns a [Stream] of product data snapshots.
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchProductSnapshots() {
    try {
      return repository.fetchProductSnapshots(
          category: categoryManagerController.selectedAllCategory.value);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  /// **Show Delete Product Dialog**
  /// Displays a confirmation dialog before deleting a product from Firestore.
  /// Allows for an optional callback after the deletion to perform additional actions.
  ///
  /// - [productId] : The ID of the product to be deleted.
  /// - [onDeleted] : Optional callback executed after successful deletio
  Future<void> showDeleteProductDialog({required String productId}) async {
    Get.dialog(
      ShowAlertDialogWidget(
        title: AppStrings.areYouWantDeleteTitle,
        content: AppStrings.deleteMessage,
        onConfirmPressed: () async {
          try {
            await repository.deleteProductSnapshot(productId: productId);
            Get.toNamed(RoutesName.mainPage, arguments: 1);
            AppsFunction.flutterToast(msg: AppStrings.deleteSuccessToast);
          } catch (e) {
            Get.back();
            _handleException(e);
          }
        },
        icon: Icons.delete,
      ),
    );
  }

  /// **Fetch Similar Products**
  /// Retrieves a stream of similar products based on the provided product model.
  ///
  /// Returns a [Stream] of similar product data snapshots.
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSimilarProductsStream(
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

  /// **Handle Exception**
  /// Displays an error dialog with details about the exception.
  ///
  /// - [e] : The exception that occurred.
  void _handleException(dynamic e) {
    if (e is AppException) {
      Get.dialog(
        ErrorDialogWidget(
          icon: AppIcons.warningIcon,
          title: e.title!,
          content: e.message,
          buttonText: AppStrings.btnOkay,
        ),
      );
    }
  }
}
