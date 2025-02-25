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

/// Controller responsible for managing order-related operations, including:
/// - Fetching orders
/// - Retrieving order details (products, sellers, users, addresses)
/// - Handling order statuses and associated data
/// - Managing errors and exception handling
class OrderController extends GetxController {
  /// Repository instance for handling database operations related to orders.
  OrderRepository repository;

  /// Constructor for initializing `OrderRepository`.
  OrderController(this.repository);

  /// Stores order status details including corresponding images and titles.
  final RxMap<String, Map<String, String>> orderStatusData = {
    "normal": {
      "imageAsset": AppImage.sendProductImage,
      "title": AppStrings.sendToAdminMessage,
    },
    "handover": {
      "imageAsset": AppImage.handOverImage,
      "title": AppStrings.handoverToAdminMessage,
    },
    "delivery": {
      "imageAsset": AppImage.deliveryProductImage,
      "title": AppStrings.productReadyForDeliveryMessage,
    },
    "complete": {
      "imageAsset": AppImage.completeOrderImages,
      "title": AppStrings.orderCompletedMessage,
    },
  }.obs;

  /// Retrieves the corresponding image and title for a given order status.
  ///
  /// - `status`: The order status (e.g., `"normal"`, `"handover"`, `"delivery"`, `"complete"`).
  /// - Returns a `Map<String, String>` containing the **imageAsset** and **title**.
  Map<String, String>? getStatusData(String status) {
    return orderStatusData[status] ?? orderStatusData["normal"];
  }

  /// Fetches a stream of orders filtered by the given order status.
  ///
  /// - `orderStatus`: The status of the orders to be retrieved.
  /// - Returns a `Stream<QuerySnapshot<Map<String, dynamic>>>` of order data.
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchOrders(
      {required String orderStatus}) {
    try {
      return repository.orderSnapshots(orderStatus: orderStatus);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  /// Fetches products related to a specific order.
  ///
  /// - `orderModel`: The order whose products are being fetched.
  /// - Returns a `Future<QuerySnapshot<Map<String, dynamic>>>` containing the product data.
  Future<QuerySnapshot<Map<String, dynamic>>> fetchOrderProducts(
      {required OrderModel orderModel}) async {
    try {
      var productIDList =
          CartFunctions.separateOrderProductIds(orderModel.productIds);
      return await repository.orderProductSnapshots(
          productIDList: productIDList);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  /// Fetches products sold by a specific seller based on the product list.
  ///
  /// - `productList`: List of product IDs belonging to the seller.
  /// - `sellerId`: The ID of the seller.
  /// - Returns a `Future<QuerySnapshot<Map<String, dynamic>>>` containing the seller's product data.
  Future<QuerySnapshot<Map<String, dynamic>>> fetchSellerProducts(
      {required List<String> productList, required String sellerId}) async {
    try {
      return await repository.sellerProductSnapshot(
          productList: productList, sellerId: sellerId);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  /// Retrieves a stream of orders associated with a specific list of sellers.
  ///
  /// - `sellerList`: A list of seller IDs.
  /// - Returns a `Stream<QuerySnapshot<Map<String, dynamic>>>` of order data for the sellers.
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSellerOrder(
      {required List<String> sellerList}) {
    try {
      return repository.sellerOrderSnapshot(sellerList: sellerList);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  /// Fetches a stream of user details based on the provided user ID.
  ///
  /// - `userId`: The ID of the user whose details are being fetched.
  /// - Returns a `Stream<DocumentSnapshot<Map<String, dynamic>>>` containing user details.
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchUserDetails(
      {required String userId}) {
    try {
      return repository.deliveryUserDetailsSnapshots(userId: userId);
    } catch (e) {
      {
        _handleException(e);
        rethrow;
      }
    }
  }

  /// Fetches a stream of the delivery address for a given order.
  ///
  /// - `orderModel`: The order for which the delivery address is being retrieved.
  /// - Returns a `Stream<DocumentSnapshot<Map<String, dynamic>>>` containing the delivery address data.
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchUserDeliveryAddress(
      {required OrderModel orderModel}) {
    try {
      return repository.userDeliveryAddressSnapshot(
          userId: orderModel.orderBy, addressId: orderModel.addressId);
    } catch (e) {
      {
        _handleException(e);
        rethrow;
      }
    }
  }

  /// Handles exceptions by displaying an error dialog with relevant details.
  ///
  /// - `e`: The exception encountered during execution.
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
