import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/page/auth/forgetpasswordscreen.dart';
import 'package:seller_apps/page/auth/signupscreen.dart';
import 'package:seller_apps/page/order/completeorderpage.dart';
import 'package:seller_apps/service/provider/imageaddremoveprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'page/auth/signinpage.dart';
import 'const/approutes.dart';
import 'const/const.dart';
import 'const/global.dart';
import 'const/gobalcolor.dart';
import 'page/main/mainpage.dart';
import 'page/order/orderpage.dart';
import 'page/splash/onboardingpage.dart';
import 'page/splash/splashpage.dart';

import 'service/provider/dropvalueselectallprovider.dart';
import 'service/provider/editprofileprovider.dart';
import 'service/provider/loadingprovider.dart';
import 'service/provider/searchprovider.dart';
import 'service/provider/theme_provider.dart';
import 'service/provider/totalamountprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreference = await SharedPreferences.getInstance();
  isviewed = sharedPreference!.getInt('onBoarding');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return CateoryDropValueProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return SearchProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return ImageAddRemoveProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return ThemeProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return TotalAmountProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return EditPageProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return LoadingProvider();
          },
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvder, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeData(themeProvder),
            initialRoute: AppRouters.initailRoutes,
            routes: {
              AppRouters.initailRoutes: (context) => const SplashPage(),
              AppRouters.signPage: (context) => const SigninPage(),
              AppRouters.mainPage: (context) => const MainPage(),
              AppRouters.onBaordingPage: (context) => const OnboardingPage(),
              AppRouters.signupPage: (context) => const SignUpScreen(),
              AppRouters.forgetPassword: (context) =>
                  const ForgetPasswordScreen(),
              AppRouters.completeOrderPage: (context) =>
                  const CompleteOrderPage(),
              AppRouters.orderPage: (context) => const OrderPage(),
            },
          );
        },
      ),
    );
  }

  ThemeData themeData(ThemeProvider themeProvder) {
    return ThemeData(
        iconTheme:
            IconThemeData(color: themeProvder.getDarkTheme ? white : black),
        appBarTheme: AppBarTheme(
          iconTheme:
              IconThemeData(color: themeProvder.getDarkTheme ? white : black),
          backgroundColor: themeProvder.getDarkTheme
              ? backgroundDarkColor
              : backgroundLightColor,
          titleTextStyle: GoogleFonts.roboto(
              color: themeProvder.getDarkTheme ? white : black,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          centerTitle: true,
        ),
        // Scaffold Background Color
        scaffoldBackgroundColor: themeProvder.getDarkTheme
            ? backgroundDarkColor
            : backgroundLightColor,
        //Card Color
        cardColor: themeProvder.getDarkTheme ? cardDarkColor : white,
        //CanvasColor
        canvasColor:
            themeProvder.getDarkTheme ? cardDarkColor : searchLightColor,
        // Indicator Color
        indicatorColor: themeProvder.getDarkTheme
            ? indicatorColorDarkColor
            : indicatorColorightColor,

        // Hint Color
        hintColor: themeProvder.getDarkTheme ? hintDarkColor : hintLightColor,
        //brightness
        // brightness:
        //     themeProvder.getDarkTheme ? Brightness.light : Brightness.dark,
        // Primary
        primaryColor: themeProvder.getDarkTheme ? white : black);
  }
}
