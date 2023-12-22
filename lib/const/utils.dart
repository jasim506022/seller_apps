import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/provider/theme_provider.dart';
import 'gobalcolor.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  bool get getTheme => Provider.of<ThemeProvider>(context).getDarkTheme;
  Color get getColor => getTheme ? Colors.white : Colors.black;

  Color get baseShimmerColor =>
      getTheme ? Colors.grey.shade500 : Colors.grey.shade200;
  Color get highlightShimmerColor =>
      getTheme ? Colors.grey.shade700 : Colors.grey.shade400;
  Color get widgetShimmerColor =>
      getTheme ? Colors.grey.shade600 : Colors.grey.shade100;

  Color get green300 =>
      getTheme ? Colors.green.shade800 : Colors.green.shade300;
  Color get green100 =>
      getTheme ? Colors.green.shade600 : Colors.green.shade100;

  Color get green200 =>
      getTheme ? Colors.green.shade700 : Colors.green.shade200;

  Color? get green50 => getTheme ? cardDarkColor : Colors.green[50];

  Color? get profileTextColor => getTheme ? Colors.white54 : Colors.black54;

  Color? get bottomTotalBill =>
      getTheme ? cardDarkColor : greenColor.withOpacity(.1);

  Color? get categoryUnselectBackground =>
      getTheme ? cardDarkColor : const Color.fromARGB(255, 238, 236, 236);

  Color? get categoryUnSelectTextColor =>
      getTheme ? white.withOpacity(.7) : black;

  Color? get categorySelectBackground => getTheme ? greenColor : black;
  Color? get backgroun =>
      getTheme ? backgroundDarkColor : const Color(0xfff2f2f8);
}
