import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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
      AppsFunction.flutterToast(msg: AppString.givemPhoneNumbeer);
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
      AppsFunction.flutterToast(msg: AppString.successfullyUpdate);
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

      

      var profileModel = ProfileModel.fromMap(snapshot.data()!);

      if (profileModel.status == AppString.approved) {
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

  /// Saves the fetched profile data to SharedPreferences
  Future<void> _saveProfileToSharedPreferences(
      ProfileModel profileModel) async {
    final prefs = AppConstants.sharedPreference!;
    final prefsTasks = [
      prefs.setString(AppString.uidSharedPreference, profileModel.uid!),
      prefs.setString(AppString.emailSharedPreference, profileModel.email!),
      prefs.setString(AppString.nameSharedPreference, profileModel.name!),
      prefs.setString(
          AppString.imageurlSharedPreference, profileModel.imageurl!),
      prefs.setString(AppString.phoneSharedPreference, profileModel.phone!),
      prefs.setDouble(
          AppString.earningSharedPreference, profileModel.earnings!.toDouble()),
    ];
    await Future.wait(prefsTasks);
  }

  /// Updates UI controllers with the new profile data
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
        title: AppString.saveChanges,
        content: AppString.saveMessage,
        onNoPressed: () {
          Get.close(2);
          resetInputs();
        },
        onYesPressed: () => Get.back()));
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
        AppsFunction.flutterToast(msg: AppString.permissionDenied);
      }
    } catch (e) {
      AppsFunction.flutterToast(msg: "${AppString.fcmTokenError} $e");
    }
    return null;
  }

  /// Handles exceptions by showing a dialog.
  void _handleError(Object error) {
    if (error is AppException) {
      Get.dialog(
        ErrorDialogWidget(
          icon: IconAsset.warningIcon,
          title: error.title!,
          content: error.message,
          buttonText: AppString.okay,
        ),
      );
    }
  }

  /// Handles user sign-out with a confirmation dialog.
  Future<void> signOut() async {
    await Get.dialog(ShowAlertDialogWidget(
        icon: Icons.delete,
        title: AppString.signOut,
        content: AppString.doYouwantSignout,
        onYesPressed: () async {
          try {
            final prefs = AppConstants.sharedPreference!;
            await prefs.setString(AppString.imageurlSharedPreference, "");
            await prefs.setString(AppString.nameSharedPreference, "");
            await prefs.setString(AppString.emailSharedPreference, "");
            await repository.updateUserProfile(map: {"token": ""});
            await authRepository.signOut();
            AppsFunction.flutterToast(msg: AppString.successfullySignout);

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

#: Why use Final
*/


/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_apps/controller/profile_controller.dart';

import '../../../model/profile_model.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_string.dart';
import '../../loading_widget/loading_profile_header_widget.dart';
import 'user_profile_content.dart';

class HomeProfileHeaderWidget extends StatelessWidget {
  const HomeProfileHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();
    final image = AppConstants.sharedPreference
        ?.getString(AppString.imageurlSharedPreference);
    var name = AppConstants.sharedPreference
        ?.getString(AppString.nameSharedPreference);
    var email = AppConstants.sharedPreference
        ?.getString(AppString.emailSharedPreference);

    print(image == null && name == null && email == null);

    print(image);
    print(name);
    print(email);

    if ((image == null || image.isEmpty) &&
        (name == null || name.isEmpty) &&
        (email == null || email.isEmpty)) {
      print("Bangladesh");
      return FutureBuilder(
        future: profileController.getUserProfileData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingProfileHeaderWidget();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            var data = snapshot.data!.data();
            if (data != null) {
              var profileModel = ProfileModel.fromMap(data);
              return UserProfileContent(
                  imageUrl: profileModel.imageurl ?? "",
                  name: profileModel.name ?? "Unknows User",
                  email: profileModel.email ?? "No Email");
            }
          }
          return const LoadingProfileHeaderWidget();
        },
      );
    } else {
      print("Bangladesh1");
      print(image!);
      return UserProfileContent(imageUrl: image!, name: name!, email: email!);
    }
  }
}

*/