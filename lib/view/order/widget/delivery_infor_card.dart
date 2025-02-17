import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/order_controller.dart';
import '../../../model/address_model.dart';
import '../../../model/order_model.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/background_shape_widget.dart';
import 'delivery_rich_text_widget.dart';

/// A widget that displays delivery-related information, including the estimated delivery date and delivery address.
class DeliveryInfoCard extends StatelessWidget {
  const DeliveryInfoCard({super.key, required this.orderModel});

  /// Order details for which delivery information is displayed.
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDeliveryAddressSection(),
        AppsFunction.verticalSpace(10),
        _buildEstimatedDeliverySection(),
        _buildDeliveryPartnerDetails(),
      ],
    );
  }

  /// Builds the section displaying the delivery address.
  BackgroundShapeWidget _buildDeliveryAddressSection() {
    var orderController = Get.find<OrderController>();
    return BackgroundShapeWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("${AppStrings.deliveryAddress}: ",
              style: AppsTextStyle.mediumBoldText),
          AppsFunction.horizontalSpace(15),
          Expanded(
            child: StreamBuilder(
                stream: orderController.fetchUserDeliveryAddress(
                    orderModel: orderModel),
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  // Handle errors or empty data cases
                  if (snapshots.hasError ||
                      !snapshots.hasData ||
                      snapshots.data?.data() == null) {
                    return Text(
                      AppStrings.noDataAvaiable,
                      style: AppsTextStyle.mediumBoldText,
                    );
                  }
                  // Parse address model from Firestore data
                  final AddressModel addressModel =
                      AddressModel.fromMap(snapshots.data!.data()!);
                  return Text(
                    addressModel.completeaddress!,
                    style: AppsTextStyle.mediumNormalText,
                  );
                }),
          ),
        ],
      ),
    );
  }

  /// Builds the section displaying the estimated delivery date.
  BackgroundShapeWidget _buildEstimatedDeliverySection() {
    return BackgroundShapeWidget(
        backgroundColor: AppColors.deepGreen,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${AppStrings.estimatedDelivery}: ",
                style: AppsTextStyle.mediumBoldText
                    .copyWith(color: AppColors.white)),
            AppsFunction.horizontalSpace(10),
            Expanded(
              child: Text(
                orderModel.status == AppStrings.complete
                    ? AppStrings.completeOrder
                    : AppsFunction.formatDate(
                        timestamp: orderModel.deliveryDate, includeTime: false),
                style: AppsTextStyle.mediumBoldText
                    .copyWith(color: AppColors.yellow),
              ),
            ),
          ],
        ));
  }

  /// Builds the section displaying the delivery partner and tracking number.
  BackgroundShapeWidget _buildDeliveryPartnerDetails() {
    return BackgroundShapeWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DeliveryRichTextWidget(
            title: "${AppStrings.deliveryPartner}: ",
            description: orderModel.deliveryPartner,
            color: AppColors.green,
          ),
          AppsFunction.verticalSpace(15),
          DeliveryRichTextWidget(
              title: "${AppStrings.trackingNumber} :",
              color: AppColors.red,
              description: orderModel.trackingNumber)
        ],
      ),
    );
  }
}


/*
Why use static
why use const
and why use final
*/