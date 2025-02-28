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

/// A widget that displays delivery-related details, including:
/// - Delivery address
/// - Estimated delivery date
/// - Delivery partner details
class DeliveryInfoCard extends StatelessWidget {
  /// Constructor to initialize the delivery info card.

  const DeliveryInfoCard({super.key, required this.orderModel});

  /// Order details for which delivery information is displayed.
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDeliveryAddressWidget(),
        AppsFunction.verticalSpacing(10),
        _buildEstimatedDeliveryWidget(),
        _buildDeliveryPartnerWidget(),
      ],
    );
  }

  /// Builds the delivery address section with real-time data from Firestore.
  ///
  /// Uses `StreamBuilder` to listen to updates on the delivery address.
  /// - Displays a loading indicator while fetching data.
  /// - Shows an error message if the data retrieval fails.
  BackgroundShapeWidget _buildDeliveryAddressWidget() {
    var orderController = Get.find<OrderController>();
    return BackgroundShapeWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// Label for the delivery address
          Text("${AppStrings.deliveryAddressLabel}: ",
              style: AppsTextStyle.mediumBoldText),
          AppsFunction.horizontalSpacing(15),
          StreamBuilder(
              stream: orderController.fetchUserDeliveryAddress(
                  orderModel: orderModel),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                /// If there is an error or no data available, display an error message

                if (snapshots.hasError ||
                    !snapshots.hasData ||
                    snapshots.data?.data() == null) {
                  return Text(
                    AppStrings.noDataAvaiableError,
                    style: AppsTextStyle.mediumBoldText,
                  );
                }

                /// Parse address details from Firestore data

                final AddressModel addressModel =
                    AddressModel.fromMap(snapshots.data!.data()!);
                return Expanded(
                  child: Text(
                    addressModel.completeaddress ??
                        AppStrings.noDataAvaiableError,
                    style: AppsTextStyle.mediumNormalText,
                  ),
                );
              }),
        ],
      ),
    );
  }

  /// Builds the estimated delivery date section.
  ///
  /// - If the order is **completed**, displays a "Completed" label.
  /// - Otherwise, formats and displays the estimated delivery date.
  BackgroundShapeWidget _buildEstimatedDeliveryWidget() {
    return BackgroundShapeWidget(
        backgroundColor: AppColors.deepGreen,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Label for estimated delivery date
            Text("${AppStrings.estimatedDeliveryLabel}: ",
                style: AppsTextStyle.mediumBoldText
                    .copyWith(color: AppColors.white)),
            AppsFunction.horizontalSpacing(10),
            Expanded(
              /// Displays either the completed status or the formatted delivery date
              child: Text(
                orderModel.status == AppStrings.completeStatus
                    ? AppStrings.completeOrderLabel
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
  ///
  /// - Shows the assigned delivery partner's name.
  /// - Displays the tracking number for shipment tracking.
  BackgroundShapeWidget _buildDeliveryPartnerWidget() {
    return BackgroundShapeWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Displays delivery partner name
          DeliveryRichTextWidget(
            title: "${AppStrings.deliveryPartnerLabel}: ",
            description: orderModel.deliveryPartner,
            color: AppColors.green,
          ),
          AppsFunction.verticalSpacing(15),

          /// Displays tracking number
          DeliveryRichTextWidget(
              title: "${AppStrings.trackingNumberLabel} :",
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