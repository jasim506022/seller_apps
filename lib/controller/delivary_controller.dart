import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/order_model.dart';
import '../repository/delivary_repository.dart';

class DeliveryController extends GetxController {
  Map<String, Map<String, String>> orderStatusData = {
    "normal": {
      "imageAsset": "asset/order/readyfordeliver.png",
      "title": "Please send your products to the admin",
    },
    "handover": {
      "imageAsset": "asset/order/readyfordeliver.png",
      "title": "Handover the product to the admin",
    },
    "delivery": {
      "imageAsset": "asset/order/readyfordeliver.png",
      "title": "Product ready for delivery",
    },
    "complete": {
      "imageAsset": "asset/order/order complete.jpg",
      "title": "The order has been successfully completed",
    },
  };

  DelivaryRepository repository;

  DeliveryController(this.repository);

  Stream<DocumentSnapshot<Map<String, dynamic>>> delivaryUserDetailsSnaphots(
      {required String userId}) {
    return repository.delivaryUserDetailsSnaphots(userId: userId);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> userDeliveryAddressSnapshot(
      {required OrderModel orderModel}) {
    return repository.userDeliveryAddressSnapshot(
        userId: orderModel.orderBy, addressId: orderModel.addressId);
  }
}
