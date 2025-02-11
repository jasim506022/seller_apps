import 'package:flutter/material.dart';

import '../../model/order_model.dart';

import '../../res/app_function.dart';
import '../../res/app_string.dart';
import 'widget/delivary_infor_widget.dart';
import 'widget/delivery_user_profile_stream.dart';
import 'widget/delivery_order_locationn_widget.dart';
import 'widget/order_status_widget.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'widget/order_product_details.dart';

class OrderDeliveryPage extends StatelessWidget {
  const OrderDeliveryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    OrderModel orderModel = Get.arguments;
    return Scaffold(
      appBar: AppBar(title: Text(AppString.orderDelivery)),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DeliveryUserProfileStream(
                    userId: orderModel.orderBy, orderId: orderModel.orderId),
                AppsFunction.verticalSpace(10),
                OrderDeliveryLocationWidget(
                  orderModel: orderModel,
                ),
                AppsFunction.verticalSpace(10),
                ChangeNotifierProvider.value(
                  value: orderModel,
                  child: const DeliveryInfoWidget(),
                ),
                AppsFunction.verticalSpace(10),
                OrderStatusWidget(
                  orderModel: orderModel,
                ),
                AppsFunction.verticalSpace(15),
                ChangeNotifierProvider.value(
                  value: orderModel,
                  child: const OrderProductDetails(),
                )
              ],
            ),
          )),
    );
  }
}
