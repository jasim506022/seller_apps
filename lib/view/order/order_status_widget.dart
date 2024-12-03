import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seller_apps/model/order_model.dart';
import 'package:seller_apps/res/apps_color.dart';
import 'package:seller_apps/res/apps_text_style.dart';
import 'package:seller_apps/widget/background_shape_widget.dart';

import '../../controller/delivary_controller.dart';
import '../../widget/show_error_dialog_widget.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    super.key,
    required this.orderModel,

    // required this.onTap,
    // required this.orderStatus,
  });

  // final String imageAsset;
  // final String title;
  // final Function onTap;
  // final String orderStatus;
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
          InkWell(
              onTap: () {
                if (orderModel.status == "complete") {
                  // _showOrderCompleteDialog();
                  Get.dialog(const ShowErrorDialogWidget(
                      title: "Order Complete",
                      message: "Order Already HandOver to User"));
                } else {
                  controller.handleOrderUpdate(orderModel.status,
                      orderModel.orderId, orderModel.orderBy);
                  // _handleOrderUpdate(orderStatus);
                }
              },
              child: BackgroundShapeWidget(
                backgroundColor: AppColors.deepGreen,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: AppsTextStyle.largeBoldText
                        .copyWith(color: AppColors.white),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
