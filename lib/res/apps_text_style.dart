import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'apps_color.dart';

class AppsTextStyle {
  static BuildContext get context => Get.context!;

  static ThemeData get theme => Theme.of(context);

  // Title Text Style (Modify)
  static TextStyle get titleTextStyle => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 20.sp, fontWeight: FontWeight.w800);

  // Title Text Style (Modify)
  static TextStyle get dialogTitleText => GoogleFonts.poppins(
      color: AppColors.green, fontSize: 18.sp, fontWeight: FontWeight.w800);

// Apps Logo
// Apps Logo (Modify)
  static TextStyle get appsLogoTextStyle => GoogleFonts.pacifico(
        color: AppColors.deepGreen,
        fontSize: 24.sp,
        letterSpacing: 1.2,
        fontWeight: FontWeight.w900,
      );

  // Large  Title Text Style (modify)
  static TextStyle get largeTitle => GoogleFonts.roboto(
      color: theme.primaryColor, fontSize: 28.sp, fontWeight: FontWeight.w900);

// MOdify
  static TextStyle get authIntroTitleTextStyle => GoogleFonts.roboto(
      color: theme.primaryColor,
      fontSize: 28.sp,
      fontWeight: FontWeight.w900,
      height: 1.3,
      letterSpacing: 1.2);
// Modify Text
  static TextStyle get labelTextStyle => GoogleFonts.poppins(
        color: theme.primaryColor,
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
      );

  // Large Normal Text (modify)
  static TextStyle get largeCustomBoldText => GoogleFonts.poppins(
        fontSize: 16.sp,
        color: theme.primaryColor,
        fontWeight: FontWeight.w800,
      );

// (modify)
  static TextStyle mediumTextCustom400lineThrough = GoogleFonts.roboto(
      decoration: TextDecoration.lineThrough,
      color: const Color(0xffcecfd2),
      fontSize: 15.sp,
      fontWeight: FontWeight.w700);

// (Modify)
  static TextStyle get titleHomeProfileheader => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 20.sp, fontWeight: FontWeight.w800);

  static TextStyle get gridViewTextStyle => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 17.sp, fontWeight: FontWeight.w800);

// Description (Modify)
  static TextStyle get authIntroDescriptionTextStyle => GoogleFonts.roboto(
      color: AppColors.black.withOpacity(.8),
      fontSize: 17.sp,
      fontWeight: FontWeight.normal,
      height: 1.6,
      letterSpacing: 1.2);

// Large Normal Text
  static TextStyle get largeNormalText => GoogleFonts.poppins(
        fontSize: 16.sp,
        color: theme.primaryColor,
        fontWeight: FontWeight.w400,
      );
  // Large Normal Text (Modify) (Heading Title)
  static TextStyle get largeBoldText => GoogleFonts.poppins(
        fontSize: 15.sp,
        color: theme.primaryColor,
        fontWeight: FontWeight.w800,
      );

  // Large body Normal Text (Modify)
  static TextStyle get mediumNormalText => GoogleFonts.poppins(
        fontSize: 15.sp,
        color: theme.primaryColor,
        fontWeight: FontWeight.w400,
      );

  // Search text Field Input Text (modify)
  static TextStyle textFieldInputTextStyle([bool isEnable = false]) =>
      GoogleFonts.poppins(
        fontSize: 15.sp,
        color: isEnable ? AppColors.black : AppColors.black.withOpacity(.8),
        fontWeight: isEnable ? FontWeight.w600 : FontWeight.w800,
      );

  // Sub Title TextStyle
  static TextStyle get subTitleTextStyle => GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 15.sp,
        color: theme.hintColor,
      );

  // Button Text Style
  static TextStyle get buttonTextStyle => GoogleFonts.poppins(
      color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 15.sp);

// Hint Normal Text (modify)
  static TextStyle get hintTextStyle => GoogleFonts.poppins(
        fontSize: 15.sp,
        color: AppColors.grey,
        fontWeight: FontWeight.normal,
      );

// Medium Text (Modify)
  static TextStyle get mediumBoldText => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 15.sp, fontWeight: FontWeight.w700);

// others
  static TextStyle mediumText400lineThrough = GoogleFonts.roboto(
      decoration: TextDecoration.lineThrough,
      color: const Color(0xffcecfd2),
      fontSize: 14.sp,
      fontWeight: FontWeight.w700);

  // Small Bold Text (Modify)
  static TextStyle get smallBoldText => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 11.sp, fontWeight: FontWeight.w700);

//
  static TextStyle get rattingText => GoogleFonts.poppins(
        color: Theme.of(context).hintColor,
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
      );

// Modify
  static TextStyle emptyTestStyle = GoogleFonts.roboto(
      color: AppColors.red, fontSize: 22.sp, fontWeight: FontWeight.bold);
}
