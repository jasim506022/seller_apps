import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../model/order_model.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../res/routes/routes_name.dart';
import '../../widget/app_button.dart';
import 'widget/order_seller_product_section_widget.dart';
import 'widget/order_user_details_stream.dart';

/// Displays detailed information about a seller's order, including:
/// - The user profile of the customer who placed the order.
/// - A breakdown of products in the order.
/// - A button to return to the home page.

class SellerOrderBreakdownPage extends StatelessWidget {
  /// Creates an instance of `SellerOrderBreakdownPage`.
  const SellerOrderBreakdownPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    // ✅ Retrieve the OrderModel from GetX navigation arguments
    final OrderModel orderModel = Get.arguments;
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.orderBreakdownLabel)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).r,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 📌 Displays the user details (customer who placed the order)
              OrderUserDetailsStream(
                  userId: orderModel.orderBy, orderId: orderModel.orderId),

              AppsFunction.verticalSpacing(10),

              /// 📌 Displays the list of seller products in the order
              SellerOrderProductStream(orderModel: orderModel),
              AppsFunction.verticalSpacing(20),
              Center(
                child: AppButton(
                  width: 250,
                  onPressed: () =>
                      Get.offAndToNamed(RoutesName.mainPage, arguments: 0),
                  title: AppStrings.btnHomePage,
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
