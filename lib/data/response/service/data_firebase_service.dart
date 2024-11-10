import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../model/profilemodel.dart';
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
        //f

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

  // Sign up
  @override
  Future<String> uploadUserImgeUrl({required File file}) async {
    String fileName = "ju_grocery_${DateTime.now().millisecondsSinceEpoch}";
    Reference storageRef = firebaseStorage
        .ref()
        .child("seller")
        .child(firebaseAuth.currentUser!.uid)
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
}
