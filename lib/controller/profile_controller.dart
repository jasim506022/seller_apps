import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/global.dart';
import '../model/app_exception.dart';
import '../model/profilemodel.dart';
import '../repository/profile_repository.dart';
import '../repository/sign_up_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../res/routes/routes_name.dart';
import '../view/auth/widget/error_dialog_widget.dart';
import '../widget/loadingwidget.dart';
import '../widget/show_alert_dialog_widget.dart';
import 'select_image_controller.dart';

class ProfileController extends GetxController {
  final ProfileRepository repository;

  var image = "".obs;
  TextEditingController nameTEC = TextEditingController();
  TextEditingController addressTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();

  var isChange = false.obs;

  var profileModel = ProfileModel().obs;
  ProfileController({required this.repository});

  SelectImageController selectImageController = Get.find();
  SignUpRepository signUpRepository = SignUpRepository();

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

  Future<void> getUserInformationSnapshot() async {
    try {
      var snapshot = await repository.getUserInformationSnapshot();
      if (snapshot.exists && snapshot.data() != null) {
        profileModel.value = ProfileModel.fromMap(snapshot.data()!);

        if (profileModel.value.status == AppString.approved) {
          _saveProfileToSharedPreferences();
          _updateTextControllers();
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
    Get.dialog(CustomAlertDialogWidget(
        icon: Icons.question_mark_rounded,
        title: "Save Changed?",
        content: 'do you want to save change?',
        noOnPress: () {
          isChange.value = false;
          Get.close(2);
        },
        yesOnPress: () => Get.back()));
  }

  Future<void> _saveProfileToSharedPreferences() async {
    var profile = profileModel.value;
    final prefsTasks = [
      sharedPreference!.setString(AppString.uidSharedPreference, profile.uid!),
      sharedPreference!
          .setString(AppString.emailSharedPreference, profile.email!),
      sharedPreference!
          .setString(AppString.nameSharedPreference, profile.name!),
      sharedPreference!
          .setString(AppString.imageurlSharedPreference, profile.imageurl!),
      sharedPreference!
          .setString(AppString.phoneSharedPreference, profile.phone!),
      sharedPreference!.setDouble(
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
    Get.dialog(CustomAlertDialogWidget(
        icon: Icons.delete,
        title: "Sign Out",
        content: 'Do you want to sign out?',
        yesOnPress: () async {
          try {
            await sharedPreference?.setString(
                AppString.imageurlSharedPreference, "");
            await sharedPreference?.setString(
                AppString.nameSharedPreference, "");

            await repository.signOut();
            AppsFunction.flutterToast(msg: "Successfully Signed Out");
            Get.offAllNamed(RoutesName.signPage);
          } catch (e) {
            AppsFunction.handleException(e);
          }
        }));
  }
}
