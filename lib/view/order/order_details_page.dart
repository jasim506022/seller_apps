import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seller_apps/res/app_string.dart';

import '../../model/order_model.dart';
import '../../res/app_function.dart';
import '../../res/routes/routes_name.dart';
import '../../widget/custom_round_action_button_widget.dart';
import '../delivery/widget/delivery_user_profile_stream.dart';
import 'widget/order_seller_product_section_widget.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    // Retrieve the OrderModel from the GetX arguments
    OrderModel orderModel = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.orderDetails),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User profile details
              DeliveryUserProfileStream(
                  userId: orderModel.orderBy, orderId: orderModel.orderId),
              // Product details section
              OrderSellerProductListWidget(
                orderModel: orderModel,
              ),
              AppsFunction.verticalSpace(10),
              Align(
                alignment: Alignment.center,
                child: CustomRoundActionButtonWidget(
                  onTap: () {
                    Get.offAndToNamed(RoutesName.mainPage, arguments: 0);
                  },
                  title: AppString.homePage,
                ),
              ),
              AppsFunction.verticalSpace(100),
            ],
          ),
        ),
      ),
    );
  }
}
