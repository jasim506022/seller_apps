import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller_apps/model/product_model.dart';

import '../data/response/service/data_firebase_service.dart';
import '../res/app_function.dart';

class ProductRepository {
  final _dataFirebaseService = DataFirebaseService();

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchProductSnapshots(
      {required String category}) {
    try {
      return _dataFirebaseService.fetchCategoryProducts(category: category);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Future<void> deleteProductSnapshot({required String productId}) async {
    try {
      await _dataFirebaseService.deleteProductByIdSnapshot(
          productId: productId);
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> similarProductSnapshot(
      {required ProductModel productModel}) {
    try {
      return _dataFirebaseService.fetchSimilarProducts(
          productModel: productModel);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }
}
