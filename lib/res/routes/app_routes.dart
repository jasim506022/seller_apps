import 'package:get/get.dart';
import 'package:seller_apps/res/routes/routes_name.dart';
import 'package:seller_apps/view/auth/forget_password_page.dart';
import 'package:seller_apps/view/auth/sign_in_page.dart';
import 'package:seller_apps/view/splash/splashpage.dart';

import '../../view/auth/sign_up_page.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RoutesName.initailRoutes,
          page: () => const SplashPage(),
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
      ];
}
