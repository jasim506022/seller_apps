import 'package:get/get.dart';
import 'package:seller_apps/view/completeorder/totalsellerpage.dart';
import 'package:seller_apps/view/add_product/add_product_page.dart';
import 'package:seller_apps/view/main/main_page.dart';
import 'package:seller_apps/view/order/history_page.dart';
import 'package:seller_apps/view/delivery/delivery_page.dart';
import 'package:seller_apps/view/order/order_details_page.dart';
import 'package:seller_apps/view/order/order_page.dart';
import 'package:seller_apps/view/product/product_details_page.dart';
import 'package:seller_apps/view/product/product_page.dart';
import 'package:seller_apps/view/profile/edit_profile_page.dart';

import '../../view/auth/forget_password_page.dart';
import '../../view/auth/sign_in_page.dart';
import '../../view/auth/sign_up_page.dart';
import '../../view/splash/onboarding_screen.dart';
import '../../view/splash/splash_screen.dart';
import 'routes_name.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RoutesName.splashPage,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: RoutesName.onBardingPpage,
          page: () => const OnboardingScreen(),
        ),
        GetPage(
          name: RoutesName.signPage,
          page: () => const SignInPage(),
        ),
        GetPage(
          name: RoutesName.forgetPassword,
          page: () => const ForgetPasswordScreen(),
        ),
        GetPage(
          name: RoutesName.signupPage,
          page: () => const SignUpPage(),
        ),
        GetPage(
          name: RoutesName.mainPage,
          page: () => const MainPage(),
        ),
        GetPage(
          name: RoutesName.uploadAndUpdateProduct,
          page: () => const ManageProductPage(),
        ),
        GetPage(
          name: RoutesName.productDetails,
          page: () => const ProductDetailsPage(),
        ),
        GetPage(
          name: RoutesName.product,
          page: () => const ProductPage(),
        ),
        GetPage(
          name: RoutesName.totalSales,
          page: () => const TotalSellPage(),
        ),
        GetPage(
          name: RoutesName.orderPage,
          page: () => const OrderScreen(),
        ),
        GetPage(
          name: RoutesName.completeOrderPage,
          page: () => const CompleteOrderPage(),
        ),
        GetPage(
          name: RoutesName.delivaryPage,
          page: () => const OrderDeliveryPage(),
        ),
        GetPage(
          name: RoutesName.editProfilePage,
          page: () => const EditProfilePage(),
        ),
        GetPage(
          name: RoutesName.orderDetailsPage,
          page: () => const OrderDetailsPage(),
        ),
      ];
}
