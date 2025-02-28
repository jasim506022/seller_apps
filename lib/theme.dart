import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../res/apps_color.dart';
import '../service/provider/theme_provider.dart';

ThemeData buildAppTheme(ThemeProvider themeProvider) {
  final isDark = themeProvider.getDarkTheme;

  return ThemeData(
    dialogTheme: _dialogTheme(isDark),
    cardTheme: _cardTheme(isDark),
    iconTheme: _iconTheme(isDark),
    appBarTheme: _appBarTheme(isDark),
    dividerTheme: _dividerTheme(isDark),
    elevatedButtonTheme: _buttonTheme(),
    progressIndicatorTheme: _progressIndicatorTheme(),
    scaffoldBackgroundColor:
        isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
    cardColor: isDark ? AppColors.cardDark : AppColors.white,
    canvasColor: isDark ? AppColors.cardDark : AppColors.searchLightColor,
    unselectedWidgetColor:
        isDark ? AppColors.indicatorDark : AppColors.indicatorLight,
    hintColor: isDark ? AppColors.hintDark : AppColors.hintLight,
    primaryColor: isDark ? AppColors.white : AppColors.black,
  );
}

// Extracted Dialog Theme
DialogTheme _dialogTheme(bool isDark) => DialogTheme(
      backgroundColor: isDark ? AppColors.cardDark : AppColors.white,
      titleTextStyle: GoogleFonts.poppins(
        color: isDark ? AppColors.white : AppColors.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: GoogleFonts.poppins(
        color: isDark
            ? AppColors.white.withOpacity(.7)
            : AppColors.black.withOpacity(.7),
        fontSize: 15.sp,
        fontWeight: FontWeight.normal,
      ),
    );

// Extracted Card Theme
CardTheme _cardTheme(bool isDark) => CardTheme(
      elevation: 2,
      color: isDark ? AppColors.cardDark : AppColors.white,
    );

// Extracted Icon Theme
IconThemeData _iconTheme(bool isDark) => IconThemeData(
      color: isDark ? AppColors.white : AppColors.black,
      size: 25.h,
    );

// Extracted AppBar Theme
AppBarTheme _appBarTheme(bool isDark) => AppBarTheme(
      iconTheme: IconThemeData(
        color: isDark ? AppColors.white : AppColors.black,
      ),
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      titleTextStyle: GoogleFonts.roboto(
        color: isDark ? AppColors.white : AppColors.black,
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
    );

// Extracted Divider Theme
DividerThemeData _dividerTheme(bool isDark) => DividerThemeData(
      color: isDark ? AppColors.hintDark : AppColors.hintLight,
      thickness: 2,
    );

// Extracted Button Theme
ElevatedButtonThemeData _buttonTheme() => ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: AppColors.green,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      ),
    );

// Extracted Progress Indicator Theme
ProgressIndicatorThemeData _progressIndicatorTheme() =>
    const ProgressIndicatorThemeData(
      color: AppColors.white,
      linearTrackColor: AppColors.red,
      circularTrackColor: AppColors.red,
      refreshBackgroundColor: AppColors.red,
    );
