
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
  
  

  //
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserInformationSnapshot();
  Future<List<String>> uploadImageStorage({required List<XFile> imageList});

  Future<void> uploadProductSnapshot(
      {required ProductModel productModel, required bool isUpdate});

  //
  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots(
      {required String category});

  // Delete Product
  Future<void> deleteProductSnapshot({required String productId});

  Stream<QuerySnapshot<Map<String, dynamic>>> similarProductSnapshot(
      {required ProductModel productModel});

  Stream<QuerySnapshot<Map<String, dynamic>>> orderSnapshots(
      {required String orderStatus});

  Future<QuerySnapshot<Map<String, dynamic>>> orderProductSnapshots(
      {required List<String> productIDList});

  Stream<DocumentSnapshot<Map<String, dynamic>>> delivaryUserDetailsSnaphots(
      {required String userId});

  Stream<DocumentSnapshot<Map<String, dynamic>>> userDeliveryAddressSnapshot(
      {required String userId, required String addressId});

  Future<void> signOutApp();
  Future<QuerySnapshot<Map<String, dynamic>>> sellerProductSnapshot(
      {required List<String> productList, required String sellerId});

  Stream<DocumentSnapshot<Map<String, dynamic>>> orderAddressSnapsot(
      {required String addressId});
  Future<void> updateUserData({required Map<String, dynamic> map});
}
