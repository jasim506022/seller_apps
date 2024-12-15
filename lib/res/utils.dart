import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../service/provider/theme_provider.dart';
import 'apps_color.dart';

class Utils {
  static BuildContext get context => Get.context!;
  static bool get getTheme => Provider.of<ThemeProvider>(context).getDarkTheme;
  static Color get getColor => getTheme ? Colors.white : Colors.black;

  static Color get textFeildColor => getTheme
      ? AppColors.white.withOpacity(.9)
      : AppColors.black.withOpacity(.1);

  static Color get baseShimmerColor =>
      getTheme ? Colors.grey.shade500 : Colors.grey.shade200;
  static Color get highlightShimmerColor =>
      getTheme ? Colors.grey.shade700 : Colors.grey.shade400;
  static Color get widgetShimmerColor =>
      getTheme ? Colors.grey.shade600 : Colors.grey.shade100;

  static Color get green300 =>
      getTheme ? Colors.green.shade800 : Colors.green.shade300;
  static Color get green100 =>
      getTheme ? Colors.green.shade600 : Colors.green.shade100;

  static Color get green200 =>
      getTheme ? Colors.green.shade700 : Colors.green.shade200;

  static Color? get green50 =>
      getTheme ? AppColors.cardDarkColor : Colors.green[50];

  static Color? get profileTextColor =>
      getTheme ? Colors.white54 : Colors.black54;

  static Color? get bottomTotalBill =>
      getTheme ? AppColors.cardDarkColor : AppColors.greenColor.withOpacity(.1);

  static Color? get categoryUnselectBackground => getTheme
      ? AppColors.cardDarkColor
      : const Color.fromARGB(255, 238, 236, 236);

  static Color? get categoryUnSelectTextColor =>
      getTheme ? AppColors.white.withOpacity(.7) : AppColors.black;

  static Color? get categorySelectBackground =>
      getTheme ? AppColors.greenColor : AppColors.black;

  static Color? get backgroundCutilsolor =>
      getTheme ? AppColors.backgroundDarkColor : const Color(0xfff2f2f8);
}
