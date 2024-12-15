import 'package:get/get.dart';
import 'package:seller_apps/controller/category_controller.dart';
import 'package:seller_apps/controller/delivary_controller.dart';
import 'package:seller_apps/controller/forget_password_controller.dart';
import 'package:seller_apps/repository/forget_password_repository.dart';

import '../controller/loading_controller.dart';
import '../controller/onboarding_controller.dart';
import '../controller/order_controller.dart';
import '../controller/product_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/search_controller.dart';
import '../controller/select_image_controller.dart';
import '../controller/sign_in_controller.dart';
import '../controller/sign_up_controller.dart';
import '../controller/splash_controller.dart';
import '../repository/delivary_repository.dart';
import '../repository/order_repository.dart';
import '../repository/product_repository.dart';
import '../repository/profile_repository.dart';
import '../repository/select_image_repository.dart';
import '../repository/sign_in_repository.dart';
import '../repository/sign_up_repository.dart';
import '../repository/splash_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashRepository>(() => SplashRepository());

    Get.lazyPut<SplashController>(
        () => SplashController(repository: Get.find<SplashRepository>()));

    Get.lazyPut<OnboardingController>(() => OnboardingController());

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

    Get.put<ForgetPasswordController>(ForgetPasswordController(
        repository: Get.find<ForgetPasswordRepository>()));

    Get.lazyPut<ProfileRepository>(() => ProfileRepository(), fenix: true);

    Get.lazyPut<ProfileController>(
        () => ProfileController(repository: Get.find<ProfileRepository>()),
        fenix: true);

    Get.lazyPut<CategoryController>(() => CategoryController(), fenix: true);
    Get.lazyPut<SearchControllers>(() => SearchControllers());

    Get.lazyPut<ProductRepository>(() => ProductRepository(), fenix: true);
    Get.lazyPut<ProductController>(
        () => ProductController(repository: Get.find<ProductRepository>()),
        fenix: true);
    Get.lazyPut<OrderRepository>(() => OrderRepository(), fenix: true);
    Get.lazyPut<OrderController>(
        () => OrderController(Get.find<OrderRepository>()),
        fenix: true);

    Get.lazyPut<DelivaryRepository>(() => DelivaryRepository(), fenix: true);
    Get.lazyPut<DeliveryController>(
        () => DeliveryController(Get.find<DelivaryRepository>()),
        fenix: true);
  }
}
