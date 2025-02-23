import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seller_apps/controller/order_controller.dart';

import '../../../model/order_model.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/background_shape_widget.dart';

/// Displays the order status with an image and title inside a styled container.
class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({
    super.key,
    required this.orderModel,
  });

  /// The order whose status needs to be displayed.
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderController>();

    final statusData = controller.orderStatusData[orderModel.status];

    // Handle cases where statusData is null
    if (statusData == null) {
      return Center(
        child: Text(
          "Status not available",
          style: AppsTextStyle.mediumBoldText.copyWith(color: AppColors.red),
        ),
      );
    }
    final String statusImagePath = statusData["imageAsset"] ?? "";
    final String statusTitle = statusData["title"] ?? "Unknown Status";

    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Image.asset(
            statusImagePath,
            height: .2.sh,
            width: 1.sw,
            fit: BoxFit.contain,
          ),
          AppsFunction.verticalSpacing(15),
          BackgroundShapeWidget(
            backgroundColor: AppColors.deepGreen,
            child: Text(
              statusTitle,
              textAlign: TextAlign.center,
              style:
                  AppsTextStyle.mediumBoldText.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}

/*
#: Null Safety
boxFit.cover
*/
