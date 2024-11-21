import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_apps/const/global.dart';
import 'package:seller_apps/res/app_string.dart';

import '../../../model/productsmodel.dart';
import '../../../model/profilemodel.dart';
import 'base_firebase_service.dart';

class DataFirebaseService implements BaseFirebaseService {
  @override
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @override
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

  @override
  FirebaseStorage get firebaseStorage => FirebaseStorage.instance;

/*
Flutter Auth Firebase Snapshot
*/

  @override
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) {
    return firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<UserCredential?> signWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<bool> userExists() async => (await firebaseFirestore
          .collection("seller")
          .doc(firebaseAuth.currentUser!.uid)
          .get())
      .exists;

  @override
  Future<void> createUserGmail(
      {required User user, required ProfileModel profileModel}) async {
    firebaseFirestore
        .collection("seller")
        .doc(user.uid)
        .set(profileModel.toMap());
  }

  @override
  Future<String> uploadUserImgeUrl({required File file}) async {
    String fileName = "ju_grocery_${DateTime.now().millisecondsSinceEpoch}";
    Reference storageRef = firebaseStorage
        .ref()
        .child("seller")
        // .child(firebaseAuth.currentUser!.uid)
        .child(fileName);
    UploadTask uploadTask = storageRef.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    return taskSnapshot.ref.getDownloadURL();
  }

  @override
  Future<UserCredential> createUserWithEmilandPasword(
          {required String email, required String password}) async =>
      firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  @override
  Future<void> uploadUserProfile(
      {required ProfileModel profileModel,
      required String firebaseDocument}) async {
    await firebaseFirestore
        .collection("seller")
        .doc(firebaseDocument)
        .set(profileModel.toMap());
  }

  @override
  Future<void> forgetPasswordSnapshot({required String email}) async {
    firebaseAuth.sendPasswordResetEmail(email: email);
  }

//
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserInformationSnapshot() {
    return firebaseFirestore
        .collection("seller")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
  }

  @override
  Future<List<String>> uploadImageStorage(
      {required List<XFile> imageList}) async {
    List<String> imageUrlList = [];

    for (var image in imageList) {
      await postImages(image)
          .then((downLoadUrl) => imageUrlList.add(downLoadUrl));
    }
    return imageUrlList;
  }

  Future<String> postImages(XFile? imageFile) async {
    final uniqueImageName =
        "${imageFile!.name}_${DateTime.now().millisecondsSinceEpoch}";

    final ref = firebaseStorage.ref().child(
        "sellers/${sharedPreference!.getString(AppString.uidSharedPreference)}${sharedPreference!.getString(AppString.nameSharedPreference)}_images/$uniqueImageName");

    UploadTask uploadTask = ref.putFile(File(imageFile.path));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    return taskSnapshot.ref.getDownloadURL();
  }

  @override
  Future<void> uploadProductSnapshot(
      {required ProductModel productModel, required bool isUpdate}) async {
    final seller = firebaseFirestore
        .collection("seller")
        .doc(sharedPreference!.getString(AppString.uidSharedPreference));

    var sellerProductDoc =
        seller.collection("products").doc(productModel.productId);
    var globalProductDoc =
        firebaseFirestore.collection("products").doc(productModel.productId);
    if (isUpdate) {
      sellerProductDoc.update(productModel.toMap());
      globalProductDoc.update(productModel.toMap());
    } else {
      sellerProductDoc.set(productModel.toMap());
      globalProductDoc.set(productModel.toMap());
    }
  }

  //
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots(
      {required String category}) {
    var collectionRef = firebaseFirestore
        .collection("seller")
        .doc(sharedPreference!.getString(AppString.uidSharedPreference))
        .collection("products");
    var query = collectionRef.orderBy("publishDate", descending: true);

    if (category != "All") {
      query = query.where("productcategory", isEqualTo: category);
    }

    return query.snapshots();
  }

  @override
  Future<void> deleteProductSnapshot({required String productId}) async {
    final sellerId = sharedPreference?.getString(AppString.uidSharedPreference);
    final sellerRef = firebaseFirestore.collection("seller").doc(sellerId);

    sellerRef.collection("products").doc(productId).delete();
    firebaseFirestore.collection("products").doc(productId).delete();
  }

  //

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> similarProductSnapshot(
      {required ProductModel productModel}) {
    return FirebaseFirestore.instance
        .collection("seller")
        .doc(sharedPreference!.getString("uid")!)
        .collection("products")
        .where("productId", isNotEqualTo: productModel.productId)
        .where("productcategory", isEqualTo: productModel.productcategory)
        .snapshots();

    //
  }

  // home
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> orderSnapshots(
      {required String orderStatus}) {
    String selleruid = sharedPreference!.getString("uid")!;
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
}
