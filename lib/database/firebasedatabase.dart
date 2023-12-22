import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../const/cartmethod.dart';
import '../const/global.dart';
import '../model/productsmodel.dart';

class FirebaseDatabase {
  // Seller Uid
  static String selleruid = sharedPreference!.getString("uid")!;

  // instance of FirebaseFirestore
  static final firestore = FirebaseFirestore.instance;

  // instance of Firebase Storeage Reference
  static Reference storageRef = FirebaseStorage.instance.ref();

// All Seller Product List
  static Future<QuerySnapshot<Map<String, dynamic>>>
      allSellerProductList() async {
    return firestore
        .collection("seller")
        .doc(selleruid)
        .collection("products")
        .orderBy("publishDate", descending: true)
        .get();
  }

// All Seller Product List
  static Stream<QuerySnapshot<Map<String, dynamic>>> searchSellerProductList() {
    return firestore
        .collection("seller")
        .doc(selleruid)
        .collection("products")
        .orderBy("publishDate", descending: true)
        .snapshots();
  }

// Image Storage Refrence
  static Reference storageReference(
      {required String catogryName, required String fileName}) {
    return storageRef
        .child("sellers")
        .child(selleruid)
        .child("productimage")
        .child(catogryName)
        .child(fileName);
  }

// Push Product All Information in Firebase Firestore
  static Future<void> pushFirebaseFirestoreProductData(
      {required String productId, required Map<String, dynamic> map}) async {
    firestore
        .collection("seller")
        .doc(selleruid)
        .collection("products")
        .doc(productId)
        .set(map)
        .then((value) {
      firestore.collection("products").doc(productId).set(map);
    });
  }

// Update Product All Information in Firebase Firestore
  static Future<void> updateFirebaseFirestoreProductData(
      {required String productId, required Map<String, dynamic> map}) async {
    firestore
        .collection("seller")
        .doc(selleruid)
        .collection("products")
        .doc(productId)
        .update(map)
        .then((value) {
      firestore.collection("products").doc(productId).update(map);
    });
  }

//Query From Firebaese Firestore Product List
  static Stream<QuerySnapshot<Map<String, dynamic>>> allProductListSnapshots(
      {required String category}) {
    if (category == "All") {
      return firestore
          .collection("seller")
          .doc(selleruid)
          .collection("products")
          .orderBy("publishDate", descending: true)
          .snapshots();
    }

    return firestore
        .collection("seller")
        .doc(sharedPreference!.getString("uid"))
        .collection("products")
        .where("productcategory", isEqualTo: category)
        .orderBy("publishDate", descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> data = FirebaseFirestore
      .instance
      .collection("products")
      .orderBy("publishDate", descending: true)
      .snapshots();

  static Future<UserCredential> createUserWithEmailPassword(
      String email, String password) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> createUserSetSnapshot(
      String collection, String id, Map<String, dynamic> map) async {
    await firestore.collection(collection).doc(id).set(map);
  }

  static Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

// Popular Product Firebase
  static Stream<QuerySnapshot<Map<String, dynamic>>> popularProductSnapshot(
      {required String category}) {
    if (category == "All") {
      return firestore
          .collection("products")
          .where("ratting", isGreaterThan: 2.5)
          .snapshots();
    }

    return firestore
        .collection("products")
        .where("productcategory", isEqualTo: category)
        .where("ratting", isGreaterThan: 2.5)
        .snapshots();
  }

// Similar  Product Firebase
  static Stream<QuerySnapshot<Map<String, dynamic>>> similarProductSnapshot(
      {required ProductModel productModel}) {
    return FirebaseFirestore.instance
        .collection("seller")
        .doc(sharedPreference!.getString("uid"))
        .collection("products")
        .where("productId", isNotEqualTo: productModel.productId)
        .where("productcategory", isEqualTo: productModel.productcategory)
        .snapshots();

    //
  }

// All Address Firebase
  static DocumentReference<Map<String, dynamic>> allorUpdateAddressSnapshot(
      {required String id}) {
    var address = FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid")!)
        .collection("useraddress")
        .doc(id);
    return address;
    //
  }

// All User Address
  static Stream<QuerySnapshot<Map<String, dynamic>>> alluserAddressSnapshot() {
    var address = FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid")!)
        .collection("useraddress")
        .snapshots();
    return address;
    //
  }

// Save Order Details For user
  static saveOrderDetailsForUser(
      {required Map<String, dynamic> orderDetailsMap,
      required String orderId}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid"))
        .collection("orders")
        .doc(orderId)
        .set(orderDetailsMap);
  }

// Save Order Details For Seller
  static saveOrderDetailsForSeller(
      {required Map<String, dynamic> orderDetailsMap,
      required String orderId}) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set(orderDetailsMap);
  }

// All Order Snpashot
  static Stream<QuerySnapshot<Map<String, dynamic>>> allOrderSnapshots() {
    return FirebaseFirestore.instance
        .collection("orders")
        .where("status", isEqualTo: "normal")
        .snapshots();

    //
  }

// All Order Snpashot
  static Stream<QuerySnapshot<Map<String, dynamic>>> allShiftOrderSnaphort() {
    return FirebaseFirestore.instance
        .collection("orders")
        .where("status", isEqualTo: "deliver")
        .snapshots();

    //
  }

// All Order Snpashot
  static Stream<QuerySnapshot<Map<String, dynamic>>> allCompleteSnapshots() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid"))
        .collection("orders")
        .where("status", isEqualTo: "complete")
        .snapshots();

    //
  }

// All Order Seller Snpashot
  static Stream<QuerySnapshot<Map<String, dynamic>>> orderSelerSnapshots(
      {required List<String> list}) {
    return FirebaseFirestore.instance
        .collection("seller")
        .where("uid", whereIn: list)
        .snapshots();

    //
  }

//  Order Snpashot
  static Stream<DocumentSnapshot<Map<String, dynamic>>> orderSnapshots(
      {required String orderId}) {
    return FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .snapshots();

    //
  }

// User Details
  static Stream<DocumentSnapshot<Map<String, dynamic>>> userDetails() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid"))
        .snapshots();

