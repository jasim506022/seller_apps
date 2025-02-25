import 'package:flutter/material.dart';

import '../../model/order_model.dart';

import '../../res/app_function.dart';
import '../../res/app_string.dart';
import 'widget/delivery_infor_card.dart';
import 'widget/order_user_details_stream.dart';
import 'widget/order_status_card.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'widget/order_summary_widget.dart';

/// A detailed page displaying complete order information, including user details, delivery info, and order status.
class OrderOverviewPage extends StatelessWidget {
  const OrderOverviewPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure Get.arguments is of type OrderModel to prevent runtime errors
    OrderModel order = Get.arguments;
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.orderOverviewTitle)),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderUserDetailsStream(
                    userId: order.orderBy, orderId: order.orderId),
                AppsFunction.verticalSpacing(10),
                DeliveryInfoCard(orderModel: order),
                AppsFunction.verticalSpacing(10),
                OrderStatusCard(orderStatus: order.status),
                AppsFunction.verticalSpacing(15),
                ChangeNotifierProvider.value(
                  value: order,
                  child: const OrderSummaryWidget(),
                )
              ],
            ),
          )),
    );
  }
}
