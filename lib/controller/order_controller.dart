import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../repository/order_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../view/auth/widget/error_dialog_widget.dart';

class OrderController extends GetxController {
  OrderRepository orderRepository;

  OrderController(this.orderRepository);

  Stream<QuerySnapshot<Map<String, dynamic>>> orderSnapshots(
      {required String orderStatus}) {
    try {
      return orderRepository.orderSnapshots(orderStatus: orderStatus);
    } catch (e) {
      if (e is AppException) {
        Get.dialog(
          ErrorDialogWidget(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay",
          ),
        );
      }
      rethrow;
    }
  }
  /*

  Future<QuerySnapshot<Map<String, dynamic>>> orderProductSnapshots(
      {required List<String> listProductID}) async {
    try {
      return await orderRepository.orderProductSnapshots(
          listProductID: listProductID);
    } catch (e) {
      if (e is AppException) {
        Get.dialog(
          ErrorDialogWidget(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay",
          ),
        );
      }
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> sellerProductSnapshot(
      {required List<String> productList, required String sellerId}) async {
    try {
      return await orderRepository.sellerProductSnapshot(
          productList: productList, sellerId: sellerId);
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
      rethrow;
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> orderAddressSnapsot(
      {required String addressId}) {
    try {
      return orderRepository.orderAddressSnapsot(addressId: addressId);
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> sellerOrderSnapshot(
      {required List<String> sellerList}) {
    try {
      return orderRepository.sellerOrderSnapshot(sellerList: sellerList);
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
      rethrow;
    }
  }

*/


}