import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_apps/res/app_string.dart';

import '../../../model/product_model.dart';
import '../../../res/app_constants.dart';
import 'base_firebase_service.dart';

class DataFirebaseService implements BaseFirebaseService {
  @override
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @override
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

  @override
  FirebaseStorage get firebaseStorage => FirebaseStorage.instance;

  @override
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  @override
  Future<List<String>> uploadImagesToStorage(
      {required List<XFile> images, required String productID}) async {
    List<String> uploadedImageUrls = [];

    for (var image in images) {
      await uploadImage(image, productID)
          .then((downLoadUrl) => uploadedImageUrls.add(downLoadUrl));
    }
    return uploadedImageUrls;
  }

  Future<String> uploadImage(XFile imageFile, String productId) async {
    final uniqueImageName =
        "${imageFile.name}_${DateTime.now().millisecondsSinceEpoch}";
    var sellerId =
        AppConstants.sharedPreference?.getString(AppStrings.prefUserId);
    var sellerName =
        AppConstants.sharedPreference?.getString(AppStrings.prefUserName);

    // Define the storage path
    final storagePath =
        "${AppStrings.collectionSeller}/$sellerId/$sellerName/$productId/images/$uniqueImageName";

    // Upload image to Firebase Storage
    final ref = firebaseStorage.ref().child(storagePath);

    UploadTask uploadTask = ref.putFile(File(imageFile.path));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    return taskSnapshot.ref.getDownloadURL();
  }

  @override
  Future<void> saveProductToDatabase(
      {required ProductModel productModel, required bool isUpdate}) async {
    final sellerDoc = firebaseFirestore
        .collection(AppStrings.collectionSeller)
        .doc(AppConstants.sharedPreference!.getString(AppStrings.prefUserId));

    // References to the product documents in seller and global collections

    var sellerProductDoc = sellerDoc
        .collection(AppStrings.collectionProducts)
        .doc(productModel.productId);
    var globalProductDoc = firebaseFirestore
        .collection(AppStrings.collectionProducts)
        .doc(productModel.productId);
    final productData = productModel.toMap();
    if (isUpdate) {
      sellerProductDoc.update(productData);
      globalProductDoc.update(productData);
    } else {
      sellerProductDoc.set(productData);
      globalProductDoc.set(productData);
    }
  }

  //
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchCategoryProducts(
      {required String category}) {
    var collectionRef = firebaseFirestore
        .collection(AppStrings.collectionSeller)
        .doc(AppConstants.sharedPreference!.getString(AppStrings.prefUserId))
        .collection(AppStrings.collectionProducts);
    var query = collectionRef.orderBy(AppStrings.datePublishFirebaseField,
        descending: true);

    if (category != "All") {
      query = query.where(AppStrings.categoryProductFirebaseField,
          isEqualTo: category);
    }

    return query.snapshots();
  }

  @override
  Future<void> deleteProductByIdSnapshot({required String productId}) async {
    final sellerId =
        AppConstants.sharedPreference?.getString(AppStrings.prefUserId);

    final sellerRef =
        firebaseFirestore.collection(AppStrings.collectionSeller).doc(sellerId);

    sellerRef.collection(AppStrings.collectionProducts).doc(productId).delete();

    firebaseFirestore
        .collection(AppStrings.collectionProducts)
        .doc(productId)
        .delete();
  }

  //

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSimilarProducts(
      {required ProductModel productModel}) {
    final sellerId =
        AppConstants.sharedPreference?.getString(AppStrings.prefUserId);
    return firebaseFirestore
        .collection(AppStrings.collectionSeller)
        .doc(sellerId)
        .collection(AppStrings.collectionProducts)
        .where(AppStrings.idProductFirebaseField,
            isNotEqualTo: productModel.productId)
        .where(AppStrings.categoryProductFirebaseField,
            isEqualTo: productModel.productcategory)
        .snapshots();

    //
  }

