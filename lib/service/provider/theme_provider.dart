import 'package:flutter/material.dart';

import '../theme_preference.dart';

class ThemeProvider with ChangeNotifier {
  ThemePreFerence themePreference = ThemePreFerence();

  bool _darkTheme = false;

  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    themePreference.setDartTheme(value: value);
    _darkTheme = value;
    notifyListeners();
  }
}
