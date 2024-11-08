import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class BaseFirebaseService {

   FirebaseAuth get firebaseAuth;
  FirebaseFirestore get firebaseFirestore;
  FirebaseStorage get firebaseStorage;

  User? getCurrentUser();
    Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password});
       Future<UserCredential?> signWithGoogle();
       Future<bool> userExists(); 
         Future<void> createUserGmail({required User user});
}
