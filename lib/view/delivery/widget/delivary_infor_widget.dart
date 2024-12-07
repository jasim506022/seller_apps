import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../model/order_model.dart';
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
                title: "Delivery Partner:",
                subTitle: orderModel.deliveryPartner,
                color: AppColors.deepGreen,
              ),
              SizedBox(
                height: 15.h,
              ),
              DeliveryRichTextWidget(
                  title: "Tracking Number :",
                  color: AppColors.red,
                  subTitle: orderModel.trackingNumber)
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
