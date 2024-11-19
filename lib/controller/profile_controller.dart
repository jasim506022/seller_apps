import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/global.dart';
import '../model/app_exception.dart';
import '../model/profilemodel.dart';
import '../repository/profile_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_string.dart';
import '../view/auth/widget/error_dialog_widget.dart';

class ProfileController extends GetxController {
  final ProfileRepository repository;
  var image = "".obs;
  TextEditingController nameTEC = TextEditingController();
  TextEditingController addressTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();

  var profileModel = ProfileModel().obs;
  ProfileController({required this.repository});

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
}
