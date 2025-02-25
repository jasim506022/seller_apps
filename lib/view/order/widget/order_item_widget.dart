import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../const/cart_function.dart';
import '../../../controller/order_controller.dart';
import '../../../model/order_model.dart';
import '../../../model/product_model.dart';
import '../../../res/app_asset/image_asset.dart';
import '../../../res/app_string.dart';
import '../../../res/routes/routes_name.dart';
import '../../../widget/dot_line_printer.dart';
import '../../../widget/empty_widget.dart';
import '../../loading_widget/loading_single_product_widget.dart';
import 'order_product_widget.dart';

/// A widget that displays an individual order item, either in a list format
/// or in a card-style design, based on the `useCardDesign` flag.
class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({
    super.key,
    this.useCardDesign = false,
    this.sellerId,
  });

  /// The seller's ID. If provided, orders will be fetched specifically for this seller.
  final String? sellerId;
  final bool useCardDesign;

  @override
  Widget build(BuildContext context) {
    // Get the OrderController using GetX
    final OrderController orderController = Get.find<OrderController>();
    // Retrieve the order model using Provider. Listen is set to false to prevent unnecessary rebuilds.
    final orderModel = Provider.of<OrderModel>(context, listen: false);
    // Extract product quantities from the order model.
    List<int> productQuantities =
        CartFunctions.separateOrderItemQuantities(orderModel.productIds);

    return FutureBuilder(
      // Fetch order data from Firestore (either seller-specific or general).
      future: _fetchOrderData(orderController, orderModel),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingSingleProductWidget();
        }
        // Handle errors or empty data cases.
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

        return InkWell(
          onTap: () {
            // Navigate to the delivery page if `useCardDesign` is enabled.
            if (useCardDesign) {
              Get.toNamed(RoutesName.delivaryPage, arguments: orderModel);
            }
          },
          // Display the UI as either a card or a list.
          child: useCardDesign
              ? _buildCardView(context, snapshot, productQuantities)
              : _buildListView(snapshot, productQuantities),
        );
      },
    );
  }

  /// Fetches order product data from Firestore.
  ///
  /// - If `sellerId` is `null`, fetches all order products.
  /// - If `sellerId` is provided, fetches only products associated with the seller.
  Future<QuerySnapshot<Map<String, dynamic>>> _fetchOrderData(
      OrderController orderController, OrderModel orderModel) {
    if (sellerId == null) {
      return orderController.fetchOrderProducts(orderModel: orderModel);
    } else {
      return orderController.fetchSellerProducts(
        productList:
            CartFunctions.separateOrderProductIds(orderModel.productIds),
        sellerId: sellerId!,
      );
    }
  }

  /// Builds a card-style UI when `useCardDesign` is `true`.
  ///
  /// - Wraps the list of order products inside a `Card` widget.
  /// - Uses a `Container` to style the card with padding and height.
  Widget _buildCardView(
      BuildContext context, AsyncSnapshot snapshot, List<int> quantities) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      child: Container(
        padding: EdgeInsets.all(5.r),
        margin: EdgeInsets.all(5.r),
        height: snapshot.data!.docs.length * 120.h,
        child: _buildListView(snapshot, quantities),
      ),
    );
  }

  /// Builds a list of order products.
  ///
  /// - Uses a `ListView` to display products.
  /// - Includes a custom dotted line separator between items.
  Widget _buildListView(AsyncSnapshot snapshot, List<int> quantities) {
    return ListView.separated(
      separatorBuilder: (context, index) => CustomPaint(
        painter: DottedLinePainter(),
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        // Converting Firestore document data into a ProductModel instance
        ProductModel productModel =
            ProductModel.fromMap(snapshot.data!.docs[index].data());
        return ChangeNotifierProvider.value(
          value: productModel,
          child: OrderProductWidget(
            quantity: quantities[index],
          ),
        );
      },
    );
  }
}


/*
Why use Privider False 
*/