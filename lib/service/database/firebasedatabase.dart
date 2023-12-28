import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:seller_apps/model/profilemodel.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../const/cartmethod.dart';
import '../../const/const.dart';
import '../../const/global.dart';
import '../../model/productsmodel.dart';
import '../../widget/show_error_dialog_widget.dart';

class FirebaseDatabase {
  // instance of FirebaseAuth
  static FirebaseAuth auth = FirebaseAuth.instance;

  // instance of FirebaseFirestore
  static final firestore = FirebaseFirestore.instance;

// Current User
  static User get user => auth.currentUser!;

  // Seller Uid
  static String selleruid = sharedPreference!.getString("uid")!;

  // instance of Firebase Storeage Reference
  static Reference storageRef = FirebaseStorage.instance.ref();

  //  Seller Document Reference
  static final sellerDoc = firestore.collection("seller").doc(selleruid);

//Sign in With Email and Passwords
  static Future<UserCredential> singEmailandPasswordSnapshot(
          {required String email, required String password}) async =>
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

// Sign In With Gmail
  static Future<UserCredential?> signWithGoogle(
      {required BuildContext context}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        return await auth.signInWithCredential(credential);
      } else {
        globalMethod.flutterToast(msg: "No Internet Connection");
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return ShowErrorDialogWidget(
              message: "Error Ocured: $e", title: 'Error Occured');
        },
      );
      // globalMethod.showDialogMethod(
      //     context: context,
      //     message: "Error Ocured: $e",
      //     title: 'Error Occured'

      //     );
      return null;
    }
    return null;
  }

// Create User and Post Data Firebase
  static Future<void> createUserGmail() async {
    ProfileModel profileModel = ProfileModel(
        name: user.displayName,
        earnings: 0.0,
        status: "approved",
        email: user.email,
        phone: user.phoneNumber,
        uid: user.uid,
        address: "",
        imageurl: user.photoURL);

    firestore.collection("seller").doc(user.uid).set(profileModel.toMap());
  }

// create User With Email and Password Snapshot
  static Future<UserCredential> createUserWithEmilandPaswordSnaphsot(
      {required String email, required String password}) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

// Create User and Post Data Firebase
  static Future<void> createUserByEmailPassword(
      {required UserCredential userCredential,
      required String phone,
      required String name,
      required String image}) async {
    ProfileModel profileModel = ProfileModel(
        name: name,
        earnings: 0.0,
        status: "approved",
        email: userCredential.user!.email,
        phone: phone,
        uid: userCredential.user!.uid,
        address: "",
        imageurl: image);

    firestore
        .collection("seller")
        .doc(userCredential.user!.uid)
        .set(profileModel.toMap());
  }

  // forget Password Snapshort
  static Future<void> forgetPasswordSnapshot({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

// user is Exist on Database
  static Future<bool> userExists() async =>
      (await firestore.collection("seller").doc(auth.currentUser!.uid).get())
          .exists;

// Current User All Firestore Data Data
  static Future<DocumentSnapshot<Map<String, dynamic>>>
      currentUserDataSnapshot() async {
    return firestore.collection("seller").doc(auth.currentUser!.uid).get();
  }

// All Seller Product List
  static Stream<QuerySnapshot<Map<String, dynamic>>> searchSellerProductList(
      {required String category}) {
    return category == "All"
        ? sellerDoc
            .collection("products")
            .orderBy("publishDate", descending: true)
            .snapshots()
        : sellerDoc
            .collection("products")
            .where("productcategory", isEqualTo: category)
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
    // firestore
    //     .collection("seller")
    //     .doc(selleruid)
    sellerDoc.collection("products").doc(productId).set(map).then((value) {
      firestore.collection("products").doc(productId).set(map);
    });
  }

// Update Product All Information in Firebase Firestore
  static Future<void> updateFirebaseFirestoreProductData(
      {required String productId, required Map<String, dynamic> map}) async {
    // firestore
    //     .collection("seller")
    //     .doc(selleruid)
    sellerDoc.collection("products").doc(productId).update(map).then((value) {
      firestore.collection("products").doc(productId).update(map);
    });
  }

// All Product List
  static Stream<QuerySnapshot<Map<String, dynamic>>> allProductListSnapshots(
      {required String category}) {
    return category == "All"
        ? sellerDoc
            .collection("products")
            .orderBy("publishDate", descending: true)
            .snapshots()
        : sellerDoc
            .collection("products")
            .where("productcategory", isEqualTo: category)
            .orderBy("publishDate", descending: true)
            .snapshots();
  }

// Similar  Product Firebase
  static Stream<QuerySnapshot<Map<String, dynamic>>> similarProductSnapshot(
      {required ProductModel productModel}) {
    return sellerDoc
        .collection("products")
        .where("productId", isNotEqualTo: productModel.productId)
        .where("productcategory", isEqualTo: productModel.productcategory)
        .snapshots();

    //
  }

// Delete Product
  static Future<void> deleteProductSnapshot({required String productId}) async {
    await sellerDoc.collection("products").doc(productId).delete().then(
        (value) => firestore.collection("products").doc(productId).delete());
  }

// Address
  static Stream<DocumentSnapshot<Map<String, dynamic>>> addressSnapsot() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid"))
        .snapshots();

    //
  }

  //  Single Order Snpashot
  static Stream<DocumentSnapshot<Map<String, dynamic>>> singleorderSnapshots(
      {required String orderId}) {
    return firestore.collection("orders").doc(orderId).snapshots();
  }

//Profile Snapshot
  static Future<DocumentSnapshot<Map<String, dynamic>>>
      profileSnapshot() async {
    return firestore.collection('seller').doc(selleruid).get();
  }

// All New Order Snpashot
  static Stream<QuerySnapshot<Map<String, dynamic>>>? allOrderSnapshots(
      {required String status}) {
    return firestore
        .collection("orders")
        .where("status", isEqualTo: status)
        .where("seller", arrayContains: selleruid)
        .snapshots();
  }

  // Update Profile Seller Profile Data
  static Future<void> updateProfileData(
      {required Map<String, dynamic> map}) async {
    firestore.collection("seller").doc(selleruid).update(map);
  }

  // Order Product Snpashot
  static Future<QuerySnapshot<Map<String, dynamic>>> orderProductSnapshots(
      {required Map<String, dynamic> snpshot}) {
    return firestore
        .collection("seller")
        .doc(selleruid)
        .collection("products")
        .where("productId",
            whereIn:
                CartMethods.separteOrderProductIdList((snpshot)["productIds"]))
        .get();
  }

//User Details Snapshort
  static Stream<DocumentSnapshot<Map<String, dynamic>>> userDetailsSnaphots(
      {required String userId}) {
    return firestore.collection("users").doc(userId).snapshots();
  }

  // User and Delivary Address
  static Stream<DocumentSnapshot<Map<String, dynamic>>> userDeliverysnapshot(
      {required String addressId, required String userId}) {
    return firestore
        .collection("users")
        .doc(userId)
        .collection("useraddress")
        .doc(addressId)
        .snapshots();
  }

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

  // Order Product Snpashot
  static Future<QuerySnapshot<Map<String, dynamic>>>
      orderDeliveryOrderProductSnapshot({required List<dynamic> list}) {
    return firestore
        .collection("seller")
        .doc(selleruid)
        .collection("products")
        .where("productId",
            whereIn: CartMethods.separteOrderProductIdList(list))
        .orderBy("publishDate", descending: true)
        .get();
  }
}
