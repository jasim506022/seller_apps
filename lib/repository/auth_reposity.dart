import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:seller_apps/data/response/service/data_authentication_service.dart';

import '../data/response/app_data_exception.dart';
import '../model/profile_model.dart';
import '../res/app_function.dart';

class AuthReposity {
  final DataAuthenticationService _authService = DataAuthenticationService();

  /// Signs in a user using their email and password.
  Future<UserCredential> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await _authService.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  /// Signs in a user using their Google account.
  Future<UserCredential?> loginWithGoogle() async {
    try {
      return await _authService.signWithGoogle();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  /// Checks if a user profile exists in Firestore.
  Future<bool> isUserProfileExists() async {
    try {
      return await _authService.userExists();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  /// Creates a new user profile in Firestore using Google credentials.
  Future<void> createUserWithGoogle(
      {required User user, required ProfileModel profileModel}) async {
    try {
      await _authService.createUserGmail(
          user: user, profileModel: profileModel);
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }

  /// Uploads a user image to Firebase Storage and returns the URL.
  Future<String> uploadUserImage(
      {required File file, bool isProfile = false}) async {
    try {
      return _authService.uploadUserImgeUrl(file: file, isProfile: isProfile);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  /// Creates a new user account with an email and password.
  Future<UserCredential> registerUserWithEmailAndPassword(
      {required String email, required String password}) {
    try {
      return _authService.createUserWithEmilandPasword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    } catch (e) {
      AppsFunction.handleException(e);
      throw OthersException(e.toString());
    }
  }

  /// Updates or creates a user profile in Firestore.

  Future<void> saveUserProfile(
      {required ProfileModel profileModel, required String documentId}) async {
    try {
      _authService.uploadUserProfile(
          profileModel: profileModel, firebaseDocument: documentId);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  /// Sends a password reset email to the provided email address.
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _authService.forgetPasswordSnapshot(email: email);
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOutApp();
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }
}
