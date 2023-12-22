import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/service/provider/totalamountprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'const/global.dart';
import 'const/gobalcolor.dart';
import 'page/splash/mysplashscreen.dart';
import 'service/provider/addupdateproductprovider.dart';
import 'service/provider/dropvalueselectallprovider.dart';
import 'service/provider/editprofileprovider.dart';
import 'service/provider/searchprovider.dart';
import 'service/provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreference = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
            return AddUpdadateProductProvider();
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
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvder, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeData(themeProvder),
              home: const MySplashScreen());
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
        brightness:
            themeProvder.getDarkTheme ? Brightness.light : Brightness.dark,
        // Primary
        primaryColor: themeProvder.getDarkTheme ? white : black);
  }
}