  // --------------------------- Order Related------------------------- Firebase Data
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> orderSnapshots(
      {required String orderStatus}) {
    String selleruid =
        AppConstants.sharedPreference!.getString(AppStrings.prefUserId)!;
    return firebaseFirestore
        .collection(AppStrings.collectionOrders)
        .where(AppStrings.sellerFirebaseField,
            arrayContains: "$selleruid:false")
        .where(AppStrings.statusFirebaseField, isEqualTo: orderStatus)
        .snapshots();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> orderProductSnapshots(
      {required List<String> productIDList}) {
    return firebaseFirestore
        .collection(AppStrings.collectionSeller)
        .doc(AppConstants.sharedPreference!.getString(AppStrings.prefUserId)!)
        .collection(AppStrings.collectionProducts)
        .where(AppStrings.idProductFirebaseField, whereIn: productIDList)
        .get();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> sellerProductSnapshot(
      {required List<String> productList, required String sellerId}) async {
    return FirebaseFirestore.instance
        .collection(AppStrings.collectionProducts)
        .where(AppStrings.idSelllerFirebaseField, isEqualTo: sellerId)
        .where(AppStrings.idProductFirebaseField, whereIn: productList)
        .orderBy(AppStrings.datePublishFirebaseField, descending: true)
        .get();
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> orderAddressSnapsot(
      {required String addressId}) {
    return firebaseFirestore
        .collection(AppStrings.collectionUsers)
        .doc(AppConstants.sharedPreference!.getString(AppStrings.prefUserId))
        .collection(AppStrings.collectionUserAddress)
        .doc(addressId)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> sellerOrderSnapshot(
      {required List<String> sellerList}) {
    return firebaseFirestore
        .collection(AppStrings.collectionSeller)
        .where(AppStrings.uIdFirebaseField, whereIn: sellerList)
        .snapshots();
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> deliveryUserDetailsSnapshots(
      {required String userId}) {
    return firebaseFirestore
        .collection(AppStrings.collectionUsers)
        .doc(userId)
        .snapshots();
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> userDeliveryAddressSnapshot(
      {required String userId, required String addressId}) {
    return firebaseFirestore
        .collection(AppStrings.collectionUsers)
        .doc(userId)
        .collection(AppStrings.collectionUserAddress)
        .doc(addressId)
        .snapshots();
  }

  //
}



/*

import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_apps/res/app_string.dart';

import '../../../model/product_model.dart';
import '../../../res/app_constants.dart';
import 'base_firebase_service.dart';

class DataFirebaseService implements BaseFirebaseService {
  @override
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @override
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

  @override
  FirebaseStorage get firebaseStorage => FirebaseStorage.instance;

  @override
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  @override
  Future<List<String>> uploadImagesToStorage(
      {required List<XFile> images, required String productID}) async {
    List<String> uploadedImageUrls = [];

    for (var image in images) {
      await uploadImage(image, productID)
          .then((downLoadUrl) => uploadedImageUrls.add(downLoadUrl));
    }
    return uploadedImageUrls;
  }

  Future<String> uploadImage(XFile imageFile, String productId) async {
    final uniqueImageName =
        "${imageFile.name}_${DateTime.now().millisecondsSinceEpoch}";
    var sellerId =
        AppConstants.sharedPreference?.getString(AppStrings.prefUserId);
    var sellerName =
        AppConstants.sharedPreference?.getString(AppStrings.prefUserName);

    // Define the storage path
    final storagePath =
        "${AppStrings.collectionSeller}/$sellerId/$sellerName/$productId/images/$uniqueImageName";

    // Upload image to Firebase Storage
    final ref = firebaseStorage.ref().child(storagePath);

    UploadTask uploadTask = ref.putFile(File(imageFile.path));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    return taskSnapshot.ref.getDownloadURL();
  }

  @override
  Future<void> saveProductToDatabase(
      {required ProductModel productModel, required bool isUpdate}) async {
    final sellerDoc = firebaseFirestore
        .collection(AppStrings.collectionSeller)
        .doc(AppConstants.sharedPreference!.getString(AppStrings.prefUserId));

    // References to the product documents in seller and global collections

    var sellerProductDoc = sellerDoc
        .collection(AppStrings.collectionSeller)
        .doc(productModel.productId);
    var globalProductDoc = firebaseFirestore
        .collection(AppStrings.collectionSeller)
        .doc(productModel.productId);
    final productData = productModel.toMap();
    if (isUpdate) {
      sellerProductDoc.update(productData);
      globalProductDoc.update(productData);
    } else {
      sellerProductDoc.set(productData);
      globalProductDoc.set(productData);
    }
  }

  //
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchCategoryProducts(
      {required String category}) {
    var collectionRef = firebaseFirestore
        .collection(AppStrings.collectionSeller)
        .doc(AppConstants.sharedPreference!.getString(AppStrings.prefUserId))
        .collection(AppStrings.collectionSeller);
    var query = collectionRef.orderBy("publishDate", descending: true);

    if (category != "All") {
      query = query.where("productcategory", isEqualTo: category);
    }

    return query.snapshots();
  }

  @override
  Future<void> deleteProductByIdSnapshot({required String productId}) async {
    final sellerId =
        AppConstants.sharedPreference?.getString(AppStrings.prefUserId);

    final sellerRef =
        firebaseFirestore.collection(AppStrings.collectionSeller).doc(sellerId);

    sellerRef.collection(AppStrings.collectionProducts).doc(productId).delete();

    firebaseFirestore
        .collection(AppStrings.collectionSeller)
        .doc(productId)
        .delete();
  }

  //

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSimilarProducts(
      {required ProductModel productModel}) {
    final sellerId =
        AppConstants.sharedPreference?.getString(AppStrings.prefUserId);
    return firebaseFirestore
        .collection(AppStrings.collectionSeller)
        .doc(sellerId)
        .collection(AppStrings.collectionSeller)
        .where("productId", isNotEqualTo: productModel.productId)
        .where("productcategory", isEqualTo: productModel.productcategory)
        .snapshots();

    //
  }

  //
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> orderSnapshots(
      {required String orderStatus}) {
    String selleruid = AppConstants.sharedPreference!.getString("uid")!;
    return firebaseFirestore
        .collection("orders")
        .where("seller", arrayContains: "$selleruid:false")
        .where("status", isEqualTo: orderStatus)
        .snapshots();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> orderProductSnapshots(
      {required List<String> productIDList}) {
    return firebaseFirestore
        .collection("seller")
        .doc(AppConstants.sharedPreference!.getString(AppStrings.prefUserId)!)
        .collection(AppStrings.collectionOrders)
        .where(AppStrings.idProductFirebaseField, whereIn: productIDList)
        .get();
  }

/*
  @override
  Future<QuerySnapshot<Map<String, dynamic>>> orderProductSnapshots(
      {required List<String> productIDList}) {
    return firebaseFirestore
        .collection("seller")
        .doc(AppConstants.sharedPreference!.getString("uid")!)
        .collection("products")
        .where("productId", whereIn: productIDList)
        .get();
  }
  */

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> sellerProductSnapshot(
      {required List<String> productList, required String sellerId}) async {
    return FirebaseFirestore.instance
        .collection("products")
        .where("sellerId", isEqualTo: sellerId)
        .where("productId", whereIn: productList)
        .orderBy("publishDate", descending: true)
        .get();
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> orderAddressSnapsot(
      {required String addressId}) {
    return firebaseFirestore
        .collection("users")
        .doc(AppConstants.sharedPreference!.getString("uid"))
        .collection("useraddress")
        .doc(addressId)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> sellerOrderSnapshot(
      {required List<String> sellerList}) {
    return firebaseFirestore
        .collection("seller")
        .where("uid", whereIn: sellerList)
        .snapshots();
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> deliveryUserDetailsSnapshots(
      {required String userId}) {
    return firebaseFirestore.collection("users").doc(userId).snapshots();
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> userDeliveryAddressSnapshot(
      {required String userId, required String addressId}) {
    return firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("useraddress")
        .doc(addressId)
        .snapshots();
  }

  //
}
*/