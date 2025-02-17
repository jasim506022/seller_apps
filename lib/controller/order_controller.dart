import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../const/cart_function.dart';
import '../model/app_exception.dart';
import '../model/order_model.dart';
import '../repository/order_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_asset/image_asset.dart';
import '../res/app_string.dart';
import '../widget/error_dialog_widget.dart';

/// Controller responsible for managing order-related operations.
class OrderController extends GetxController {
  OrderRepository orderRepository;

  /// Constructor for initializing the `OrderRepository`.
  OrderController(this.orderRepository);

  /// Fetches orders based on the provided order status.
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchOrders(
      {required String orderStatus}) {
    try {
      return orderRepository.orderSnapshots(orderStatus: orderStatus);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  /// Fetches products related to a specific order.
  Future<QuerySnapshot<Map<String, dynamic>>> fatchOrderProduct(
      {required OrderModel orderModel}) async {
    try {
      var productIDList =
          CartFunctions.separteOrderProductIdList(orderModel.productIds);
      return await orderRepository.orderProductSnapshots(
          productIDList: productIDList);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  /// Fetches seller's products based on product list and seller ID.
  Future<QuerySnapshot<Map<String, dynamic>>> fatchSellerProduct(
      {required List<String> productList, required String sellerId}) async {
    try {
      return await orderRepository.sellerProductSnapshot(
          productList: productList, sellerId: sellerId);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  /// Returns a stream of seller orders based on [sellerList].
  Stream<QuerySnapshot<Map<String, dynamic>>> fatchSellerOrder(
      {required List<String> sellerList}) {
    try {
      return orderRepository.sellerOrderSnapshot(sellerList: sellerList);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  /// Stores order status details including images and titles.
  Map<String, Map<String, String>> orderStatusData = {
    "normal": {
      "imageAsset": AppImage.sendProductImage,
      "title": AppStrings.sendProductAdmin,
    },
    "handover": {
      "imageAsset": AppImage.handOverImage,
      "title": AppStrings.handoverProduct,
    },
    "delivery": {
      "imageAsset": AppImage.deliveryProductImage,
      "title": AppStrings.deliveryProduct,
    },
    "complete": {
      "imageAsset": AppStrings.completeOrder,
      "title": AppStrings.orderSuccesfullyCompleted,
    },
  };

  /// Fetches user details snapshot.
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchUserDetails(
      {required String userId}) {
    try {
      return orderRepository.delivaryUserDetailsSnaphots(userId: userId);
    } catch (e) {
      {
        _handleException(e);
        rethrow;
      }
    }
  }

  /// Fetches the delivery address snapshot based on the order.
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchUserDeliveryAddress(
      {required OrderModel orderModel}) {
    try {
      return orderRepository.userDeliveryAddressSnapshot(
          userId: orderModel.orderBy, addressId: orderModel.addressId);
    } catch (e) {
      {
        _handleException(e);
        rethrow;
      }
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
