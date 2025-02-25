import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../model/order_model.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/routes/routes_name.dart';
import 'order_item_widget.dart';

/// A widget that displays a summary of an order, including the order ID
/// and a breakdown link to navigate to detailed order information.

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Retrieve the current order instance from the Provider.

    final order = Provider.of<OrderModel>(context, listen: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Displays the order ID.
            Text("${AppStrings.order} ${order.orderId}",
                style: AppsTextStyle.mediumBoldText),

            /// Navigates to the order details page when tapped.
            InkWell(
              onTap: () =>
                  Get.toNamed(RoutesName.orderDetailsPage, arguments: order),
              child: Text("${AppStrings.orderBreakdownLabel} >",
                  style: AppsTextStyle.mediumBoldText
                      .copyWith(color: AppColors.red)),
            ),
          ],
        ),
        AppsFunction.verticalSpacing(15),
        // Product list inside the order
        Flexible(
          child: ChangeNotifierProvider.value(
            value: order,
            child: const OrderItemWidget(),
          ),
        ),
      ],
    );
  }
}


/*
final orderModel = Provider.of<OrderModel>(context, listen: false);
#: Prevents UI Overflows (TextOverflow.ellipsis, Expanded in Row)
*/