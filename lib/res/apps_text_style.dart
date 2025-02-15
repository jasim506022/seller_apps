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

// Apps Logo
  static TextStyle get appsLogoTextStyole => GoogleFonts.roboto(
        color: AppColors.green,
        fontSize: 24.sp,
        fontWeight: FontWeight.w900,
      );

  // Large  Title Text Style
  static TextStyle get largeTitleTextStyleForOnBoarding => GoogleFonts.roboto(
      color: theme.primaryColor, fontSize: 30.sp, fontWeight: FontWeight.w900);

  static TextStyle get titleSignPageTextStyle => GoogleFonts.roboto(
      color: theme.primaryColor,
      fontSize: 28.sp,
      fontWeight: FontWeight.w900,
      height: 1.3,
      letterSpacing: 1.2);
// Modify Text
  static TextStyle get labelTextStyle => GoogleFonts.poppins(
        color: theme.primaryColor,
        fontSize: 16.sp,
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

// dialog title

  // static TextStyle get titleDialogTextStyle => GoogleFonts.poppins(
  //     color: theme.primaryColor, fontSize: 20.sp, fontWeight: FontWeight.bold);

  // static TextStyle get contentDialogTextStyle => GoogleFonts.poppins(
  //     color: AppColors.black.withOpacity(.7),
  //     fontSize: 16.sp,
  //     fontWeight: FontWeight.normal);

  static TextStyle get titleHomeProfileheader => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 22.sp, fontWeight: FontWeight.w800);

  static TextStyle get gridViewTextStyle => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 18.sp, fontWeight: FontWeight.w800);

// Description
  static TextStyle get descrptionTextStyle => GoogleFonts.roboto(
      color: AppColors.black.withOpacity(.7),
      fontSize: 16.sp,
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

  // Search text Field Input Text
  static TextStyle textFieldInputTextStyle([bool isEnable = false]) =>
      GoogleFonts.poppins(
        fontSize: 14.sp,
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
      color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 16.sp);

// Hint Normal Text
  static TextStyle get hintTextStyle => GoogleFonts.poppins(
        fontSize: 14.sp,
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
