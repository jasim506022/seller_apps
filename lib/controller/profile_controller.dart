import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../model/profile_model.dart';
import '../repository/auth_reposity.dart';
import '../repository/profile_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_constants.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../res/routes/routes_name.dart';
import '../widget/error_dialog_widget.dart';
import '../widget/show_alert_dialog_widget.dart';
import 'loading_controller.dart';
import 'select_image_controller.dart';

class ProfileController extends GetxController {
  // Dependencies
  final ProfileRepository repository;
  final AuthRepository authRepository = Get.find<AuthRepository>();
  final LoadingController loadingController = Get.find<LoadingController>();
  final SelectImageController selectImageController =
      Get.find<SelectImageController>();

  // Reactive variables for profile data and UI state
  final RxBool isDataChanged = false.obs;
  final RxString image = "".obs;

  // TextEditingControllers for profile fields
  final TextEditingController nameTEC = TextEditingController();
  final TextEditingController addressTEC = TextEditingController();
  final TextEditingController phoneTEC = TextEditingController();
  final TextEditingController emailTEC = TextEditingController();

  // Constructor with required repository
  ProfileController({required this.repository});

  @override
  void onClose() {
    // Dispose of all text controllers to prevent memory leaks
    for (final controller in [nameTEC, addressTEC, phoneTEC, emailTEC]) {
      controller.dispose();
    }
    // Reset observables to their initial states
    isDataChanged(false);
    image.value = "";
  }

  /// Updates user profile information in the database.
  Future<void> updateProfile() async {
    if (phoneTEC.text.trim().isEmpty) {
      AppsFunction.flutterToast(msg: AppStrings.givemPhoneNumbeer);
      return;
    }

    try {
      loadingController.setLoading(true);

      // Upload new profile image if a new one is selected
      if (selectImageController.selectPhoto.value != null) {
        image.value = await authRepository.uploadUserImage(
            file: selectImageController.selectPhoto.value!, isProfile: true);
      }

      // Update profile in database
      await repository.updateUserProfile(
          map: _buildProfileModel().toMapProfileEdit());
      // Navigate to main page and show success message
      Get.offAllNamed(RoutesName.mainPage, arguments: 3);
      AppsFunction.flutterToast(msg: AppStrings.successfullyUpdate);
    } catch (e) {
      _handleError(e);
    } finally {
      loadingController.setLoading(false);
    }
  }

  /// Builds an updated ProfileModel object from the text controllers.
  ProfileModel _buildProfileModel() {
    return ProfileModel(
      address: addressTEC.text.trim(),
      phone: phoneTEC.text.trim(),
      name: nameTEC.text.trim(),
      imageurl: image.value,
    );
  }

  /// Adds listeners to detect changes in text fields and update the UI state.
  void addChangeListener(ProfileModel profile) {
    final controllers = [
      nameTEC,
      phoneTEC,
      addressTEC,
    ];

    for (var textField in controllers) {
      textField.addListener(() {
        isDataChanged.value = _isProfileChanged(profile);
      });
    }
  }

  /// Checks if the profile has been modified.
  bool _isProfileChanged(ProfileModel profile) {
    return nameTEC.text.trim() != profile.name ||
        phoneTEC.text.trim() != profile.phone ||
        addressTEC.text.trim() != profile.address;
  }

