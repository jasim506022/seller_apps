import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/res/routes/app_routes.dart';

import 'package:seller_apps/service/provider/imageaddremoveprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'binding/initial_binding.dart';
import 'res/routes/routes_name.dart';
import 'const/const.dart';
import 'const/global.dart';
import 'const/gobalcolor.dart';

import 'service/provider/dropvalueselectallprovider.dart';

import 'service/provider/loadingprovider.dart';
import 'service/provider/searchprovider.dart';
import 'service/provider/theme_provider.dart';
import 'service/provider/totalamountprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreference = await SharedPreferences.getInstance();
  FirebaseMessaging.onBackgroundMessage(firebaseMessingbackground);
  isviewed = sharedPreference!.getInt('onBoarding');
  runApp(const MyApp());
}

Future<void> firebaseMessingbackground(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message ${message.data}");
    print("Handling a background message ${message.notification!.title}");
    print("Handling a background message ${message.notification!.body}");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(450, 851), //582
      builder: (context, child) => MultiProvider(
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
              return LoadingProvider();
            },
          ),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvder, child) {
            return GetMaterialApp(
              initialBinding: InitialBinding(),
              debugShowCheckedModeBanner: false,
              theme: themeData(themeProvder),
              initialRoute: RoutesName.initailRoutes,
              getPages: AppRoutes.appRoutes(),
            );
          },
        ),
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
