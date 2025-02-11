import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../res/app_string.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../service/provider/theme_provider.dart';

/// A switch widget to toggle between light and dark mode.
class ThemeSwitchWidget extends StatelessWidget {
  const ThemeSwitchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final bool isDarkMode = themeProvider.getDarkTheme;
        return SwitchListTile(
          secondary: Icon(
            themeProvider.getDarkTheme ? Icons.dark_mode : Icons.light_mode,
            color:
                isDarkMode ? AppColors.white : Theme.of(context).primaryColor,
            size: 25.h,
          ),
          title: Text(
            isDarkMode ? AppString.dark : AppString.light,
            style: AppsTextStyle.mediumBoldText,
          ),
          activeColor: AppColors.white,
          onChanged: (bool value) {
            themeProvider.setDarkTheme = value;
          },
          value: themeProvider.getDarkTheme,
        );
      },
    );
  }
}


/*
#: Why we use Final   final bool isDarkMode = themeProvider.isDarkMod;
*/