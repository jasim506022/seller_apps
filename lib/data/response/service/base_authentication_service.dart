import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../model/profile_model.dart';

abstract class BaseAuthenticationService {
  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<UserCredential?> signWithGoogle();
  Future<bool> userExists();
  Future<void> createUserGmail(
      {required User user, required ProfileModel profileModel});

  Future<String> uploadUserImgeUrl({required File file});
  Future<UserCredential> createUserWithEmilandPasword(
      {required String email, required String password});
  Future<void> uploadUserProfile(
      {required ProfileModel profileModel, required String firebaseDocument});

  Future<void> forgetPasswordSnapshot({required String email});

  Future<void> signOutApp();
}
