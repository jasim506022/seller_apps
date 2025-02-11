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

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({
    super.key,
    this.isCardDesign = false,
    this.sellerId,
  });
  final String? sellerId;
  final bool isCardDesign;

  @override
  Widget build(BuildContext context) {
    // Using Provider to get the orderModel instance, but setting `listen: false`
    // because we only need the data once and don't want to rebuild the widget
    // when the OrderModel changes.
    final orderController = Get.find<OrderController>();
    final orderModel = Provider.of<OrderModel>(context, listen: false);

    List<int> productQuantities =
        CartFunctions.separateOrderItemQuantities(orderModel.productIds);

    return FutureBuilder(
      future: _fetchOrderData(orderController, orderModel),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingSingleProductWidget();
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
        return InkWell(
          onTap: () {
            if (isCardDesign) {
              Get.toNamed(RoutesName.delivaryPage, arguments: orderModel);
            }
          },
          child: isCardDesign
              ? _buildCardView(context, snapshot, productQuantities)
              : _buildListView(snapshot, productQuantities),
        );
      },
    );
  }

  /// Fetches order data based on whether it's a seller or general order
  Future<dynamic> _fetchOrderData(
      OrderController orderController, OrderModel orderModel) {
    return sellerId == null
        ? orderController.fatchOrderProduct(orderModel: orderModel)
        : orderController.fatchSellerProduct(
            productList:
                CartFunctions.separteOrderProductIdList(orderModel.productIds),
            sellerId: sellerId!);
  }

  /// Builds the card-style UI when `isCardDesign` is true
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

  /// Builds the list of order products
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