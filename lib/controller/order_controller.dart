import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../const/cart_function.dart';
import '../model/app_exception.dart';
import '../model/order_model.dart';
import '../repository/order_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_string.dart';
import '../widget/error_dialog_widget.dart';

class OrderController extends GetxController {
  OrderRepository orderRepository;

  OrderController(this.orderRepository);

  /// Returns a stream of orders based on the provided status.
  Stream<QuerySnapshot<Map<String, dynamic>>> fatchOrders(
      {required String orderStatus}) {
    try {
      return orderRepository.orderSnapshots(orderStatus: orderStatus);
    } catch (e) {
      _handleException(e);
      rethrow;
      //      return const Stream.empty();

    }
  }

  /// Fetches order products based on the provided [orderModel].
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
      // return Future.error(e);
    }
  }

  /// Fetches seller's products based on provided [productList] and [sellerId].
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

  /// Returns a stream of order address based on [addressId].
  Stream<DocumentSnapshot<Map<String, dynamic>>> fatchOrderAddress(
      {required String addressId}) {
    try {
      return orderRepository.orderAddressSnapsot(addressId: addressId);
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
