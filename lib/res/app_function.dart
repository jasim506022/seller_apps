import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'utils.dart';
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
    return Get.dialog(ShowAlertDialogWidget(
      icon: Icons.question_mark_rounded,
      title: AppString.exit,
      content: AppString.exitApps,
      onYesPressed: () {
        Get.back(result: true);
      },
      onNoPressed: () {
        Get.back(result: false);
      },
    ));
  }

  // VerticalSpace
  static SizedBox verticalSpace(double height) => SizedBox(height: height.h);

  // VerticalSpace
  static SizedBox horizontalSpace(double width) => SizedBox(width: width.w);

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
      hintStyle: TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration textFormFielddecoration(
      {bool isShowPassword = false,
      required String hintText,
      bool obscureText = false,
      bool isEnable = true,
      required Function function}) {
    return InputDecoration(
        fillColor:
            isEnable ? AppColors.searchLightColor : ThemeUtils.textFieldColor,
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
                  color: obscureText ? AppColors.hintLight : AppColors.red,
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

/*
  static double calculateDiscountedPrice(num productprice, double discount) {
    return productprice - (productprice * discount / 100);
  }

//Product Price
  static double productPrice(num productprice, double discount) {
    return calculateDiscountedPrice(productprice, discount);
  }

  //Product Price
  static double productPriceWithQuantity(
      num productprice, double discount, int quantity) {
    return calculateDiscountedPrice(productprice, discount) * quantity;
  }

*/
  /// Calculates the discounted price of a product based on its original price and discount percentage.
  static double calculateDiscountedPrice(num productPrice, double discount) {
    return productPrice - (productPrice * discount / 100);
  }

  /// Returns the discounted price of a product.
  static double getDiscountedPrice(num productPrice, double discount) {
    return calculateDiscountedPrice(productPrice, discount);
  }

  /// Returns the total price for a given quantity of a product, including discount.
  static double calculateTotalPriceWithQuantity(
      num productPrice, double discount, int quantity) {
    return calculateDiscountedPrice(productPrice, discount) * quantity;
  }

  static Container lineShimmer(double height, [double? width]) {
    return Container(
      height: height,
      width: width ?? 1.sw,
      decoration: BoxDecoration(
          color: ThemeUtils.shimmerWidgetColor,
          borderRadius: BorderRadius.circular(15.r)),
    );
  }

  static String formatDate(String orderTime) {
    return DateFormat('hh:mm a, MMM d, yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(orderTime)));
  }

  static Container circleShimmer(double height) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
          color: ThemeUtils.shimmerWidgetColor, shape: BoxShape.circle),
    );
  }

  static String getFormateDate({required String datetime}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(datetime));
    return DateFormat("MMM d, yyyy").format(date);
  }
}
