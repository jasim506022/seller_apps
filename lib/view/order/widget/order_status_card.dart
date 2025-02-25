import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/order_controller.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/background_shape_widget.dart';

/// Displays the order status with an image and title inside a styled container.
///
/// This widget retrieves the corresponding status image and title from
/// `OrderController` and presents them in a visually appealing format.
class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({
    super.key,
    required this.orderStatus,
  });

  /// The order whose status needs to be displayed.
  final String orderStatus;

  @override
  Widget build(BuildContext context) {
    // Retrieve the OrderController instance using GetX dependency injection.
    final orderController = Get.find<OrderController>();
    // Fetch the relevant status data (image and title) based on `orderStatus`.
    final statusData = orderController.getStatusData(orderStatus);
    final imageAsset = statusData!["imageAsset"];
    final statusTitle = statusData["title"];

    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          /// Displays the status image.
          Image.asset(
            imageAsset!,
            height: 180.h,
            width: 1.sw,
            fit: BoxFit.contain,
          ),
          AppsFunction.verticalSpacing(15),

          /// Displays the status title inside a styled container.
          BackgroundShapeWidget(
            backgroundColor: AppColors.deepGreen,
            child: Text(
              statusTitle!,
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
