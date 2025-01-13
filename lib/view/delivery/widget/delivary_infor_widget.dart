import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/res/app_string.dart';

import '../../../model/order_model.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_color.dart';
import '../../../widget/background_shape_widget.dart';
import 'delivery_rich_text_widget.dart';

class DeliveryInfoWidget extends StatelessWidget {
  const DeliveryInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final orderModel = Provider.of<OrderModel>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BackgroundShapeWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DeliveryRichTextWidget(
                title: "${AppString.deliveryPartner}: ",
                description: orderModel.deliveryPartner,
                color: AppColors.green,
              ),
              AppsFunction.verticalSpace(15),
              DeliveryRichTextWidget(
                  title: "${AppString.trackingNumber} :",
                  color: AppColors.red,
                  description: orderModel.trackingNumber)
            ],
          ),
        ),
        AppsFunction.verticalSpace(15),
      ],
    );
  }
}