  /// Fetches user profile data from the database and updates the UI state.
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserProfile() async {
    try {
      var snapshot = await repository.fetchUserProfile();

      /// Ensure snapshot contains data before proceeding
      var profileModel = ProfileModel.fromMap(snapshot.data()!);

      /// Only proceed if user status is "approved"
      if (profileModel.status == AppStrings.approved) {
        await _saveProfileToSharedPreferences(profileModel);
        _updateTextControllers(profileModel);
        // Update Firebase Cloud Messaging (FCM) token
        var token = await getFCMToken();
        await repository.updateUserProfile(map: {"token": token});
      }
      return snapshot;
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// Saves the user's profile data to shared preferences.
  Future<void> _saveProfileToSharedPreferences(
      ProfileModel profileModel) async {
    final prefs = AppConstants.sharedPreference!;
    final prefsTasks = [
      prefs.setString(AppStrings.uidSharedPreference, profileModel.uid!),
      prefs.setString(AppStrings.emailSharedPreference, profileModel.email!),
      prefs.setString(AppStrings.nameSharedPreference, profileModel.name!),
      prefs.setString(
          AppStrings.imageurlSharedPreference, profileModel.imageurl!),
      prefs.setString(AppStrings.phoneSharedPreference, profileModel.phone!),
      prefs.setDouble(AppStrings.earningSharedPreference,
          profileModel.earnings!.toDouble()),
    ];
    await Future.wait(prefsTasks);
  }

  /// Updates the UI text controllers with the fetched user profile data.
  void _updateTextControllers(ProfileModel profileModel) {
    nameTEC.text = profileModel.name ?? '';
    addressTEC.text = profileModel.address ?? '';
    phoneTEC.text = profileModel.phone ?? '';
    emailTEC.text = profileModel.email ?? '';
    image.value = profileModel.imageurl ?? '';
  }

  Future<void> handleBackNavigaion(bool didPop) async {
    if (didPop) return; // If the user already popped, exit

    if (!isDataChanged.value) {
      Get.back(); // Simply navigate back if no changes
      return;
    }
    Get.dialog(ShowAlertDialogWidget(
        icon: Icons.question_mark_rounded,
        title: AppStrings.saveChangesTitle,
        content: AppStrings.saveMessage,
        onCancelPressed: () {
          Get.close(2);
          resetInputs();
        },
        onConfirmPressed: () => Get.back()));
  }

  void resetInputs() {
    // Clear all text controllers
    for (var controller in [
      nameTEC,
      phoneTEC,
      emailTEC,
      addressTEC,
    ]) {
      controller.text = '';
    }
    // Reset selected image
    selectImageController.selectPhoto.value = null;
    // Reset data change flag
    isDataChanged.value = false;
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
        AppsFunction.flutterToast(msg: AppStrings.permissionDenied);
      }
    } catch (e) {
      AppsFunction.flutterToast(msg: "${AppStrings.fcmTokenError} $e");
    }
    return null;
  }

  /// Handles exceptions by showing a dialog.
  void _handleError(Object error) {
    if (error is AppException) {
      Get.dialog(
        ErrorDialogWidget(
          icon: AppIcons.warningIcon,
          title: error.title!,
          content: error.message,
          buttonText: AppStrings.btnOkay,
        ),
      );
    }
  }

  /// Displays a confirmation dialog asking the user if they want to exit the app.
  /// If the user confirms, the app will be closed.
  Future<void> exitApps(bool didPop) async {
    // If the app screen was already popped, do nothing.
    if (didPop) return;

    final bool shouldPop = await Get.dialog<bool>(ShowAlertDialogWidget(
          icon: Icons.question_mark_rounded,
          title: AppStrings.exitDialogTitle,
          content: AppStrings.confirmExitMessage,
          onConfirmPressed: () => Get.back(result: true),
          onCancelPressed: () => Get.back(result: false),
        )) ??
        false;
    // Exit the app if the user confirmed.
    if (shouldPop) SystemNavigator.pop();
  }

  /// Handles user sign-out with a confirmation dialog.
  Future<void> signOut() async {
    await Get.dialog(ShowAlertDialogWidget(
        icon: Icons.delete,
        title: AppStrings.signOut,
        content: AppStrings.doYouwantSignout,
        onConfirmPressed: () async {
          try {
            final prefs = AppConstants.sharedPreference!;
            await prefs.setString(AppStrings.imageurlSharedPreference, "");
            await prefs.setString(AppStrings.nameSharedPreference, "");
            await prefs.setString(AppStrings.emailSharedPreference, "");
            await repository.updateUserProfile(map: {"token": ""});
            await authRepository.signOut();
            AppsFunction.flutterToast(msg: AppStrings.successfullySignedOut);

            Get.offAllNamed(RoutesName.signPage);
          } catch (e) {
            AppsFunction.handleException(e);
          }
        }));
  }
}


/*
controller.text = ''; // Use `text = ''` instead of `clear()`
Why Use controller.text = '' Instead of .clear()?
Better performance: .clear() internally calls notifyListeners(), which can cause unnecessary UI rebuilds.
More predictable: Directly setting .text = '' ensures that changes happen without side effects.

#: ()

#: Why use Final (already)
*/

