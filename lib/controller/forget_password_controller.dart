import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../repository/forget_password_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../res/routes/routes_name.dart';
import '../view/auth/widget/error_dialog_widget.dart';
import 'loading_controller.dart';

class ForgetPasswordController extends GetxController {
  final TextEditingController emailET = TextEditingController();

  final ForgetPasswordRepository repository;

  LoadingController loadingController = Get.find();

  ForgetPasswordController({required this.repository});

  void cleanTextField() {
    emailET.clear();
  }

  Future<void> sendPasswordResetRequest() async {
    try {
      loadingController.setLoading(true);
      repository.forgetPasswordSnapshot(email: emailET.text.trim());
      AppsFunction.flutterToast(msg: AppString.sendingMail);
      Get.toNamed(RoutesName.signPage);
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
      loadingController.setLoading(false);
    }
  }
}
