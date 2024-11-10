import 'package:get/get.dart';
import 'package:seller_apps/controller/forget_password_controller.dart';
import 'package:seller_apps/repository/forget_password_repository.dart';

import '../controller/loading_controller.dart';
import '../controller/select_image_controller.dart';
import '../controller/sign_in_controller.dart';
import '../controller/sign_up_controller.dart';
import '../repository/select_image_repository.dart';
import '../repository/sign_in_repository.dart';
import '../repository/sign_up_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInRepository>(() => SignInRepository());

    Get.lazyPut<SignInController>(
        () => SignInController(repository: Get.find<SignInRepository>()));
    Get.put<LoadingController>(LoadingController());

  Get.lazyPut<SelectImageRepository>(() => SelectImageRepository());


    Get.lazyPut<SelectImageController>(() =>
        SelectImageController(repository: Get.find<SelectImageRepository>()));

    Get.lazyPut<SignUpRepository>(() => SignUpRepository());

    Get.put<SignUpController>(
        SignUpController(repository: Get.find<SignUpRepository>()));

          Get.lazyPut<ForgetPasswordRepository>(() => ForgetPasswordRepository());

    Get.put<ForgetPasswordController>(
        ForgetPasswordController(repository: Get.find<ForgetPasswordRepository>()));
  }
}
