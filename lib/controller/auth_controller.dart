import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../model/profile_model.dart';
import '../repository/auth_reposity.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../res/routes/routes_name.dart';
import '../widget/error_dialog_widget.dart';
import '../widget/show_alert_dialog_widget.dart';
import 'loading_controller.dart';
import 'select_image_controller.dart';

class AuthController extends GetxController {
  final AuthRepository repository;
  final LoadingController loadingController = Get.find();
  final SelectImageController selectImageController = Get.find();

  // TextEditingControllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  // Constructor
  AuthController({required this.repository});

  // Lifecycle methods
  /// Disposes controllers to prevent memory leaks.
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    nameController.dispose();
    super.onClose();
  }

  /// Resets all input fields to initial state.
  void clearInputFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    phoneController.clear();
    nameController.clear();
    selectImageController.selectPhoto.value = null;
  }

  /// Signs in the user using email and password.
  ///
  Future<void> signIn() async {
    try {
      loadingController.setLoading(true);
      await repository.loginWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (await repository.isUserProfileExists()) {
        _navigateToMainPage(AppStrings.signInSuccessfully);
        clearInputFields();
      } else {
        AppsFunction.flutterToast(msg: AppStrings.userDoesntExit);
      }
    } catch (e) {
      _handleError(e);
    } finally {
      loadingController.setLoading(false);
    }
  }

  /// Signs in a user using Google authentication.
  Future<void> signInWithGoogle() async {
    try {
      _showLoadingDialog();

      var userCredentialGmail = await repository.loginWithGoogle();

      Get.back();

      if (userCredentialGmail != null) {
        if (await repository.isUserProfileExists()) {
          _navigateToMainPage(AppStrings.signInSuccessfully);
        } else {
          var user = userCredentialGmail.user!;
          ProfileModel profileModel = buildUserProfile(user: user);

          await repository.createNewUserWithGoogle(
              user: user, profileModel: profileModel);

          _navigateToMainPage(AppStrings.signInSuccessfully);
        }
      }
    } catch (e) {
      Get.back();
      _handleError(e);
    }
  }

  /// Registers a new user with email and password.
  Future<void> registerUser() async {
    if (!_validateInput()) return;

    try {
      loadingController.setLoading(true);

      var imageUrl = await repository.uploadUserImage(
          file: selectImageController.selectPhoto.value!);

      var user = await repository.registerUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      ProfileModel profile = buildUserProfile(
          user: user.user!,
          userProfileImageUrl: imageUrl,
          phoneNumber: phoneController.text.trim(),
          userName: nameController.text.trim());

      // Upload user profile data
      repository.saveUserProfile(
          profileModel: profile, documentId: user.user!.uid);

      clearInputFields();

      _navigateToMainPage(AppStrings.signupSuccessfull);
    } catch (e) {
      _handleError(e);
    } finally {
      loadingController.setLoading(false);
      selectImageController.selectPhoto.value = null;
    }
  }

  /// Displays a dialog asking the user for confirmation to exit the app.
  Future<void> exitApps(bool didPop) async {
    if (!loadingController.loading.value) {
      if (didPop) {
        return;
      }

      final bool shouldPop = await Get.dialog<bool>(
            ShowAlertDialogWidget(
              icon: Icons.question_mark_rounded,
              title: AppStrings.exitDialogTitle,
              content: AppStrings.confirmExitMessage,
              onConfirmPressed: () => Get.back(result: true),
              onCancelPressed: () => Get.back(result: false),
            ),
          ) ??
          false;

      if (shouldPop) SystemNavigator.pop();
    }
  }

  ProfileModel buildUserProfile(
      {required User user,
      String? userProfileImageUrl,
      String? userName,
      String? phoneNumber}) {
    return ProfileModel(
        name: userName ?? user.displayName ?? "",
        earnings: 0.0,
        status: AppStrings.approved,
        email: user.email,
        phone: phoneNumber ?? user.phoneNumber ?? "",
        uid: user.uid,
        address: "",
        imageurl: userProfileImageUrl ?? user.photoURL ?? "");
  }

  /// Sends a password reset email.
  Future<void> resetPassword() async {
    try {
      loadingController.setLoading(true);
      repository.sendPasswordResetEmail(email: emailController.text.trim());
      AppsFunction.flutterToast(msg: AppStrings.sendingMail);
      Get.toNamed(RoutesName.signPage);
    } catch (e) {
      _handleError(e);
    } finally {
      loadingController.setLoading(false);
    }
  }

  /// Validates user input and shows appropriate error messages
  bool _validateInput() {
    if (selectImageController.selectPhoto.value == null) {
      AppsFunction.flutterToast(msg: AppStrings.pleaseSelectPhoto);
      return false;
    }
    if (phoneController.text.trim().isEmpty) {
      AppsFunction.flutterToast(msg: AppStrings.validPhoneNumber);
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      AppsFunction.flutterToast(msg: AppStrings.passwordMatch);
      return false;
    }
    return true;
  }

  /// Navigates to the main page with a success message.
  void _navigateToMainPage(String message) {
    AppsFunction.flutterToast(msg: message);
    Get.offNamed(RoutesName.mainPage);
  }

  /// Displays a loading dialog.
  void _showLoadingDialog() {
    Get.dialog(
      ErrorDialogWidget(
        icon: AppIcons.warningIcon,
        title: AppStrings.logInPageSubjectTitle,
        buttonText: AppStrings.okay,
      ),
      barrierDismissible: false,
    );
  }

  /// Handles exceptions by showing a dialog.
  void _handleError(Object error) {
    if (error is AppException) {
      Get.dialog(
        ErrorDialogWidget(
          icon: AppIcons.warningIcon,
          title: error.title!,
          content: error.message,
          buttonText: AppStrings.okay,
        ),
      );
    }
  }
}
