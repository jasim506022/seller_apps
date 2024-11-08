import 'package:get/get.dart';

import '../controller/loading_controller.dart';
import '../controller/sign_in_controller.dart';
import '../repository/sign_in_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
      Get.lazyPut<SignInRepository>(() => SignInRepository());
  
      Get.lazyPut<SignInController>(
        () => SignInController(repository: Get.find<SignInRepository>()));
      Get.put<LoadingController>(LoadingController());
  }
}
