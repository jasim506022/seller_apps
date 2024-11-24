import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../const/cartmethod.dart';
import '../../const/global.dart';
import '../../controller/order_controller.dart';
import '../../model/order_model.dart';
import '../../model/productsmodel.dart';
import '../../res/app_asset/image_asset.dart';
import '../../res/app_function.dart';
import '../../res/apps_color.dart';
import '../../res/apps_text_style.dart';
import '../../res/routes/routes_name.dart';
import '../../widget/dot_line_printer.dart';
import '../../widget/empty_widget.dart';
import '../../widget/product_image_widget.dart';
import '../loading_widget/loading_list_single_product_widget.dart';
import '../loading_widget/loading_single_product_widget.dart';
import 'deliverypage.dart';
import 'main_order_page_widget.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return

        // Scaffold(
        //   body: MainOrderPage(
        //     status: "normal",
        //   ),
        // );

        const OrderStatusListWidget(
      appBarTitle: "Order Page",
      orderStatus: "normal",
    );
  }
}

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
                image: ImagesAsset.appLogoImage, //error
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
                  print(orderModel.seller);
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
    var seller = sharedPreference!.getString("uid")!;
    List<String> listProductID =
        CartFunctions.separteOrderProductIdList(orderModel.productIds);

    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("seller")
          .doc(seller)
          .collection("products")
          .where("productId", whereIn: listProductID)
          .get()
      // sellerId == null
      //     ? orderController.orderProductSnapshots(listProductID: listProductID)
      //     : orderController.sellerProductSnapshot(
      //         productList: listProductID, sellerId: sellerId!),
      ,
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
              // if (isCardDesign) {
              //   Get.toNamed(RoutesName.deliveryScreen, arguments: orderModel);
              // }
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

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({super.key, required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    return Container(
      height: 110.h,
      width: 0.9.w,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImageWidget(
            height: 100.h,
            width: 120.w,
            imageHeith: 110.h,
            productModel: productModel,
          ),
          Expanded(
            child: _buildProductDetails(productModel, context),
          )
        ],
      ),
    );
  }

  Padding _buildProductDetails(
      ProductModel productModel, BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 20.w, right: 12.w, top: 15.h, bottom: 15.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              productModel.productname!,
              style: AppsTextStyle.largeBoldText,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Text(productModel.productunit!.toString(),
                  style: AppsTextStyle.mediumBoldText.copyWith(
                    color: Theme.of(context).hintColor,
                  )),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("$quantity * ",
                      style: AppsTextStyle.mediumNormalText
                          .copyWith(color: AppColors.greenColor)),
                  Text(
                      "${AppsFunction.productPrice(productModel.productprice!, productModel.discount!.toDouble())}",
                      style: AppsTextStyle.mediumNormalText
                          .copyWith(color: AppColors.greenColor)),
                ],
              ),
              const Spacer(),
              Text(
                  "= ৳. ${AppsFunction.productPriceWithQuantity(productModel.productprice!, productModel.discount!.toDouble(), quantity).toStringAsFixed(2)}",
                  style: AppsTextStyle.largeBoldText
                      .copyWith(color: AppColors.greenColor)),
            ],
          ),
        ],
      ),
    );
  }
}

/*
class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Running Order",
          ),
        ),
        body: const MainOrderPage(
          status: 'normal',
        ));
  }
}

*/