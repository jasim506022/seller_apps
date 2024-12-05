import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../service/provider/theme_provider.dart';

class ThemeChangeWidget extends StatelessWidget {
  const ThemeChangeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return SwitchListTile(
          secondary: Icon(
            themeProvider.getDarkTheme ? Icons.dark_mode : Icons.light_mode,
            color: themeProvider.getDarkTheme
                ? AppColors.white
                : Theme.of(context).primaryColor,
            size: 25.h,
          ),
          title: Text(
            themeProvider.getDarkTheme ? "Dark" : "Light",
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
