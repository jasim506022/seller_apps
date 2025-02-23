import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'apps_color.dart';

class AppsTextStyle {
  static BuildContext get context => Get.context!;

  static ThemeData get theme => Theme.of(context);

  // Title Styles
  static TextStyle get titleText => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 19.sp, fontWeight: FontWeight.w800);

  static TextStyle get dialogTitle => GoogleFonts.poppins(
      color: AppColors.green, fontSize: 18.sp, fontWeight: FontWeight.w800);

  static TextStyle get logoText => GoogleFonts.pacifico(
      color: AppColors.deepGreen,
      fontSize: 24.sp,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w900);
  static TextStyle get homeProfileTitle => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 20.sp, fontWeight: FontWeight.w800);

  static TextStyle get largeTitle => GoogleFonts.roboto(
      color: theme.primaryColor, fontSize: 28.sp, fontWeight: FontWeight.w900);

  static TextStyle get authTitle => GoogleFonts.roboto(
      color: theme.primaryColor,
      fontSize: 28.sp,
      fontWeight: FontWeight.w900,
      height: 1.3,
      letterSpacing: 1.2);

  static TextStyle get authDescription => GoogleFonts.roboto(
      color: AppColors.black.withOpacity(.8),
      fontSize: 17.sp,
      fontWeight: FontWeight.normal,
      height: 1.6,
      letterSpacing: 1.2);

  // Labels & Buttons
  static TextStyle get label => GoogleFonts.poppins(
        color: theme.primaryColor,
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get button => GoogleFonts.poppins(
      color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 15.sp);

  // General Text Styles
  static TextStyle get mediumBoldText => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 15.sp, fontWeight: FontWeight.w700);

  static TextStyle get mediumNormalText => GoogleFonts.poppins(
        fontSize: 15.sp,
        color: theme.primaryColor,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get smallBoldText => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 11.sp, fontWeight: FontWeight.w700);

  static TextStyle get largeBold => GoogleFonts.poppins(
        fontSize: 17.sp,
        color: theme.primaryColor,
        fontWeight: FontWeight.w800,
      );

  static TextStyle get gridTitleText => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 17.sp, fontWeight: FontWeight.w800);

// Large Normal Text
  static TextStyle get largeNormalText => GoogleFonts.poppins(
        fontSize: 16.sp,
        color: theme.primaryColor,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get subTitleTextStyle => GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 15.sp,
        color: theme.hintColor,
      );

  // Input Fields & Hints
  static TextStyle get hintText => GoogleFonts.poppins(
        fontSize: 15.sp,
        color: AppColors.grey,
        fontWeight: FontWeight.normal,
      );

  static TextStyle inputText([bool isEnable = false]) => GoogleFonts.poppins(
        fontSize: 15.sp,
        color: isEnable ? AppColors.black : AppColors.black.withOpacity(.8),
        fontWeight: isEnable ? FontWeight.w600 : FontWeight.w800,
      );

  // Special Styles
  static TextStyle emptyTextStyle = GoogleFonts.roboto(
      color: AppColors.red, fontSize: 22.sp, fontWeight: FontWeight.bold);

  static TextStyle get ratingText => GoogleFonts.poppins(
        color: Theme.of(context).hintColor,
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
      );

  static TextStyle lineThroughText = GoogleFonts.roboto(
      decoration: TextDecoration.lineThrough,
      color: const Color(0xffcecfd2),
      fontSize: 15.sp,
      fontWeight: FontWeight.w700);
}
