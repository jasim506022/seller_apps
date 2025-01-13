import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/res/app_string.dart';

import '../../../controller/category_controller.dart';
import '../../../controller/order_controller.dart';
import '../../../model/order_model.dart';
import '../../../res/app_asset/image_asset.dart';
import '../../../res/app_constants.dart';
import '../../../widget/drop_down_category_widget.dart';
import '../../../widget/empty_widget.dart';
import '../../loading_widget/loading_list_single_product_widget.dart';
import 'order_item_widget.dart';

class OrderStatusListWidget extends StatelessWidget {
  const OrderStatusListWidget({
    super.key,
    required this.appBarTitle,
    this.orderStatus,
  });

  final String appBarTitle;
  final String? orderStatus;

  @override
  Widget build(BuildContext context) {
    var orderController = Get.find<OrderController>();
    var categoryController = Get.find<CategoryManagerController>();
    return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
        ),
        body: Column(
          children: [
            if (orderStatus == null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.h),
                child: DropdownWidget(
                  items: AppConstants.orderStatuses,
                  value: categoryController.selectedStatus.value,
                  onChanged: (value) {
                    // categoryController.updateStatus(value!);
                    if (value != null) {
                      categoryController.updateStatus(value);
                    }
                  },
                ),
              ),
            // if (orderStatus == null)
            //   Expanded(
            //     child: Obx(
            //       () => _buildOrderList(
            //           orderController, categoryController.selectedStatus.value),
            //     ),
            //   ),
            // if (orderStatus != null)
            Expanded(
                child: _buildOrderList(orderController,
                    orderStatus ?? categoryController.selectedStatus.value)),
          ],
        ));
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> _buildOrderList(
      OrderController orderController, String orderStatus) {
    return StreamBuilder(
      stream: orderController.orderSnapshots(orderStatus: orderStatus),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingListSingleProductWidget();
        } else if (!snapshot.hasData ||
            snapshot.data!.docs.isEmpty ||
            snapshot.hasError) {
          return EmptyWidget(
            image: ImagesAsset.error,
            title: snapshot.hasError
                ? '${AppString.errorOccurred} ${snapshot.error}'
                : AppString.noDataAvaiable,
          );
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
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
