import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';

import '../const/utils.dart';
import '../data/response/app_data_exception.dart';

import '../widget/show_alert_dialog_widget.dart';
import 'apps_color.dart';
import 'apps_text_style.dart';
import 'app_string.dart';

class AppsFunction {
  // IsValidEmail
  static bool isValidEmail(String email) {
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)*[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

// Show Back Dialog
  static Future<bool?> showBackDialog() {
    return Get.dialog(CustomAlertDialogWidget(
      icon: Icons.question_mark_rounded,
      title: AppString.exit,
      content: AppString.exitApps,
      yesOnPress: () {
        Get.back(result: true);
      },
      noOnPress: () {
        Get.back(result: false);
      },
    ));
  }

  static Future<bool> verifyInternetStatus() async {
    bool checkInternet = await AppsFunction.internetChecking();
    if (checkInternet) {
      AppsFunction.showNoInternetSnackbar();
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

  static flutterToast({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: 16.0);
  }

  static InputDecoration inputDecoration({
    required String hint,
  }) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff00B761), width: 1),
          borderRadius: BorderRadius.circular(15)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff00B761), width: 1),
          borderRadius: BorderRadius.circular(15)),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration textFormFielddecoration(
      {bool isShowPassword = false,
      required String hintText,
      bool obscureText = false,
      bool isEnable = true,
      required Function function}) {
    Utils utils = Utils(Get.context!);
    return InputDecoration(
        fillColor: isEnable ? AppColors.searchLightColor : utils.textFeildColor,
        filled: true,
        hintText: hintText,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.r)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.r)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.r)),
        suffixIcon: isShowPassword
            ? IconButton(
                onPressed: () {
                  function();
                },
                icon: Icon(
                  Icons.password,
                  color: obscureText ? AppColors.hintLightColor : AppColors.red,
                ))
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        hintStyle: AppsTextStyle.hintTextStyle);
  }

  static void handleException(Object e) {
    if (e is FirebaseAuthException) {
      throw FirebaseAuthExceptions(e);
    } else if (e is FirebaseException) {
      throw FirebaseExceptions(e);
    } else if (e is SocketException) {
      throw InternetException(e.toString());
    } else if (e is PlatformException) {
      throw PlatformExceptions(e);
    } else if (e is FileSystemException) {
      throw FileSystemExceptions(e.toString());
    } else if (e is OutOfMemoryError) {
      throw OutOfMemoryErrors(e.toString());
    } else if (e is TimeoutException) {
      throw TimeOutExceptions(e.message.toString());
    } else {
      throw OthersException(e.toString());
    }
  }

  static double calculateDiscountedPrice(num productprice, double discount) {
    return productprice - (productprice * discount / 100);
  }

//Product Price
  static double productPrice(num productprice, double discount) {
    return calculateDiscountedPrice(productprice, discount);
  }

  static Container lineShimmer(Utils utils, double height, [double? width]) {
    return Container(
      height: height,
      width: width ?? 1.sw,
      decoration: BoxDecoration(
          color: utils.widgetShimmerColor,
          borderRadius: BorderRadius.circular(15.r)),
    );
  }

  //Product Price
  static double productPriceWithQuantity(
      num productprice, double discount, int quantity) {
    return calculateDiscountedPrice(productprice, discount) * quantity;
  }

  static String formatDate(String orderTime) {
    return DateFormat('hh:mm a, MMM d, yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(orderTime)));
  }

  static Container circleShimmer(Utils utils, double height) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
          color: utils.widgetShimmerColor, shape: BoxShape.circle),
    );
  }

  static String getFormateDate({required String datetime}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(datetime));
    return DateFormat("MMM d, yyyy").format(date);
  }
}
