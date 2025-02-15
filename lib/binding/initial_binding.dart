import 'package:get/get.dart';
import 'package:seller_apps/controller/add_product_controller.dart';
import 'package:seller_apps/controller/auth_controller.dart';
import 'package:seller_apps/controller/category_manager_controller.dart';
import 'package:seller_apps/repository/add_product_repository.dart';
import 'package:seller_apps/repository/auth_reposity.dart';

import '../controller/loading_controller.dart';
import '../controller/onboarding_controller.dart';
import '../controller/order_controller.dart';
import '../controller/product_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/search_controller.dart';
import '../controller/select_image_controller.dart';

import '../controller/splash_controller.dart';
import '../repository/order_repository.dart';
import '../repository/product_repository.dart';
import '../repository/profile_repository.dart';
import '../repository/select_image_repository.dart';
import '../repository/splash_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashRepository>(() => SplashRepository());

    Get.lazyPut<SplashController>(
        () => SplashController(repository: Get.find<SplashRepository>()));

    Get.lazyPut<OnboardingController>(() => OnboardingController());

    // Get.lazyPut<SignInRepository>(() => SignInRepository(), fenix: true);

    // Get.lazyPut<SignInController>(
    //     () => SignInController(repository: Get.find<SignInRepository>()),
    //     fenix: true);

    Get.lazyPut<AuthRepository>(() => AuthRepository(), fenix: true);

    Get.lazyPut<AuthController>(
        () => AuthController(repository: Get.find<AuthRepository>()),
        fenix: true);

    Get.lazyPut<AddProductRepository>(() => AddProductRepository(),
        fenix: true);

    Get.lazyPut<AddProductController>(
        () =>
            AddProductController(repository: Get.find<AddProductRepository>()),
        fenix: true);

    Get.put<LoadingController>(LoadingController(), permanent: true);

    Get.lazyPut<SelectImageRepository>(() => SelectImageRepository(),
        fenix: true);

    Get.lazyPut<SelectImageController>(
        () => SelectImageController(
            repository: Get.find<SelectImageRepository>()),
        fenix: true);

    // Get.put<SignUpController>(
    //     SignUpController(repository: Get.find<SignUpRepository>()));

    // Get.lazyPut<ForgetPasswordRepository>(() => ForgetPasswordRepository());

    // Get.put<ForgetPasswordController>(ForgetPasswordController(
    //     repository: Get.find<ForgetPasswordRepository>()));

    Get.lazyPut<ProfileRepository>(() => ProfileRepository(), fenix: true);

    Get.lazyPut<ProfileController>(
        () => ProfileController(repository: Get.find<ProfileRepository>()),
        fenix: true);

    Get.lazyPut<CategoryManagerController>(() => CategoryManagerController(),
        fenix: true);
    Get.lazyPut<ProductSearchController>(() => ProductSearchController());

    Get.lazyPut<ProductRepository>(() => ProductRepository(), fenix: true);
    Get.lazyPut<ProductController>(
        () => ProductController(repository: Get.find<ProductRepository>()),
        fenix: true);
    Get.lazyPut<OrderRepository>(() => OrderRepository(), fenix: true);
    Get.lazyPut<OrderController>(
        () => OrderController(Get.find<OrderRepository>()),
        fenix: true);

    
  }
}
