import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller_apps/model/productsmodel.dart';

import '../data/response/service/data_firebase_service.dart';
import '../res/app_function.dart';

class ProductRepository {
  final _dataFirebaseService = DataFirebaseService();
  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots(
      {required String category}) {
    try {
      return _dataFirebaseService.productSnapshots(category: category);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Future<void> deleteProductSnapshot({required String productId}) async {
    await _dataFirebaseService.deleteProductSnapshot(productId: productId);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> similarProductSnapshot(
      {required ProductModel productModel}) {
    return _dataFirebaseService.similarProductSnapshot(
        productModel: productModel);
  }
}
