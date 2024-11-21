import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/response/service/data_firebase_service.dart';
import '../res/app_function.dart';

class OrderRepository {
  final _dataFirebaseService = DataFirebaseService();

  Stream<QuerySnapshot<Map<String, dynamic>>> orderSnapshots(
      {required String orderStatus}) {
    try {
      return _dataFirebaseService.orderSnapshots(orderStatus: orderStatus);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

/*
  Future<QuerySnapshot<Map<String, dynamic>>> orderProductSnapshots(
      {required List<String> listProductID}) async {
    try {
      return await _dataFirebaseService.orderProductSnapshots(
          listProductID: listProductID);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> sellerProductSnapshot(
      {required List<String> productList, required String sellerId}) async {
    try {
      return await _dataFirebaseService.sellerProductSnapshot(
          productList: productList, sellerId: sellerId);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> orderAddressSnapsot(
      {required String addressId}) {
    try {
      return _dataFirebaseService.orderAddressSnapsot(addressId: addressId);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> sellerOrderSnapshot(
      {required List<String> sellerList}) {
    try {
      return _dataFirebaseService.sellerOrderSnapshot(sellerList: sellerList);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

*/

}