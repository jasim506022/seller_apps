import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/response/service/data_firebase_service.dart';

class DelivaryRepository {
  final _dataFirebaseService = DataFirebaseService();
  Stream<DocumentSnapshot<Map<String, dynamic>>> delivaryUserDetailsSnaphots(
      {required String userId}) {
    return _dataFirebaseService.delivaryUserDetailsSnaphots(userId: userId);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> userDeliveryAddressSnapshot(
      {required String userId, required String addressId}) {
    return _dataFirebaseService.userDeliveryAddressSnapshot(
        userId: userId, addressId: addressId);
  }
}
