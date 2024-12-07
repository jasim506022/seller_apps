import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_apps/model/order_model.dart';
import 'package:seller_apps/repository/delivary_repository.dart';

import '../view/other/pushnotification.dart';

class DeliveryController extends GetxController {
  Map<String, Map<String, String>> orderStatusData = {
    "normal": {
      "imageAsset": "asset/order/readyfordeliver.png",
      "title": "Please Sent your product on Admin",
    },
    "delivery": {
      "imageAsset": "asset/order/readyfordeliver.png",
      "title": "Thanks For send product to Admin",
    },
    "complete": {
      "imageAsset": "asset/order/order complete.jpg",
      "title": "Order has been successfully completed",
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

  void handleOrderUpdate(String status, String orderId, String userId) {
    final notification = PushNotification();
    notification.sendNotificationUser(
      "Bangladesh",
      "Indian",
      "Order status updated to $status",
    );

    if (status == "normal") updateOrderStatus("delivery", orderId, userId);
    if (status == "delivery") updateOrderStatus("complete", orderId, userId);
  }

  Future<void> updateOrderStatus(
      String status, String orderId, String userId) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .update({"status": status});
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("orders")
        .doc(orderId)
        .update({"status": status});
    update(); // Notify GetX listeners of changes
  }
}
