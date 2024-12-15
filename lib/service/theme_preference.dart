import '../res/app_constants.dart';

class ThemePreFerence {
  static const themeStatue = "THEME_STATUS";

  setDartTheme({required bool value}) async {
    AppConstants.sharedPreference!.setBool(themeStatue, value);
  }

  bool getTheme() {
    return AppConstants.sharedPreference!.getBool(themeStatue) ?? false;
  }
}
