import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/utils.dart';
import '../../../model/product_model.dart';
import '../../../res/apps_color.dart';
import 'product_image_swiper_widget.dart';
import 'product_option_menu.dart';

/// Displays the product image slider with a decorative background and action buttons.
class DetailsPageImageSlideWithCartBridgeWidget extends StatelessWidget {
  const DetailsPageImageSlideWithCartBridgeWidget({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320.h,
      width: 1.sw,
      child: Stack(
        children: [
          ..._buildBackgroundCircles(), // Background Circles
          Positioned(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppsFunction.verticalSpacing(10),
                  _buildTopBar(),
                  ProductImageSwiperWidget(
                      imageUrls: productModel.productimage!),
                  AppsFunction.verticalSpacing(10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // This method builds the background circles
  // Consolidating circle configuration into a list of maps for better readability and maintainability.
  List<Widget> _buildBackgroundCircles() {
    List<Map<String, dynamic>> circleConfig = [
      {
        'left': -300.00.w,
        'right': -300.00.w,
        'top': -350.00.h,
        'size': 650.00.h,
        'color': ThemeUtils.green100
      },
      {
        'left': -80.00.w,
        'right': -80.00.w,
        'top': -360.00.h,
        'size': 650.00.h,
        'color': ThemeUtils.green200
      },
      {
        'left': 0.00,
        'right': 0.00,
        'top': -150.00.w,
        'size': 300.00.h,
        'color': ThemeUtils.green300
      },
    ];

    return circleConfig.map((circle) {
      return Positioned(
        left: circle['left'],
        right: circle['right'],
        top: circle['top'],
        child: Container(
          height: circle['size'],
          width: circle['size'],
          decoration: BoxDecoration(
            color: circle['color'],
            shape: BoxShape.circle,
          ),
        ),
      );
    }).toList();
  }

  // This method builds the top bar with back and cart buttons
  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Tooltip(
          message: AppStrings.goBack,
          child: InkWell(
            onTap: () => Get.back(),
            child: _buildCircularButton(
              const Icon(Icons.arrow_back_ios,
                  color: AppColors.white, size: 25),
            ),
          ),
        ),
        InkWell(
            onTap: () {},
            child: _buildCircularButton(
                ProductOptionsMenu(productModel: productModel)))
      ],
    );
  }

// Creates a circular button with the given widget inside it
  Container _buildCircularButton(Widget widget) {
    return Container(
        height: 50.h,
        width: 50.h,
        decoration: const BoxDecoration(
          color: AppColors.green,
          shape: BoxShape.circle,
        ),
        child: widget);
  }
}

/*
Undersand Background
*/
