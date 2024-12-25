import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'apps_color.dart';

class NetworkUtili {
  static Future<bool> verifyInternetStatus() async {
    bool checkInternet = await internetChecking();
    if (checkInternet) {
      showNoInternetSnackbar();
    }
    return checkInternet;
  }

  static Future<bool> internetChecking() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    return connectivityResult.contains(ConnectivityResult.none);
  }

  static SnackbarController showNoInternetSnackbar() {
    return Get.snackbar(
        'No Internet', 'Please check your internet settings and try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.black.withOpacity(.7),
        colorText: AppColors.white,
        duration: const Duration(seconds: 1),
        margin: EdgeInsets.zero,
        borderRadius: 0);
  }

  /// A utility function to verify internet status before executing an action
  static Future<void> verifyInternetAndExecute(
      Future<void> Function() action) async {
    if (!await verifyInternetStatus()) {
      await action();
    }
  }
}
