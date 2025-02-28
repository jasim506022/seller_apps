import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'binding/initial_binding.dart';
import 'res/routes/app_routes.dart';
import 'res/routes/routes_name.dart';
import 'service/provider/theme_provider.dart';
import 'theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          const Size(450, 851), // Set the design size for responsive layout
      builder: (context, child) => MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return GetMaterialApp(
              initialBinding: InitialBinding(),
              debugShowCheckedModeBanner: false,
              theme: buildAppTheme(themeProvider),
              initialRoute: RoutesName.splashPage,
              getPages: AppRoutes.appRoutes(),
            );
          },
        ),
      ),
    );
  }
}

/*
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

      // Okay (Final)
      iconTheme: IconThemeData(
          color: isDarkTheme ? AppColors.white : AppColors.black, size: 25.h),
      // Okay (final)

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
}
*/