    //
  }

// Address
  static Stream<DocumentSnapshot<Map<String, dynamic>>> addressSnapsot() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid"))
        .snapshots();

    //
  }

// Address
  static Stream<DocumentSnapshot<Map<String, dynamic>>> orderAddressSnapsot(
      {required String addressId, required String userUdi}) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userUdi)
        .collection("useraddress")
        .doc(addressId)
        .snapshots();
  }

// Current User
  static DocumentReference<Map<String, dynamic>> currentUserSnaphots() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid")!);
  }

  // Order Product Snpashot
  static Future<QuerySnapshot<Map<String, dynamic>>> orderProductSnapshots(
      {required Map<String, dynamic> snpshot}) {
    return FirebaseFirestore.instance
        .collection("seller")
        .doc(sharedPreference!.getString("uid")!)
        .collection("products")
        .where("productId",
            whereIn:
                CartMethods.separteOrderProductIdList((snpshot)["productIds"]))
        .get();

    //
  }

  // Order Product Snpashot
  static Future<QuerySnapshot<Map<String, dynamic>>>
      deliveryOrderProductSnapshots({required List<dynamic> list}) {
    return FirebaseFirestore.instance
        .collection("seller")
        .doc(sharedPreference!.getString("uid")!)
        .collection("products")
        .where("productId",
            whereIn: CartMethods.separteOrderProductIdList(list))
        .orderBy("publishDate", descending: true)
        .get();

    //
  }

  //Profile Snapshot
  static Future<DocumentSnapshot<Map<String, dynamic>>>
      profileSnapshot() async {
    return firestore.collection('seller').doc(selleruid).get();
  }

  // Update Profile Seller Profile Data
  static Future<void> updateProfileData(
      {required Map<String, dynamic> map}) async {
    firestore.collection("seller").doc(selleruid).update(map);
  }
}
