import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../model/order_model.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../res/routes/routes_name.dart';
import '../../widget/app_button.dart';
import 'widget/order_user_details_stream.dart';
import 'widget/order_seller_product_section_widget.dart';

/// Displays detailed information about an order, including seller products and user profile.
class SllerOrderBreakdownPage extends StatelessWidget {
  const SllerOrderBreakdownPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    // Retrieve the OrderModel from the GetX arguments
    final OrderModel orderModel = Get.arguments;
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.orderBreakdown)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).r,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// User profile details (Customer who placed the order)
              OrderUserDetailsStream(
                  userId: orderModel.orderBy, orderId: orderModel.orderId),

              AppsFunction.verticalSpacing(10),

              /// Product details section // Uupdate This Position
              SellerOrderProductStream(
                orderModel: orderModel,
              ),
              AppsFunction.verticalSpacing(20),
              Center(
                child: AppButton(
                  width: 250,
                  onPressed: () {
                    Get.offAndToNamed(RoutesName.mainPage, arguments: 0);
                  },
                  title: AppStrings.homePage,
                ),
              ),
              AppsFunction.verticalSpacing(100),
            ],
          ),
        ),
      ),
    );
  }
}

/*
# final OrderModel orderModel = Get.arguments as OrderModel; Why use Final:
Answer:  Prevents runtime errors
# EdgeInsets.symmetric(horizontal: 15, vertical: 10).r
*/
