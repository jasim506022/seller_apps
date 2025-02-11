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

class OrderStatusListWidget extends StatelessWidget {
  const OrderStatusListWidget({
    super.key,
    required this.appBarTitle,
    this.selectedOrderStatus,
  });

  final String appBarTitle;
  final String? selectedOrderStatus;

  @override
  Widget build(BuildContext context) {
    // Get the CategoryManagerController for handling order status selection.
    var categoryController = Get.find<CategoryManagerController>();
    return Scaffold(
        appBar: AppBar(title: Text(appBarTitle)),
        body: Column(
          children: [
            // Show dropdown only if selectedOrderStatus is not pre-defined
            if (selectedOrderStatus == null) _buildDropdown(categoryController),
            Expanded(
                child: selectedOrderStatus != null
                    ? _buildOrderListView(selectedOrderStatus!)
                    : Obx(
                        () => _buildOrderListView(
                            categoryController.selectedStatus.value),
                      )),
          ],
        ));
  }

  /// Builds the order status dropdown when order status is not predefined.
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

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> _buildOrderListView(
      String orderStatus) {
    // Get the OrderController for fetching order data
    final orderController = Get.find<OrderController>();
    return StreamBuilder(
      stream: orderController.fatchOrders(orderStatus: orderStatus),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingListSingleProductWidget();
        }
        if (!snapshot.hasData ||
            snapshot.data!.docs.isEmpty ||
            snapshot.hasError) {
          return EmptyWidget(
            image: ImagesAsset.error,
            title: snapshot.hasError
                ? '${AppString.errorOccurred} ${snapshot.error}'
                : AppString.noDataAvaiable,
          );
        }
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // Convert Firestore document into an OrderModel instance
              final orderModel =
                  OrderModel.fromMap(snapshot.data!.docs[index].data());
              return ChangeNotifierProvider.value(
                value: orderModel,
                child: const OrderItemWidget(isCardDesign: true),
              );
            },
          );
        } else {
          return const LoadingListSingleProductWidget();
        }
      },
    );
  }
}


/*
# Why doesn't use if else in StreamBuilder

*/