import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import '../data/response/app_data_exception.dart';
import '../data/response/service/data_firebase_service.dart';
import '../model/profilemodel.dart';
import '../res/app_function.dart';

class SignUpRepository {
  final _dataFirebaseService = DataFirebaseService();

  Future<String> uploadUserImgeUrl({required File file}) async {
    try {
      return _dataFirebaseService.uploadUserImgeUrl(file: file);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Future<UserCredential> createUserWithEmilandPasword(
      {required String email, required String password}) {
    try {
      return _dataFirebaseService.createUserWithEmilandPasword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    } catch (e) {
      AppsFunction.handleException(e);
      throw OthersException(e.toString());
    }
  }

  Future<void> uploadUserProfile(
      {required ProfileModel profileModel, required String documentId}) async {
    try {
      _dataFirebaseService.uploadUserProfile(
          profileModel: profileModel, firebaseDocument: documentId);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }
}
