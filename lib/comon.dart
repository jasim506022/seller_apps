/*
#: What is difference page and Screen and when it's use 
#: Parameter
#: Clear Understand Background Circles  (Page Details)
#: Image Slider Doesn't Work properly When I back
#: Injecting the ProductRepository via the constructor
#: Understand AppException
#: Understand Try-Catch and Rethorw
#: Understand Null Clearly !, ?., ??, ??=
#: OnBoarding Image Doesn't modify
#: Validation Understand Clearly

*/ 

/*
Clear Understand AppException
ErrorDialogWidget

*/

/*
############## SplashScreen#######################
#: dependency injection 
*/













/*
Question-1: What is difference between page and screen when  use page and when use screen in mobile apps (Flutter)? 

Here’s a simple summary:

Page:
Use when referring to a view or route that is navigated to.
Typically used in the context of navigation or routing (when you push or pop a route).
Represents a distinct new screen in the app that can be pushed into the navigation stack.
Example: HomePage, LoginPage, ProfilePage.

Screen:
Use when referring to a full-screen view that displays content.
Represents a part of the app that users see and interact with, usually without direct navigation between screens.
Can be part of the UI but doesn't necessarily involve routing.
Example: HomeScreen, ProfileScreen, SettingsScreen.

In short:
Page is typically used for navigation purposes.
Screen is used for a full UI view displayed to the user.




*/


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
        .collection(AppStrings.collectionOrders)
        .where(AppStrings.idProductFirebaseField, whereIn: productIDList)
        .get();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> sellerProductSnapshot(
      {required List<String> productList, required String sellerId}) async {
    return FirebaseFirestore.instance
        .collection(AppStrings.collectionOrders)
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

*/