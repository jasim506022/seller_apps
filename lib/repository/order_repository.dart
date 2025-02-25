import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/response/service/data_firebase_service.dart';
import '../res/app_function.dart';

/// Repository responsible for fetching order-related data from Firebase.
///
/// This repository interfaces with `DataFirebaseService` to:
/// - Retrieve order snapshots based on status.
/// - Fetch product and seller-related order details.
/// - Retrieve user and delivery address information.
/// - Handle errors consistently across Firebase operations.

class OrderRepository {
  /// Instance of `DataFirebaseService` for Firebase operations.

  final DataFirebaseService _dataFirebaseService = DataFirebaseService();

  /// Retrieves a stream of orders filtered by the provided order status.
  ///
  /// - `orderStatus`: The status of the orders to fetch.
  /// - Returns a `Stream<QuerySnapshot<Map<String, dynamic>>>` containing order data.
  Stream<QuerySnapshot<Map<String, dynamic>>> orderSnapshots(
      {required String orderStatus}) {
    try {
      return _dataFirebaseService.orderSnapshots(orderStatus: orderStatus);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  /// Fetches products associated with an order based on product IDs.
  ///
  /// - `productIDList`: List of product IDs belonging to the order.
  /// - Returns a `Future<QuerySnapshot<Map<String, dynamic>>>` containing product data.
  Future<QuerySnapshot<Map<String, dynamic>>> orderProductSnapshots(
      {required List<String> productIDList}) async {
    try {
      return await _dataFirebaseService.orderProductSnapshots(
          productIDList: productIDList);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  /// Fetches a seller’s products from an order.
  ///
  /// - `productList`: List of product IDs that belong to the seller.
  /// - `sellerId`: The seller’s ID.
  /// - Returns a `Future<QuerySnapshot<Map<String, dynamic>>>` containing seller product data.

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

  /// Retrieves a stream of an order’s delivery address.
  ///
  /// - `addressId`: The ID of the order’s delivery address.
  /// - Returns a `Stream<DocumentSnapshot<Map<String, dynamic>>>` containing address data.
  Stream<DocumentSnapshot<Map<String, dynamic>>> orderAddressSnapshot(
      {required String addressId}) {
    try {
      return _dataFirebaseService.orderAddressSnapsot(addressId: addressId);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  /// Retrieves a stream of orders associated with a specific list of sellers.
  ///
  /// - `sellerList`: A list of seller IDs.
  /// - Returns a `Stream<QuerySnapshot<Map<String, dynamic>>>` containing order data.
  Stream<QuerySnapshot<Map<String, dynamic>>> sellerOrderSnapshot(
      {required List<String> sellerList}) {
    try {
      return _dataFirebaseService.sellerOrderSnapshot(sellerList: sellerList);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  /// Fetches a stream of user details for the user handling delivery.
  ///
  /// - `userId`: The ID of the delivery user.
  /// - Returns a `Stream<DocumentSnapshot<Map<String, dynamic>>>` containing user details.
  Stream<DocumentSnapshot<Map<String, dynamic>>> deliveryUserDetailsSnapshots(
      {required String userId}) {
    try {
      return _dataFirebaseService.deliveryUserDetailsSnapshots(userId: userId);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  /// Retrieves a stream of the delivery address for a specific user and address ID.
  ///
  /// - `userId`: The ID of the user whose address is being retrieved.
  /// - `addressId`: The specific address ID.
  /// - Returns a `Stream<DocumentSnapshot<Map<String, dynamic>>>` containing address details.
  Stream<DocumentSnapshot<Map<String, dynamic>>> userDeliveryAddressSnapshot(
      {required String userId, required String addressId}) {
    try {
      return _dataFirebaseService.userDeliveryAddressSnapshot(
          userId: userId, addressId: addressId);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }
}
