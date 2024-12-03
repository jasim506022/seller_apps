import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_apps/model/order_model.dart';
import 'package:seller_apps/repository/delivary_repository.dart';

class DeliveryController extends GetxController {
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
