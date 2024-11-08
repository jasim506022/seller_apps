import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_apps/res/app_string.dart';

import '../model/app_exception.dart';
import '../repository/sign_in_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_function.dart';

import '../res/routes/routes_name.dart';
import '../view/auth/widget/error_dialog_widget.dart';
import 'loading_controller.dart';

class SignInController extends GetxController {
  final SignInRepository repository;
  var loadingController = Get.find<LoadingController>();

  final TextEditingController passwordET = TextEditingController();
  final TextEditingController emailET = TextEditingController();

  SignInController({required this.repository});

  @override
  void onClose() {
    passwordET.dispose();
    emailET.dispose();
    super.onClose();
  }

// clear Text Field
  void cleanTextField() {
    passwordET.clear();
    emailET.clear();
  }

  Future<void> signInWithEmailAndPassword() async {
    if (!(await AppsFunction.verifyInternetStatus())) {
      try {
        loadingController.setLoading(true);

        await repository.signInWithEmailAndPassword(
          email: emailET.text,
          password: passwordET.text,
        );

        loadingController.setLoading(false);

        Get.offNamed(RoutesName.mainPage);
        cleanTextField();
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
            barrierDismissible: false,
          );
        }
      } finally {
        loadingController.setLoading(false);
      }
    }
  }

  Future<void> signWithGoogle() async {
    try {
      Get.dialog(
        ErrorDialogWidget(
          icon: IconAsset.warningIcon,
          title: "Loading for sign with Gmail \n Pleasing Waiting........",
          buttonText: AppString.okay,
        ),
        barrierDismissible: false,
      );

      var userCredentialGmail = await repository.signWithGoogle();

      if (userCredentialGmail != null) {
        Get.back();
        if (await repository.userExists()) {
          Get.offNamed(RoutesName.mainPage);
          AppsFunction.flutterToast(msg: AppString.signInSuccessfully);
        } else {
          await repository.createUserGmail(user: userCredentialGmail.user!);
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
}
