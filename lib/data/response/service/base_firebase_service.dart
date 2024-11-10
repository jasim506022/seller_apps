import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../model/profilemodel.dart';

abstract class BaseFirebaseService {
  FirebaseAuth get firebaseAuth;
  FirebaseFirestore get firebaseFirestore;
  FirebaseStorage get firebaseStorage;

  User? getCurrentUser();
  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<UserCredential?> signWithGoogle();
  Future<bool> userExists();
  Future<void> createUserGmail({required User user, required ProfileModel profileModel});

  // Sign Up Page
  Future<String> uploadUserImgeUrl({required File file});
  Future<UserCredential> createUserWithEmilandPasword(
      {required String email, required String password});
  Future<void> uploadUserProfile(
      {required ProfileModel profileModel, required String firebaseDocument});

 Future<void> forgetPasswordSnapshot({required String email});

}
