import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'apps_color.dart';

class AppsTextStyle {
  static BuildContext get context => Get.context!;

  static ThemeData get theme => Theme.of(context);

  // Large  Title Text Style
  static TextStyle get largeTitleTextStyle => GoogleFonts.roboto(
      color: theme.primaryColor, fontSize: 22.sp, fontWeight: FontWeight.w900);

  // Title Text Style
  static TextStyle get titleTextStyle => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 18.sp, fontWeight: FontWeight.w700);

// Large Normal Text
  static TextStyle get largeNormalText => GoogleFonts.poppins(
        fontSize: 16.sp,
        color: theme.primaryColor,
        fontWeight: FontWeight.w400,
      );
  // Large Normal Text
  static TextStyle get largeBoldText => GoogleFonts.poppins(
        fontSize: 16.sp,
        color: theme.primaryColor,
        fontWeight: FontWeight.w800,
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
      color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 15.sp);

// Hint Normal Text
  static TextStyle get hintTextStyle => GoogleFonts.poppins(
        fontSize: 14.sp,
        color: AppColors.grey,
        fontWeight: FontWeight.normal,
      );

// Medium Text
  static TextStyle get mediumBoldText => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 14.sp, fontWeight: FontWeight.w800);


// others 
static TextStyle mediumText400lineThrough = GoogleFonts.roboto(
      decoration: TextDecoration.lineThrough,
      color: const Color(0xffcecfd2),
      fontSize: 14.sp,
      fontWeight: FontWeight.w700);

      // Small Bold Text
  static TextStyle get smallBoldText => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w700);


}
