import 'package:get/get.dart';
import 'package:seller_apps/view/completeorder/totalsellerpage.dart';
import 'package:seller_apps/view/add_product/add_product_page.dart';
import 'package:seller_apps/view/main/main_page.dart';
import 'package:seller_apps/view/order/completeorderpage.dart';
import 'package:seller_apps/view/order/orderpage.dart';
import 'package:seller_apps/view/product/productpage.dart';

import '../../view/auth/forget_password_page.dart';
import '../../view/auth/sign_in_page.dart';
import '../../view/auth/sign_up_page.dart';
import '../../view/splash/onboardingpage.dart';
import '../../view/splash/splashpage.dart';
import 'routes_name.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RoutesName.initailRoutes,
          page: () => const SplashPage(),
        ),
        GetPage(
          name: RoutesName.onBaordingPage,
          page: () => const OnboardingPage(),
        ),
        GetPage(
          name: RoutesName.signPage,
          page: () => const SigninPage(),
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
          name: RoutesName.uploadProduct,
          page: () =>  AddProductPage(),
        ),
         GetPage(
          name: RoutesName.product,
          page: () =>  const ProductPage(),
        ),
        GetPage(
          name: RoutesName.totalSales,
          page: () =>  const TotalSellPage(),
        ),
        GetPage(
          name: RoutesName.runningOrder,
          page: () =>  const OrderPage(),
        ),
        GetPage(
          name: RoutesName.completeOrderPage,
          page: () =>  const CompleteOrderPage(),
        ),
      ];
}
