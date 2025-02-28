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

/// **ProfileController**
///
/// Handles user profile operations:
/// - Fetching/updating profile data.
/// - Managing text fields and UI state.
/// - Handling authentication and sign-out.
/// - Managing Firebase Cloud Messaging (FCM) token
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Constructor with required repository
  ProfileController({required this.repository});

  @override
  void onClose() {
    // Dispose of all text controllers to prevent memory leaks
    for (final controller in [
      nameController,
      addressController,
      phoneController,
      emailController
    ]) {
      controller.dispose();
    }
    // Reset observables to their initial states
    isDataChanged(false);
    image.value = "";
    super.onClose();
  }

  /// **Updates user profile information in Firestore.**
  Future<void> updateProfile() async {
    if (phoneController.text.trim().isEmpty) {
      AppsFunction.flutterToast(msg: AppStrings.phoneNumberPromptMessage);
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
      await repository.updateProfile(
          map: _buildProfileModel().toMapProfileEdit());
      // Navigate to main page and show success message
      Get.offAllNamed(RoutesName.mainPage, arguments: 3);
      AppsFunction.flutterToast(msg: AppStrings.profileUpdateToast);
    } catch (e) {
      _handleError(e);
    } finally {
      loadingController.setLoading(false);
    }
  }

  /// **Creates an updated ProfileModel from text fields.**
  ProfileModel _buildProfileModel() {
    return ProfileModel(
      address: addressController.text.trim(),
      phone: phoneController.text.trim(),
      name: nameController.text.trim(),
      imageurl: image.value,
    );
  }

  /// **Adds listeners to detect profile field changes.**
  void addChangeListener(ProfileModel profile) {
    final controllers = [
      nameController,
      phoneController,
      addressController,
    ];

    for (var textField in controllers) {
      textField.addListener(() {
        isDataChanged.value = _isProfileChanged(profile);
      });
    }
  }

  /// **Checks if the profile has been modified.**
  bool _isProfileChanged(ProfileModel profile) {
    return nameController.text.trim() != profile.name ||
        phoneController.text.trim() != profile.phone ||
        addressController.text.trim() != profile.address;
  }

  /// **Fetches user profile from Firestore and updates UI.**
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserProfile() async {
    try {
      var snapshot = await repository.fetchUserProfile();

      /// Ensure snapshot contains data before proceeding
      var data = snapshot.data()!;

      /// Convert Firestore data into `ProfileModel`
      var profileModel = ProfileModel.fromMap(data);

      /// Only proceed if user status is **approved**.
      if (profileModel.status == AppStrings.approved) {
        await _storeProfileLocally(profileModel);
        _populateTextFields(profileModel);

        /// Update Firebase Cloud Messaging (FCM) token
        var token = await fetchFCMToken();
        await repository.updateProfile(map: {"token": token});
      }
      return snapshot;
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// **Stores user profile locally in shared preferences.**
  Future<void> _storeProfileLocally(ProfileModel profileModel) async {
    var prefs = AppConstants.sharedPreference;
    final prefsTasks = [
      prefs!.setString(AppStrings.prefUserId, profileModel.uid!),
      prefs.setString(AppStrings.prefUserEmail, profileModel.email!),
      prefs.setString(AppStrings.prefUserName, profileModel.name!),
      prefs.setString(AppStrings.prefUserProfilePic, profileModel.imageurl!),
      prefs.setString(AppStrings.prefUserPhone, profileModel.phone!),
      prefs.setDouble(
          AppStrings.prefUserEarnings, profileModel.earnings!.toDouble()),
    ];

    await Future.wait(prefsTasks);
  }

  /// **Updates UI text fields with user profile data.**
  void _populateTextFields(ProfileModel profileModel) {
    nameController.text = profileModel.name ?? '';
    addressController.text = profileModel.address ?? '';
    phoneController.text = profileModel.phone ?? '';
    emailController.text = profileModel.email ?? '';
    image.value = profileModel.imageurl ?? '';
  }

  /// **Handles back navigation, prompting to save changes if necessary.**
  Future<void> handleBackNavigation(bool didPop) async {
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

  /// **Resets input fields and profile image selection.*
  void resetInputs() {
    // Clear all text controllers
    for (var controller in [
      nameController,
      phoneController,
      emailController,
      addressController,
    ]) {
      controller.text = '';
    }
    // Reset selected image
    selectImageController.selectPhoto.value = null;
    // Reset data change flag
    isDataChanged.value = false;
  }

  /// **Fetches Firebase Cloud Messaging (FCM) token.**
  Future<String?> fetchFCMToken() async {
    try {
      // Request permission for iOS devices
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // Retrieve the token
        String? token = await FirebaseMessaging.instance.getToken();
        return token;
      } else {
        AppsFunction.flutterToast(msg: AppStrings.permissionDeniedToast);
      }
    } catch (e) {
      AppsFunction.flutterToast(msg: "${AppStrings.fcmTokenErrorToast} $e");
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
  Future<void> exitApp(bool didPop) async {
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
        title: AppStrings.signOutLabel,
        content: AppStrings.doYouwantSignoutMessage,
        onConfirmPressed: () async {
          try {
            final prefs = AppConstants.sharedPreference!;
            await prefs.setString(AppStrings.prefUserProfilePic, "");
            await prefs.setString(AppStrings.prefUserName, "");
            await prefs.setString(AppStrings.prefUserEmail, "");
            await repository.updateProfile(map: {"token": ""});
            await authRepository.signOut();
            AppsFunction.flutterToast(
                msg: AppStrings.successfullySignedOutToast);

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
#: What is memoery Leak
/// Dispose text controllers to prevent memory leaks.
#: ()
how double to num
#: Why use Final (already)
#:     [nameController, addressController, phoneController, emailController].forEach((c) => c.dispose());

*/

