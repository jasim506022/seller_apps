import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../controller/order_controller.dart';
import '../../../model/order_model.dart';
import '../../../res/app_asset/image_asset.dart';
import '../../../widget/empty_widget.dart';
import '../../loading_widget/loading_list_single_product_widget.dart';
import 'order_item_widget.dart';

class OrderStatusListWidget extends StatelessWidget {
  const OrderStatusListWidget({
    super.key,
    required this.appBarTitle,
    required this.orderStatus,
  });

  final String appBarTitle;
  final String orderStatus;

  @override
  Widget build(BuildContext context) {
    var orderController = Get.find<OrderController>();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            appBarTitle,
          ),
        ),
        body: StreamBuilder(
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
                    ? 'Error Occurred: ${snapshot.error}'
                    : 'No Data Available',
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
        ));
  }
}
