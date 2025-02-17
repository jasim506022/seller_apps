import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../service/provider/theme_provider.dart';
import 'apps_color.dart';

class ThemeUtils {
  static BuildContext get _context => Get.context!;
  static bool get isDarkTheme =>
      Provider.of<ThemeProvider>(_context).getDarkTheme;

  // General Colors
  static Color get baseTextColor => isDarkTheme ? Colors.white : Colors.black;

  static Color get textFieldColor => isDarkTheme
      ? AppColors.white.withOpacity(0.9)
      : AppColors.black.withOpacity(0.1);

  // Shimmer Effect Colors

  static Color get shimmerBaseColor =>
      isDarkTheme ? Colors.grey.shade500 : Colors.grey.shade200;
  // highlightShimmerColor  // shimmerHighlightColor
  static Color get shimmerHighlightColor =>
      isDarkTheme ? Colors.grey.shade700 : Colors.grey.shade400;

  static Color get shimmerWidgetColor =>
      isDarkTheme ? Colors.grey.shade600 : Colors.grey.shade100;

  // Green Shades
  static Color get green300 =>
      isDarkTheme ? Colors.green.shade800 : Colors.green.shade300;
  static Color get green200 =>
      isDarkTheme ? Colors.green.shade700 : Colors.green.shade200;
  static Color get green100 =>
      isDarkTheme ? Colors.green.shade600 : Colors.green.shade100;
  static Color? get green50 =>
      isDarkTheme ? AppColors.cardDark : Colors.green[50];

  // Profile and Text Colors
  static Color get profileTextColor =>
      isDarkTheme ? Colors.white54 : Colors.black54;

  // Bill and Category Colors
  static Color get bottomBillColor =>
      isDarkTheme ? AppColors.cardDark : AppColors.green.withOpacity(0.1);
  static Color get categoryUnselectedBackground =>
      isDarkTheme ? AppColors.cardDark : const Color(0xFFEEECEC);
  static Color get categoryUnselectedTextColor =>
      isDarkTheme ? AppColors.white.withOpacity(0.7) : AppColors.black;
  static Color get categorySelectedBackground =>
      isDarkTheme ? AppColors.green : AppColors.black;

  // Background Color
  static Color get backgroundColor =>
      isDarkTheme ? AppColors.backgroundDark : const Color(0xFFF2F2F8);
}
