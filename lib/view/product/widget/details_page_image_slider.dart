import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../const/utils.dart';
import '../../../model/productsmodel.dart';
import '../../../res/apps_color.dart';
import 'image_swiper_widget.dart';
import 'popup_button_widget.dart';

class DetailsPageImageSlideWithCartBridgeWidget extends StatelessWidget {
  const DetailsPageImageSlideWithCartBridgeWidget({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return SizedBox(
      height: 320.h,
      width: 1.sw,
      child: Stack(
        children: [
          for (Map<String, dynamic> circleConfig in [
            {
              'left': -300.00.w,
              'right': -300.00.w,
              'top': -350.00.h,
              'size': 650.00.h,
              'color': utils.green100
            },
            {
              'left': -80.00.w,
              'right': -80.00.w,
              'top': -360.00.h,
              'size': 650.00.h,
              'color': utils.green200
            },
            {
              'left': 0.00,
              'right': 0.00,
              'top': -150.00.w,
              'size': 300.00.h,
              'color': utils.green300
            },
          ])
            Positioned(
              left: circleConfig['left'],
              right: circleConfig['right'],
              top: circleConfig['top'],
              child: Container(
                height: circleConfig['size'],
                width: circleConfig['size'],
                decoration: BoxDecoration(
                  color: circleConfig['color'],
                  shape: BoxShape.circle,
                ),
              ),
            ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: _buildCircularButton(
                          Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.white,
                            size: 25,
                          ),
                        ),
                      ),
                      InkWell(
                          onTap: () async {},
                          child: _buildCircularButton(
                              PopupButtonWidget(productModel: productModel)))
                    ],
                  ),
                  DetailsImageSwiperWidget(productModel: productModel),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildCircularButton(Widget widget) {
    return Container(
        height: 50.h,
        width: 50.h,
        decoration:
            BoxDecoration(color: AppColors.greenColor, shape: BoxShape.circle),
        child: widget);
  }
}
