import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../model/profile_model.dart';
import '../repository/sign_in_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_function.dart';

import '../res/app_string.dart';
import '../res/routes/routes_name.dart';
import '../view/auth/widget/error_dialog_widget.dart';
import 'loading_controller.dart';

class SignInController extends GetxController {
  // Repository for authentication and user management.
  final SignInRepository repository;
  // Loading controller for managing app-wide loading states.
  var loadingController = Get.find<LoadingController>();

  // Text editing controllers for capturing email and password input.
  final TextEditingController passwordET = TextEditingController();
  final TextEditingController emailET = TextEditingController();

  // Constructor to inject the required repository.
  SignInController({required this.repository});

  /// Disposes controllers to prevent memory leaks.
  @override
  void onClose() {
    passwordET.dispose();
    emailET.dispose();
    super.onClose();
  }

  /// Clears the input fields for email and password.
  void clearFields() {
    passwordET.clear();
    emailET.clear();
  }

  /// Signs in a user using email and password.
  Future<void> signInWithEmailAndPassword() async {
    try {
      // Activate loading state.
      loadingController.setLoading(true);

      // Attempt to sign in the user using the repository.
      await repository.signInWithEmailAndPassword(
        email: emailET.text,
        password: passwordET.text,
      );

      // Navigate to the main page on successful login.
      Get.offNamed(RoutesName.mainPage);
      // Clear input fields and show a success message.

      clearFields();
      AppsFunction.flutterToast(msg: AppString.signInSuccessfully);
    } catch (e) {
      if (e is AppException) {
        Get.dialog(
          ErrorDialogWidget(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: AppString.okay,
          ),
        );
      }
    } finally {
      // Deactivate loading state regardless of success or failure.
      loadingController.setLoading(false);
    }
  }

  /// Signs in a user using Google authentication.
  Future<void> signWithGoogle() async {
    try {
      // Show a loading dialog while attempting Google sign-in.
      Get.dialog(
        ErrorDialogWidget(
          icon: IconAsset.warningIcon,
          title: AppString.logInPageSubjectTitle,
          buttonText: AppString.okay,
        ),
        barrierDismissible:
            false, // Prevent the dialog from being dismissed manually.
      );

      // Authenticate the user via Google and get user credentials.
      var userCredentialGmail = await repository.signWithGoogle();
      // Dismiss the loading dialog.
      Get.back();
      if (userCredentialGmail != null) {
        // Check if the user already exists in the database.
        if (await repository.userExists()) {
          Get.offNamed(RoutesName.mainPage);
          AppsFunction.flutterToast(msg: AppString.signInSuccessfully);
        } else {
          var user = userCredentialGmail.user!;
          ProfileModel profileModel = buildUserModel(user);

          await repository.createUserGmail(
              user: user, profileModel: profileModel);
          Get.offNamed(RoutesName.mainPage);
          AppsFunction.flutterToast(msg: AppString.signInSuccessfully);
        }
      }
    } catch (e) {
      Get.back();
      if (e is AppException) {
        Get.dialog(
          ErrorDialogWidget(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: AppString.okay,
          ),
        );
      }
    }
  }

  ProfileModel buildUserModel(User user) {
    return ProfileModel(
        name: user.displayName,
        earnings: 0.0,
        status: "approved",
        email: user.email,
        phone: user.phoneNumber,
        uid: user.uid,
        address: "",
        imageurl: user.photoURL);
  }

  Future<String?> getFCMToken() async {
    try {
      // Request permission for iOS devices
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // Retrieve the token
        String? token = await FirebaseMessaging.instance.getToken();
        return token;
      } else {
        print("Permission denied for notifications.");
      }
    } catch (e) {
      print("Error retrieving FCM token: $e");
    }
    return null;
  }
}

/*
1. The controller directly interacts with UI-specific elements (like dialogs). Consider moving such logic to a separate utility/helper class to keep the controller focused on business logic.
2. passwordET and emailET are properly initialized and disposed of in onClose, preventing memory leaks.

*/