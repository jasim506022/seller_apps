import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/cart_function.dart';
import '../../../controller/order_controller.dart';
import '../../../model/order_model.dart';
import '../../loading_widget/loading_single_product_widget.dart';
import 'seller_product_widget.dart';

class SellerOrderProductStream extends StatelessWidget {
  const SellerOrderProductStream({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    var orderController = Get.find<OrderController>();
    return StreamBuilder(
      stream: orderController.fetchSellerOrder(
          sellerList:
              CartFunctions.separateOrderSellerCartList(orderModel.seller)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingSingleProductWidget();
        }

        if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.docs.isEmpty) {
          return const Center(
              child: Text('No products available or an error occurred.'));
        }
        if (snapshot.hasData) {
          if (kDebugMode) {
            print(snapshot.data!.docs);
          }
        }

        return ListView.builder(
          shrinkWrap: true, // understand this
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var sellerName = snapshot.data!.docs[index]["name"];

            var sellerId = snapshot.data!.docs[index]["uid"];

            return SellerOrderProductWidget(
              sellerName: sellerName,
              orderModel: orderModel,
              sellerId: sellerId,
            );
          },
        );
      },
    );
  }
}
