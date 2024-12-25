import 'package:flutter/material.dart';

class AppColors {
  // Background Colors
  static const Color backgroundLight = Color(0xfffcfcfc); //backgroundLight
  static const Color backgroundDark = Color(0xff080e1e); //backgroundDark
  static const Color backgroundHomePageLight =
      Color(0xfff2f2f8); // backgroundHomePageLight

  // Primary Colors
  static const Color green = Color(0xff00b761);
  static const Color deepGreen = Color.fromARGB(255, 0, 108, 57);
  static const Color red = Color(0xffed6767);
  static const Color blue = Colors.blue;
  static const Color yellow = Color.fromRGBO(255, 241, 112, 1);

  // Text and Hint Colors
  static const Color grey = Colors.grey;

  static const Color hintLight = Color(0xff686874); // hintLight
  static const Color hintDark = Color.fromARGB(255, 220, 220, 235); // hintDark

  // Neutral Colors
  static const Color black = Colors.black;
  static const Color white = Colors.white;

  // Accent Colors
  static const Color cardDark = Color(0xff393e4b); // cardDark
  static const Color cardImageBg = Color(0xfff6f5f1); // cardImageBg
  static const Color lightRed = Color.fromARGB(255, 251, 196, 192); // lightRed

  // Utility Colors
  static const Color indicatorLight = Colors.black54;
  static const Color indicatorDark = Colors.white54;
  static const Color brown = Colors.brown;

  // Dynamic Theme-Based Color
  static Color getBackgroundColor(bool isDarkMode) {
    return isDarkMode ? backgroundDark : backgroundLight;
  }

  static Color searchLightColor = const Color(0xfff3f3f4);

  // static Color indicatorColorDarkColor = Colors.white54;
  // static Color indicatorColorightColor = Colors.black54;

  // utilies Color
}


/*
class AppColors {
  // Background Color
  static Color backgroundLightColor = const Color(0xfffcfcfc);
  //  Color? get backgroundCutilsolor =>
  //     getTheme ? backgroundDarkColor : const Color(0xfff2f2f8);
  static Color backgroundLightHomePage = const Color(0xfff2f2f8);
  static Color backgroundDarkColor = const Color(0xff080e1e);
  // Grey Color
  static Color grey = Colors.grey;
  // Deep Green
  static Color deepGreen = const Color.fromARGB(255, 0, 108, 57);
  // Hint Light Color
  static Color hintLightColor = const Color(0xff686874);
  // Red Color
  static Color red = const Color(0xffed6767);
// Search Color
  static Color searchLightColor = const Color(0xfff3f3f4);
  // Black Color
  static Color black = Colors.black;
  // White Color
  static Color white = Colors.white;
  // Green Color
  static Color greenColor = const Color(0xff00b761);
  // Blue Color
  static Color blue = Colors.blue;

  // Yellow
  static Color yellow = const Color.fromRGBO(255, 241, 112, 1);

  // other
  static Color cardDarkColor = const Color(0xff393e4b);
  static Color cardImageBg = const Color(0xfff6f5f1);
  static Color lightred = const Color.fromARGB(255, 251, 196, 192);
  static Color indicatorColorightColor = Colors.black54;
  static Color hintDarkColor = const Color.fromARGB(255, 220, 220, 235);
  static Color indicatorColorDarkColor = Colors.white54;
  static Color brown = Colors.brown;
}

*/