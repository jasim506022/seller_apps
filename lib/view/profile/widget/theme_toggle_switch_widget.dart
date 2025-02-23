import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../res/app_string.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../service/provider/theme_provider.dart';

/// A switch widget that allows users to toggle between **Light Mode** and **Dark Mode**.
class ThemeToggleSwitchWidget extends StatelessWidget {
  const ThemeToggleSwitchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final bool isDarkMode = themeProvider.getDarkTheme;
        return SwitchListTile(
          /// **Theme Icon (Light/Dark Mode)**
          /// - Displays a sun or moon icon based on the current theme.

          secondary: Icon(
            isDarkMode ? Icons.dark_mode : Icons.light_mode,
            color: Theme.of(context).primaryColor,
          ),

          /// **Theme Label (Dark Mode / Light Mode)**
          /// - Updates dynamically based on the selected theme.

          title: Text(
            isDarkMode ? AppStrings.darkLabel : AppStrings.lightLabel,
            style: AppsTextStyle.largeBold,
          ),

          /// **Switch Properties**
          /// - Controls the toggle behavior.
          activeColor: AppColors.white,
          onChanged: (bool value) => themeProvider.setDarkTheme = value,
          value: themeProvider.getDarkTheme,
        );
      },
    );
  }
}


/*
#: Why we use Final   final bool isDarkMode = themeProvider.isDarkMod;
*/