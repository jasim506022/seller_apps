import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_apps/res/app_string.dart';

import '../model/app_exception.dart';
import '../model/profile_model.dart';

import '../repository/sign_up_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_function.dart';

import '../res/routes/routes_name.dart';
import '../view/auth/widget/error_dialog_widget.dart';
import 'loading_controller.dart';
import 'select_image_controller.dart';

class SignUpController extends GetxController {
  final SignUpRepository repository;

  // Controllers for dependencies
  LoadingController loadingController = Get.find();
  SelectImageController selectImageController = Get.find();

  // TextEditingControllers for input fields
  final TextEditingController phontET = TextEditingController();
  final TextEditingController nameET = TextEditingController();
  final TextEditingController emailET = TextEditingController();
  final TextEditingController passwordET = TextEditingController();
  final TextEditingController confirmpasswordET = TextEditingController();

  // Constructor
  SignUpController({required this.repository});

  Future<void> createNewUserButton() async {
    if (!_validateInput()) return;

    try {
      loadingController.setLoading(true);

      var userProfileImageUrl = await repository.uploadUserImgeUrl(
          file: selectImageController.selectPhoto.value!);

      var user = await repository.createUserWithEmilandPasword(
          email: emailET.text.trim(), password: passwordET.text.trim());

      // Prepare ProfileModel
      ProfileModel profileModel = userProfileModel(user, userProfileImageUrl);

      // Upload user profile data
      repository.uploadUserProfile(
          profileModel: profileModel, documentId: user.user!.uid);
      clearInputFields();
      Get.offNamed(RoutesName.mainPage);
      AppsFunction.flutterToast(msg: AppString.signupSuccessfull);
      selectImageController.selectPhoto.value = null;
    } catch (e) {
      if (e is AppException) {
        _showErrorDialog(
          title: e.title!,
          content: e.message,
        );
      }
    } finally {
      loadingController.setLoading(false);
    }
  }

// User Profile Model
  ProfileModel userProfileModel(
      UserCredential user, String userProfileImageUrl) {
    return ProfileModel(
        name: nameET.text.trim(),
        earnings: 0.0,
        status: "approved",
        email: emailET.text.trim(),
        phone: phontET.text.trim(),
        uid: user.user!.uid,
        address: "",
        imageurl: userProfileImageUrl);
  }

  /// Validates user input and shows appropriate error messages

  bool _validateInput() {
    if (selectImageController.selectPhoto.value == null) {
      AppsFunction.flutterToast(msg: AppString.pleaseSelectPhoto);
      return false;
    }
    if (phontET.text.trim().isEmpty) {
      AppsFunction.flutterToast(msg: AppString.validPhoneNumber);
      return false;
    }
    if (passwordET.text != confirmpasswordET.text) {
      AppsFunction.flutterToast(msg: AppString.passwordMatch);

      return false;
    }

    return true;
  }

  void _showErrorDialog({required String title, String? content}) {
    Get.dialog(
      ErrorDialogWidget(
        icon: IconAsset.warningIcon,
        title: title,
        content: content,
        buttonText: AppString.okay,
      ),
    );
  }

  /// Clears input fields after successful signup

  clearInputFields() {
    passwordET.clear();
    emailET.clear();
    phontET.clear();
    confirmpasswordET.clear();
    nameET.clear();
    selectImageController.selectPhoto.value = null;
  }
}

// _showErrorDialog("", "Please select a profile image.",
      //     IconAsset.noImage);