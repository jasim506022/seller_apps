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

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await firebaseAuth.signInWithCredential(credential);
  }

  
  @override
  Future<bool> userExists() async => (await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .get())
      .exists;
  @override
  Future<void> createUserGmail({required User user}) async {
    ProfileModel profileModel = ProfileModel(
        name: user.displayName,
        // cartlist: ["initial"],
        status: "approved",
        email: user.email,
        phone: user.phoneNumber,
        uid: user.uid,
        address: "",
        imageurl: user.photoURL);

    firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(profileModel.toMap());
  }
}
