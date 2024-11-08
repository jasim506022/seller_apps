import 'package:get/get.dart';
import 'package:seller_apps/res/routes/routes_name.dart';
import 'package:seller_apps/view/auth/forgetpasswordscreen.dart';
import 'package:seller_apps/view/auth/sign_in_page.dart';
import 'package:seller_apps/view/splash/splashpage.dart';

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
      ];
}
