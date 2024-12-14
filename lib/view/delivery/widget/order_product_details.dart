import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/res/routes/app_routes.dart';
import 'package:seller_apps/res/routes/routes_name.dart';

import '../../../model/order_model.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../order/order_details_page.dart';
import '../../order/widget/order_item_widget.dart';

class OrderProductDetails extends StatelessWidget {
  const OrderProductDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final orderModel = Provider.of<OrderModel>(context, listen: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order ${orderModel.orderId}",
              style: AppsTextStyle.largeBoldText,
            ),
            InkWell(
              onTap: () {
                Get.toNamed(RoutesName.orderDetailsPage, arguments: orderModel);
              },
              child: Text(
                "Order Details >",
                style:
                    AppsTextStyle.mediumBoldText.copyWith(color: AppColors.red),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        Flexible(
          child: ChangeNotifierProvider.value(
            value: orderModel,
            child: const OrderItemWidget(),
          ),
        ),
      ],
    );
  }
}
