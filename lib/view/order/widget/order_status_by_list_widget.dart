import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../controller/category_manager_controller.dart';
import '../../../controller/order_controller.dart';
import '../../../model/order_model.dart';
import '../../../res/app_asset/image_asset.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_string.dart';
import '../../../widget/custom_drop_down_widget.dart';
import '../../../widget/empty_widget.dart';
import '../../loading_widget/loading_list_single_product_widget.dart';
import 'order_item_widget.dart';

/// Widget to display a list of orders filtered by their status.
/// It supports a dropdown for selecting different order statuses
/// unless a predefined status is passed via `selectedOrderStatus`.
class OrderListByStatusWidget extends StatelessWidget {
  const OrderListByStatusWidget({
    super.key,
    required this.appBarTitle,
    this.selectedOrderStatus,
  });

  final String appBarTitle;

  /// The selected order status. If `null`, a dropdown is shown
  /// for users to select a status dynamically.
  final String? selectedOrderStatus;

  @override
  Widget build(BuildContext context) {
    // Retrieve the controllers using GetX dependency injection.
    final CategoryManagerController categoryController =
        Get.find<CategoryManagerController>();
    final OrderController orderController = Get.find<OrderController>();

    return Scaffold(
        appBar: AppBar(title: Text(appBarTitle)),
        body: Column(
          children: [
            // Show dropdown only if selectedOrderStatus is not pre-defined
            if (selectedOrderStatus == null) _buildDropdown(categoryController),
            // Display the order list dynamically based on selected status.
            Expanded(
                child: selectedOrderStatus != null
                    ? _buildOrderListView(selectedOrderStatus!, orderController)
                    : Obx(
                        () => _buildOrderListView(
                            categoryController.selectedStatus.value,
                            orderController),
                      )),
          ],
        ));
  }

  /// Builds a dropdown to allow users to select an order status dynamically.
  ///
  /// Only displayed if `selectedOrderStatus` is `null`.
  Padding _buildDropdown(CategoryManagerController categoryController) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      child: CustomDropdownWidget(
        items: AppConstants.orderStatuses,
        value: categoryController.selectedStatus.value,
        onChanged: (value) {
          if (value != null) {
            categoryController.updateStatus(value);
          }
        },
      ),
    );
  }

  /// Builds a list of orders based on the selected `orderStatus`.
  ///
  /// - If `orderStatus` is empty, a message prompts users to select a status.
  /// - Fetches order data using the `OrderController`.
  /// - Uses `StreamBuilder` to listen for real-time updates.

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> _buildOrderListView(
      String orderStatus, OrderController orderController) {
    return StreamBuilder(
      stream: orderController.fetchOrders(orderStatus: orderStatus),
      builder: (context, snapshot) {
        // Show a loading indicator while data is being fetched.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingListSingleProductWidget();
        }
        // Handle errors during data fetching and No Data Available
        if (!snapshot.hasData ||
            snapshot.data!.docs.isEmpty ||
            snapshot.hasError) {
          return EmptyWidget(
            image: AppImage.error,
            title: snapshot.hasError
                ? '${AppStrings.errorOccurred} ${snapshot.error}'
                : AppStrings.noDataAvaiableError,
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            // Convert Firestore document into an OrderModel instance
            final orderModel =
                OrderModel.fromMap(snapshot.data!.docs[index].data());

            return ChangeNotifierProvider.value(
              value: orderModel,
              child: const OrderItemWidget(useCardDesign: true),
            );
          },
        );
      },
    );
  }
}

/*
# Why doesn't use if else in StreamBuilder
#: // Use predefined order status or from controller
    final String currentOrderStatus =
        selectedOrderStatus ?? categoryController.selectedStatus.value; check when complete is Data

*/
