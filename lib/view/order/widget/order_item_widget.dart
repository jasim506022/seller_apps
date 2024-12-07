import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../const/cart_function.dart';
import '../../../controller/order_controller.dart';
import '../../../model/order_model.dart';
import '../../../model/productsmodel.dart';
import '../../../res/app_asset/image_asset.dart';
import '../../../res/apps_color.dart';
import '../../../res/routes/routes_name.dart';
import '../../../widget/dot_line_printer.dart';
import '../../../widget/empty_widget.dart';
import '../../loading_widget/loading_single_product_widget.dart';
import 'cart_product_widget.dart';

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
    var orderController = Get.find<OrderController>();
    final orderModel = Provider.of<OrderModel>(context, listen: false);

    List<int> separateQuantities =
        CartFunctions.separateOrderItemQuantities(orderModel.productIds);
    List<String> listProductID =
        CartFunctions.separteOrderProductIdList(orderModel.productIds);

    return FutureBuilder(
      future: sellerId == null
          ? orderController.orderProductSnapshots(orderModel: orderModel)
          : orderController.sellerProductSnapshot(
              productList: listProductID, sellerId: sellerId!),

      //  FirebaseFirestore.instance
      //     .collection("products")
      //     .where("sellerId", isEqualTo: sellerId)
      //     .where("productId", whereIn: listProductID)
      //     .orderBy("publishDate", descending: true)
      //     .get(),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingSingleProductWidget();
        } else if (!snapshot.hasData ||
            snapshot.data!.docs.isEmpty ||
            snapshot.hasError) {
          return EmptyWidget(
            image: ImagesAsset.appLogoImage, //error
            title: snapshot.hasError
                ? 'Error Occurred: ${snapshot.error}'
                : 'No Data Available',
          );
        } else {
          return InkWell(
            onTap: () {
              Get.toNamed(RoutesName.delivaryPage, arguments: orderModel);

              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => DeliveryPage(
              //         orderId: orderModel.orderId,
              //         seperateQuantilies: separateQuantities,
              //       ),
              //     ));
              if (isCardDesign) {
                Get.toNamed(RoutesName.delivaryPage, arguments: orderModel);
              } else {
                // Get.toNamed(RoutesName.detailsPage, arguments: {
                //   "productModel":product
                // });
              }
            },
            child: isCardDesign
                ? _buildCardDesign(context, snapshot, separateQuantities)
                : _buildListView(snapshot, separateQuantities),
          );
        }
      },
    );
  }

  Widget _buildCardDesign(
      BuildContext context, AsyncSnapshot snapshot, List<int> quantities) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      shadowColor: AppColors.black,
      child: Container(
        padding: EdgeInsets.all(5.r),
        margin: EdgeInsets.all(5.r),
        height: snapshot.data!.docs.length * 120.h,
        child: _buildListView(snapshot, quantities),
      ),
    );
  }

  Widget _buildListView(AsyncSnapshot snapshot, List<int> quantities) {
    return ListView.separated(
      separatorBuilder: (context, index) => CustomPaint(
        painter: DottedLinePainter(),
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        ProductModel model =
            ProductModel.fromMap(snapshot.data!.docs[index].data());
        return ChangeNotifierProvider.value(
          value: model,
          child: CartProductWidget(
            quantity: quantities[index],
          ),
        );
      },
    );
  }
}
