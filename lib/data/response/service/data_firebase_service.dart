import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_apps/res/app_string.dart';

import '../../../model/productsmodel.dart';
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
        AppConstants.sharedPreference?.getString(AppString.uidSharedPreference);
    var sellerName = AppConstants.sharedPreference
        ?.getString(AppString.nameSharedPreference);

    // Define the storage path
    final storagePath =
        "${AppString.sellersCollection}/$sellerId/$sellerName/$productId/images/$uniqueImageName";

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
        .collection(AppString.sellersCollection)
        .doc(AppConstants.sharedPreference!
            .getString(AppString.uidSharedPreference));

    // References to the product documents in seller and global collections

    var sellerProductDoc = sellerDoc
        .collection(AppString.productsCollection)
        .doc(productModel.productId);
    var globalProductDoc = firebaseFirestore
        .collection(AppString.productsCollection)
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
        .collection(AppString.sellersCollection)
        .doc(AppConstants.sharedPreference!
            .getString(AppString.uidSharedPreference))
        .collection(AppString.productsCollection);
    var query = collectionRef.orderBy("publishDate", descending: true);

    if (category != "All") {
      query = query.where("productcategory", isEqualTo: category);
    }

    return query.snapshots();
  }

  @override
  Future<void> deleteProductByIdSnapshot({required String productId}) async {
    final sellerId =
        AppConstants.sharedPreference?.getString(AppString.uidSharedPreference);

    final sellerRef =
        firebaseFirestore.collection(AppString.sellersCollection).doc(sellerId);

    sellerRef.collection(AppString.productsCollection).doc(productId).delete();

    firebaseFirestore
        .collection(AppString.productsCollection)
        .doc(productId)
        .delete();
  }

  //

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSimilarProducts(
      {required ProductModel productModel}) {
    final sellerId =
        AppConstants.sharedPreference?.getString(AppString.uidSharedPreference);
    return firebaseFirestore
        .collection(AppString.sellersCollection)
        .doc(sellerId)
        .collection(AppString.productsCollection)
        .where("productId", isNotEqualTo: productModel.productId)
        .where("productcategory", isEqualTo: productModel.productcategory)
        .snapshots();

    //
  }

  // home
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> orderSnapshots(
      {required String orderStatus}) {
    String selleruid = AppConstants.sharedPreference!.getString("uid")!;
    return
        // firebaseFirestore
        //     .collection("users")
        //     .doc(sharedPreference!.getString("uid"))
        //     .collection("orders")
        //     .where("status", isEqualTo: orderStatus)
        //     .snapshots();

        firebaseFirestore
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
        .doc(AppConstants.sharedPreference!.getString("uid")!)
        .collection("products")
        .where("productId", whereIn: productIDList)
        .get();
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> delivaryUserDetailsSnaphots(
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
    print(sellerList.length);
    return firebaseFirestore
        .collection("seller")
        .where("uid", whereIn: sellerList)
        .snapshots();
  }
}





/*
FirebaseFirestore.instance
          .collection("seller")
          .doc(seller)
          .collection("products")
          .where("productId", whereIn: listProductID)
          .get()
*/