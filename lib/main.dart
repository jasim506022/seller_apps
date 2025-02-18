import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'binding/initial_binding.dart';
import 'res/app_constants.dart';
import 'res/app_string.dart';
import 'res/apps_color.dart';
import 'res/routes/app_routes.dart';
import 'res/routes/routes_name.dart';

import 'service/provider/theme_provider.dart';

void main() async {
  // Ensure the widgets are bound to the platform and Firebase is initialized.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize SharedPreferences and retrieve the onboarding view status.
  AppConstants.sharedPreference = await SharedPreferences.getInstance();

// Check onboarding status
  AppConstants.isViewed =
      AppConstants.sharedPreference!.getInt(AppStrings.onBoardingShareKey);
  // Configure background message handling for Firebase
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Start the app
  runApp(const MyApp());
}

// Handles Firebase background messages

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
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
      // Set the design size for responsive layout
      designSize: const Size(450, 851), //582
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) {
              return ThemeProvider();
            },
          ),
        ],
        child: Consumer<ThemeProvider>(
          // Use Consumer to rebuild the app when the theme changes

          builder: (context, themeProvder, child) {
            return GetMaterialApp(
              // Set up initial bindings for dependency injection

              initialBinding: InitialBinding(),
              debugShowCheckedModeBanner: false,
              // Dynamically apply themes based on ThemeProvider

              theme: _buildAppTheme(themeProvder),
              // Set the initial route of the application

              initialRoute: RoutesName.splashPage,
              // Define all application routes

              getPages: AppRoutes.appRoutes(),
            );
          },
        ),
      ),
    );
  }

// Helper method to configure the app theme
  ThemeData _buildAppTheme(ThemeProvider themeProvider) {
    // Determine if the app is in dark theme mode
    var isDarkTheme = themeProvider.getDarkTheme;

    return ThemeData(
      // (Modify and Add comments)
      dialogTheme: DialogTheme(
          backgroundColor: isDarkTheme ? AppColors.cardDark : AppColors.white,
          titleTextStyle: GoogleFonts.poppins(
              color: isDarkTheme ? AppColors.white : AppColors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
          contentTextStyle: GoogleFonts.poppins(
              color: isDarkTheme
                  ? AppColors.white.withOpacity(.7)
                  : AppColors.black.withOpacity(.7),
              fontSize: 15.sp,
              fontWeight: FontWeight.normal)),

      cardTheme: CardTheme(
        elevation: 2,
        color: isDarkTheme ? AppColors.cardDark : AppColors.white,
      ),

      iconTheme: IconThemeData(
          color: isDarkTheme ? AppColors.white : AppColors.black, size: 25),

      // App Bar Theme (Modify)
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: isDarkTheme ? AppColors.white : AppColors.black,
        ),
        backgroundColor:
            isDarkTheme ? AppColors.backgroundDark : AppColors.backgroundLight,
        titleTextStyle: GoogleFonts.roboto(
          color: isDarkTheme ? AppColors.white : AppColors.black,
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),

      // Divider (Modify)
      dividerTheme: DividerThemeData(
        color: isDarkTheme ? AppColors.hintDark : AppColors.hintLight,
        thickness: 2,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: AppColors.green,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r))),
      ),

      // Modify
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.white,
        linearTrackColor: AppColors.red,
        circularTrackColor: AppColors.red,
        refreshBackgroundColor: AppColors.red,
      ),

      scaffoldBackgroundColor:
          isDarkTheme ? AppColors.backgroundDark : AppColors.backgroundLight,
      indicatorColor: Colors.red,
      cardColor: isDarkTheme ? AppColors.cardDark : AppColors.white,
      canvasColor:
          isDarkTheme ? AppColors.cardDark : AppColors.searchLightColor,
      unselectedWidgetColor:
          isDarkTheme ? AppColors.indicatorDark : AppColors.indicatorLight,
      hintColor: isDarkTheme ? AppColors.hintDark : AppColors.hintLight,
      primaryColor: isDarkTheme ? AppColors.white : AppColors.black,
    );
  }

  // OutlineInputBorder _buildBorder() {
  //   return OutlineInputBorder(
  //     borderSide: const BorderSide(
  //       width: 1,
  //     ),
  //     borderRadius: BorderRadius.circular(15.r),
  //   );
  // }
}
