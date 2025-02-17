import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_string.dart';
import 'apps_color.dart';

/// A utility class for checking network connectivity and handling no-internet scenarios.
class NetworkUtils {
  /*
  static Future<bool> verifyInternetStatus() async {
    bool checkInternet = await _isOffline();
    if (checkInternet) {
      showNoInternetSnackbar();
    }
    return checkInternet;
  }
  */

  /// Executes a function only if internet is available, otherwise shows a snackbar.
  static Future<void> executeWithInternetCheck(
      {required VoidCallback action}) async {
    if (await _isOffline()) {
      _showNoInternetSnackbar();
    } else {
      action();
    }
  }

  /// Checks if the device is offline.
  static Future<bool> _isOffline() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    return connectivityResult.contains(ConnectivityResult.none);
  }

  /// Displays a snackbar to notify the user about no internet connection.

  static void _showNoInternetSnackbar() {
    Get.snackbar(AppStrings.noInternet, AppStrings.noInternetMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.black.withOpacity(.7),
        colorText: AppColors.white,
        duration: const Duration(seconds: 1),
        margin: EdgeInsets.zero,
        borderRadius: 0);
  }
/*
  /// A utility function to verify internet status before executing an action
  static Future<void> verifyInternetAndExecute(
      Future<void> Function() action) async {
    if (!await verifyInternetStatus()) {
      await action();
    }
  }

*/
}
