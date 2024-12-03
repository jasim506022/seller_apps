import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/delivary_controller.dart';
import '../../model/address_model.dart';
import '../../model/order_model.dart';
import '../../res/app_function.dart';
import '../../res/apps_color.dart';
import '../../res/apps_text_style.dart';
import '../../widget/background_shape_widget.dart';

class OrderDeliveryLocationWidget extends StatelessWidget {
  const OrderDeliveryLocationWidget({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    var delivaryController = Get.find<DeliveryController>();
    return Column(
      children: [
        BackgroundShapeWidget(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Delivery Address: ",
                style: AppsTextStyle.mediumBoldText,
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: delivaryController.userDeliveryAddressSnapshot(
                        orderModel: orderModel),
                    builder: (context, addressSnashot) {
                      if (addressSnashot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (addressSnashot.hasData) {
                        AddressModel addressModel =
                            AddressModel.fromMap(addressSnashot.data!.data()!);
                        return Text(
                          addressModel.completeaddress!,
                          style: AppsTextStyle.mediumNormalText,
                        );
                      }
                      return Text(
                        "Address Not Found",
                        style: AppsTextStyle.mediumBoldText,
                      );
                    }),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        BackgroundShapeWidget(
            backgroundColor: AppColors.deepGreen,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Estimated Delivery Date is: ",
                    style: AppsTextStyle.mediumBoldText
                        .copyWith(color: AppColors.white)),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Text(
                    orderModel.status == "complete"
                        ? "Order Compete"
                        : AppsFunction.getFormateDate(
                            datetime: orderModel.deliveryDate),
                    style: AppsTextStyle.mediumBoldText
                        .copyWith(color: AppColors.yellow),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
