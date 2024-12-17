import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../model/profile_model.dart';
import '../repository/profile_repository.dart';
import '../repository/sign_up_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_constants.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../res/routes/routes_name.dart';
import '../view/auth/widget/error_dialog_widget.dart';
import '../widget/loadingwidget.dart';
import '../widget/show_alert_dialog_widget.dart';
import 'select_image_controller.dart';

class ProfileController extends GetxController {
  final ProfileRepository repository;
  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  var image = "".obs;
  var nameTEC = TextEditingController();
  var addressTEC = TextEditingController();
  var phoneTEC = TextEditingController();
  var emailTEC = TextEditingController();

  var isLoading = false.obs;

  var isChange = false.obs;

  var profileModel = ProfileModel().obs;
  ProfileController({required this.repository});

  var selectImageController = Get.find<SelectImageController>();
  var signUpRepository = SignUpRepository();

  // Understand This Code
  Future<void> updateUserData() async {
    if (phoneTEC.text.trim().isEmpty) {
      AppsFunction.flutterToast(msg: "Please Give your Phone Numer");
      return;
    }

    try {
      Get.dialog(
          barrierDismissible: false,
          const LoadingWidget(message: "Profile Update"));

      if (selectImageController.selectPhoto.value != null) {
        image.value = await signUpRepository.uploadUserImgeUrl(
            file: selectImageController.selectPhoto.value!);
      }

      final updatedProfile = _buildUpdatedProfileModel();
      repository.updateUserData(map: updatedProfile.toMapProfileEdit());

      isChange.value = false;
      Get.back();
      Get.offAllNamed(RoutesName.mainPage, arguments: 3);
      AppsFunction.flutterToast(msg: "Succesfully Update");
    } catch (e) {
      if (e is AppException) {
        Get.dialog(
          ErrorDialogWidget(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay",
          ),
        );
      }
    }
  }

  ProfileModel _buildUpdatedProfileModel() {
    return ProfileModel(
      address: addressTEC.text.trim(),
      phone: phoneTEC.text.trim(),
      name: nameTEC.text.trim(),
      imageurl: image.value,
    );
  }

  void addChangeListener() {
    final controllers = [
      nameTEC,
      phoneTEC,
      addressTEC,
    ];

    for (var textField in controllers) {
      textField.addListener(() {
        isChange.value = true;
      });
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getData() {
    return repository.getUserInformationSnapshot();
  }

  void fetchProfile() async {
    try {
      // Attempt to get data from SharedPreferences
      final imageUrl = AppConstants.sharedPreference
          ?.getString(AppString.imageurlSharedPreference);
      final name = AppConstants.sharedPreference
          ?.getString(AppString.nameSharedPreference);
      final email = AppConstants.sharedPreference
          ?.getString(AppString.emailSharedPreference);

      if (imageUrl != null && name != null && email != null) {
        // If SharedPreferences has data, use it
        profileModel.value = ProfileModel(
          imageurl: imageUrl,
          name: name,
          email: email,
        );
      } else {
        // If not, fetch data from the server or other sources
        isLoading.value = true;

        final fetchedData = await getData(); // Simulated API call
        final dataMap = fetchedData.data();

        if (dataMap != null) {
          profileModel.value = ProfileModel.fromMap(dataMap);
        } else {
          throw Exception("No data returned from API");
        }
      }
    } catch (e) {
      // Log error in debug mode
      if (kDebugMode) {
        print("Error fetching profile: $e");
      }
    } finally {
      // Ensure loading indicator is stopped
      isLoading.value = false;
    }
  }

/*
  void fetchProfile() async {
    try {
      var image = AppConstants.sharedPreference!
          .getString(AppString.imageurlSharedPreference);
      var name = AppConstants.sharedPreference!
          .getString(AppString.nameSharedPreference);
      var email = AppConstants.sharedPreference!
          .getString(AppString.emailSharedPreference);

      if (image != null && name != null && email != null) {
        profileModel.value = ProfileModel(
          imageurl: image,
          name: name,
          email: email,
        );
      } else {
        isLoading.value = true;

        var fetchedData = await getData(); // Simulated API call
        profileModel.value = ProfileModel.fromMap(fetchedData.data()!);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching profile: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }
*/

  Future<void> getUserInformationSnapshot() async {
    try {
      var snapshot = await repository.getUserInformationSnapshot();
      if (snapshot.exists && snapshot.data() != null) {
        profileModel.value = ProfileModel.fromMap(snapshot.data()!);
        if (profileModel.value.status == AppString.approved) {
          _saveProfileToSharedPreferences();
          _updateTextControllers();
          var token = await getFCMToken();
          print(token);
          FirebaseFirestore.instance
              .collection("seller")
              .doc(profileModel.value.uid)
              .update({"token": token});
        }
      }
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
    }
  }

  Future<void> handleBackNavigaion(bool didPop) async {
    if (didPop) return;

    if (isChange.value == false) {
      Get.back();
      return;
    }
    Get.dialog(ShowAlertDialogWidget(
        icon: Icons.question_mark_rounded,
        title: "Save Changed?",
        content: 'do you want to save change?',
        onNoPressed: () {
          isChange.value = false;
          Get.close(2);
          selectImageController.selectPhoto.value = null;
        },
        onYesPressed: () => Get.back()));
  }

  Future<void> _saveProfileToSharedPreferences() async {
    var profile = profileModel.value;
    final prefsTasks = [
      AppConstants.sharedPreference!
          .setString(AppString.uidSharedPreference, profile.uid!),
      AppConstants.sharedPreference!
          .setString(AppString.emailSharedPreference, profile.email!),
      AppConstants.sharedPreference!
          .setString(AppString.nameSharedPreference, profile.name!),
      AppConstants.sharedPreference!
          .setString(AppString.imageurlSharedPreference, profile.imageurl!),
      AppConstants.sharedPreference!
          .setString(AppString.phoneSharedPreference, profile.phone!),
      AppConstants.sharedPreference!.setDouble(
          AppString.earningSharedPreference, profile.earnings!.toDouble()),
    ];
    await Future.wait(prefsTasks);
  }

  void _updateTextControllers() {
    nameTEC.text = profileModel.value.name ?? '';
    addressTEC.text = profileModel.value.address ?? '';
    phoneTEC.text = profileModel.value.phone ?? '';
    emailTEC.text = profileModel.value.email ?? '';
    image.value = profileModel.value.imageurl ?? '';
  }

  Future<void> signOut() async {
    Get.dialog(ShowAlertDialogWidget(
        icon: Icons.delete,
        title: "Sign Out",
        content: 'Do you want to sign out?',
        onYesPressed: () async {
          try {
            await AppConstants.sharedPreference
                ?.setString(AppString.imageurlSharedPreference, "");
            await AppConstants.sharedPreference
                ?.setString(AppString.nameSharedPreference, "");
            FirebaseFirestore.instance
                .collection("seller")
                .doc(profileModel.value.uid)
                .update({"token": ""});
            await repository.signOut();
            AppsFunction.flutterToast(msg: "Successfully Signed Out");

            Get.offAllNamed(RoutesName.signPage);
          } catch (e) {
            AppsFunction.handleException(e);
          }
        }));
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
Used safe navigation (?.) for AppConstants.sharedPreference to avoid null checks.
*/