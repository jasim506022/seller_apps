import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../model/profile_model.dart';
import '../../../res/app_string.dart';
import 'base_authentication_service.dart';

class DataAuthenticationService extends BaseAuthenticationService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseStorage = FirebaseStorage.instance;

  /// Sign in user with email and password
  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Sign in user with Google account
  @override
  Future<UserCredential?> signWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return _firebaseAuth.signInWithCredential(credential);
  }

  /// Check if the user exists in Firestore
  @override
  Future<bool> userExists() async {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) return false;

    final userDoc = await _firebaseFirestore
        .collection(AppString.sellersCollection)
        .doc(userId)
        .get();

    return userDoc.exists;
  }

  /// Create a new user document in Firestore using Gmail account
  @override
  Future<void> createUserGmail(
      {required User user, required ProfileModel profileModel}) async {
    _firebaseFirestore
        .collection(AppString.sellersCollection)
        .doc(user.uid)
        .set(profileModel.toMap());
  }

  /// Upload user image to Firebase Storage and return its download URL
  @override
  Future<String> uploadUserImgeUrl(
      {required File file, bool isProfile = false}) async {
    String fileName = "ju_grocery_${DateTime.now().millisecondsSinceEpoch}";
    final storagePath = isProfile
        ? "${AppString.sellersCollection}/${_firebaseAuth.currentUser!.uid}/profile/$fileName"
        : "${AppString.sellersCollection}/profile/$fileName";

    final ref = _firebaseStorage.ref().child(storagePath);
    final uploadTask = ref.putFile(file);

    final snapshot = await uploadTask.whenComplete(() {});
    return snapshot.ref.getDownloadURL();
  }

  /// Create a new user with email and password
  @override
  Future<UserCredential> createUserWithEmilandPasword(
          {required String email, required String password}) async =>
      _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  /// Upload or update user profile data in Firestore
  @override
  Future<void> uploadUserProfile(
      {required ProfileModel profileModel,
      required String firebaseDocument}) async {
    await _firebaseFirestore
        .collection(AppString.sellersCollection)
        .doc(firebaseDocument)
        .set(profileModel.toMap());
  }

  /// Send a password reset email to the user
  @override
  Future<void> forgetPasswordSnapshot({required String email}) async {
    _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOutApp() async {
    _firebaseAuth.signOut();
  }
}
