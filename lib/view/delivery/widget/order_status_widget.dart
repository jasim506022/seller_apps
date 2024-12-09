import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/delivary_controller.dart';
import '../../../model/order_model.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/background_shape_widget.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DeliveryController>();
    final statusData = controller.orderStatusData[orderModel.status];
    final imageAsset = statusData!["imageAsset"]!;
    final title = statusData["title"]!;
    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Image.asset(
            imageAsset,
            height: .2.sh,
            width: 1.sw,
          ),
          SizedBox(height: 15.h),
          BackgroundShapeWidget(
            backgroundColor: AppColors.deepGreen,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: AppsTextStyle.largeBoldText
                    .copyWith(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
  if (orderModel.status == "complete") {
                  Get.dialog(const ShowErrorDialogWidget(
                      title: "Order Complete",
                      message: "Order Already HandOver to User"));
                } else {
                  controller.handleOrderUpdate(orderModel.status,
                      orderModel.orderId, orderModel.orderBy);
                }
*/