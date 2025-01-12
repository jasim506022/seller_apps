import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/productsmodel.dart';

abstract class BaseFirebaseService {
  FirebaseAuth get firebaseAuth;
  FirebaseFirestore get firebaseFirestore;
  FirebaseStorage get firebaseStorage;

  User? getCurrentUser();

  //okay
  Future<List<String>> uploadImagesToStorage(
      {required List<XFile> images, required String productID});

  Future<void> saveProductToDatabase(
      {required ProductModel productModel, required bool isUpdate});

  //
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchProductSnapshotsByCategory(
      {required String category});

  // Delete Product
  Future<void> deleteProductByIdSnapshot({required String productId});

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSimilarProducts(
      {required ProductModel productModel});

  Stream<QuerySnapshot<Map<String, dynamic>>> orderSnapshots(
      {required String orderStatus});

  Future<QuerySnapshot<Map<String, dynamic>>> orderProductSnapshots(
      {required List<String> productIDList});

  Stream<DocumentSnapshot<Map<String, dynamic>>> delivaryUserDetailsSnaphots(
      {required String userId});

  Stream<DocumentSnapshot<Map<String, dynamic>>> userDeliveryAddressSnapshot(
      {required String userId, required String addressId});

  Future<QuerySnapshot<Map<String, dynamic>>> sellerProductSnapshot(
      {required List<String> productList, required String sellerId});

  Stream<DocumentSnapshot<Map<String, dynamic>>> orderAddressSnapsot(
      {required String addressId});
}
