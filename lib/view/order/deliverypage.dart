import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seller_apps/view/other/pushnotification.dart';
import 'package:seller_apps/widget/show_error_dialog_widget.dart';
import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../controller/order_controller.dart';
import '../../model/address_model.dart';
import '../../model/order_model.dart';
import '../../res/app_function.dart';
import '../../res/apps_color.dart';
import '../../res/apps_text_style.dart';
import '../../service/database/firebasedatabase.dart';

import '../../widget/empty_widget.dart';
import 'delivery_user_profile_widget.dart';
import 'order_delivery_locationn_widget.dart';
import 'order_item_widget.dart';
import 'order_status_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OrderDeliveryPage extends StatefulWidget {
  const OrderDeliveryPage({
    super.key,
  });

  @override
  State<OrderDeliveryPage> createState() => _OrderDeliveryPageState();
}

class _OrderDeliveryPageState extends State<OrderDeliveryPage> {
  void _showOrderCompleteDialog() {
    showDialog(
        context: context,
        builder: (context) => const ShowErrorDialogWidget(
            title: "Order Complete",
            message: "Order Already HandOver to User"));
  }

  Widget _buildOrderStatusContainer(String orderStatus) {
    switch (orderStatus) {
      case "normal":
        return OrderStatusWidget(
            imageAsset: "asset/order/readyfordeliver.png",
            title: "Product Ready to Handover on Delivery Man",
            onTap: () {
              PushNotification message = PushNotification();
              message.sendNotificationUser("Bangladesh", "Indian", "Oakay");
              // _updateOrderStatus("delivery");
            });
      case "delivery":
        return OrderStatusWidget(
            imageAsset: "asset/order/readyfordeliver.png",
            title: "Product Pushed to Delivery Man",
            onTap: () {
              PushNotification message = PushNotification();
              message.sendNotificationUser("Bangladesh", "Indian", "Oakay");
              // _updateOrderStatus("complete");
            });
      case "complete":
        return OrderStatusWidget(
          imageAsset: "asset/order/doneorder.png",
          title: "Order Delivery Complete",
          onTap: () => _showOrderCompleteDialog,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    OrderModel orderModel = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Delivery ",
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DeliveryUserProfileWidget(
                    userId: orderModel.orderBy, orderId: orderModel.orderId),
                SizedBox(
                  height: 15.h,
                ),
                // ChangeNotifierProvider.value(
                //   value: orderModel,
                //   child: const DeliveryEstimationCard(),
                // ),
                SizedBox(
                  height: 15.h,
                ),
                OrderDeliveryLocationWidget(
                  orderModel: orderModel,
                  userId: orderModel.orderBy,
                  orderStatus: orderModel.status,
                ),

                ChangeNotifierProvider.value(
                  value: orderModel,
                  child: const DeliveryInfoWidget(),
                ),
                SizedBox(
                  height: 15.h,
                ),
                globalMethod.buldRichText(
                    context: context,
                    simpleText: "Tracking Number :",
                    colorText: orderModel.trackingNumber,
                    function: () {}),
                SizedBox(
                  height: 10.h,
                ),
                _buildOrderStatusContainer(orderModel.status),
                /*
                if (orderModel.status == "normal")
                  OrderStatusWidget(
                    image: ImagesAsset.readyForDelivery,
                    title: "Ready For Shifted",
                  ),
                if (orderModel.status == "shift")
                  OrderStatusWidget(
                    image: ImagesAsset.deliveryOrder,
                    title: "Product Ready for User",
                  ),
                if (orderModel.status == "complete")
                  OrderStatusWidget(
                    image: ImagesAsset.confirmOrder,
                    title: "Order is Successfully Done",
                  ),
                SizedBox(
                  height: 10.h,
                ),
                ChangeNotifierProvider.value(
                  value: orderModel,
                  child: const OrderProductDetails(),
                )
              */
              ],
            ),
          )),
    );
  }
}

class DeliveryInfoWidget extends StatelessWidget {
  const DeliveryInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final orderModel = Provider.of<OrderModel>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DelivaryCardWidget(
          child: DeliveryRichTextWidget(
            title: "Delivery Partner:",
            subTitle: orderModel.deliveryPartner,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: DeliveryRichTextWidget(
                title: "Tracking Number :",
                color: AppColors.red,
                subTitle: orderModel.trackingNumber)),
        SizedBox(
          height: 15.h,
        ),
        OrderReceiverDetailsWidget(orderModel: orderModel),
      ],
    );
  }
}

class OrderReceiverDetailsWidget extends StatelessWidget {
  const OrderReceiverDetailsWidget({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    var orderController = Get.find<OrderController>();
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(orderModel.orderBy)
            .collection("useraddress")
            .doc(orderModel.addressId)
            .snapshots(),

        // orderController.orderAddressSnapsot(
        //     addressId: orderModel.addressId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text(
              "Error: ${snapshot.error}",
              style: AppsTextStyle.titleTextStyle.copyWith(fontSize: 20),
            );
          }
          if (snapshot.hasData) {
            AddressModel addressModel =
                AddressModel.fromMap(snapshot.data!.data()!);

            return DelivaryCardWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DeliveryRichTextWidget(
                    title: "Receiver:",
                    subTitle: addressModel.name!,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  DeliveryRichTextWidget(
                    title: "Phone Number:",
                    subTitle: "0${addressModel.phone!}",
                    color: AppColors.red,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(addressModel.completeaddress!,
                      style: AppsTextStyle.mediumNormalText
                          .copyWith(color: Theme.of(context).hintColor))
                ],
              ),
            );
          }
          return Text(
            "No Address is Avaiable",
            style: AppsTextStyle.titleTextStyle.copyWith(fontSize: 20),
          );
        });
  }
}

class DeliveryRichTextWidget extends StatelessWidget {
  const DeliveryRichTextWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.color,
  });

  final String title;
  final String subTitle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: AppsTextStyle.mediumBoldText,
          ),
          WidgetSpan(
              child: SizedBox(
            width: 10.w,
          )),
          TextSpan(
              text: subTitle,
              style: AppsTextStyle.mediumNormalText.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color ?? Theme.of(context).primaryColor)),
        ],
      ),
    );
  }
}

class DelivaryCardWidget extends StatelessWidget {
  const DelivaryCardWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.r)),
        child: child);
  }
}

class DeliveryEstimationCard extends StatelessWidget {
  const DeliveryEstimationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final orderModel = Provider.of<OrderModel>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
          color: AppColors.deepGreen,
          borderRadius: BorderRadius.circular(15.r)),
      height: 0.27.sh,
      width: 1.sw,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 30.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("On The way From Dhaka!", //28
              style: AppsTextStyle.largeBoldText
                  .copyWith(color: AppColors.white, fontSize: 24)),
          SizedBox(
            height: 10.h,
          ),
          Text("Estimated Delivery Date is",
              style: AppsTextStyle.titleTextStyle.copyWith(
                color: AppColors.white,
              )),
          SizedBox(
            height: 20.h,
          ),
          // Text(
          //   AppsFunction.formatDeliveryDate(datetime: orderModel.deliveryDate),
          //   style: AppsTextStyle.titleTextStyle
          //       .copyWith(color: AppColors.white, fontSize: 28.sp),
          // ),
        ],
      ),
    );
  }
}


/*
class DeliveryPage extends StatefulWidget {
  const DeliveryPage(
      {super.key, required this.orderId, required this.seperateQuantilies});
  final String orderId;
  final List<dynamic> seperateQuantilies;
  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  String orderStatus = "";
  String userId = "";

  Widget _buildOrderStatusContainer() {
    switch (orderStatus) {
      case "normal":
        return OrderStatusWidget(
            imageAsset: "asset/order/readyfordeliver.png",
            title: "Product Ready to Handover on Delivery Man",
            onTap: () {
              PushNotification message = PushNotification();
              message.sendNotificationUser("Bangladesh", "Indian", "Oakay");
              // _updateOrderStatus("delivery");
            });
      case "delivery":
        return OrderStatusWidget(
            imageAsset: "asset/order/readyfordeliver.png",
            title: "Product Pushed to Delivery Man",
            onTap: () {
              PushNotification message = PushNotification();
              message.sendNotificationUser("Bangladesh", "Indian", "Oakay");
              // _updateOrderStatus("complete");
            });
      case "complete":
        return OrderStatusWidget(
          imageAsset: "asset/order/doneorder.png",
          title: "Order Delivery Complete",
          onTap: () => _showOrderCompleteDialog,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  void _updateOrderStatus(String status) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.orderId)
        .update({"status": status});
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("orders")
        .doc(widget.orderId)
        .update({"status": status});
    setState(() {});
  }

  void _showOrderCompleteDialog() {
    showDialog(
        context: context,
        builder: (context) => const ShowErrorDialogWidget(
            title: "Order Complete",
            message: "Order Already HandOver to User"));
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Delivery Details",
        ),
        elevation: 0.5,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mq.width * .022, vertical: mq.height * .012),
        child: StreamBuilder(
            stream:
                FirebaseDatabase.singleorderSnapshots(orderId: widget.orderId),
            builder: (context, snapshot) {
              try {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: red,
                  ));
                } else if (snapshot.hasData) {
                  final orderDataMap = snapshot.data!.data();
                  orderStatus = orderDataMap!["status"];
                  userId = orderDataMap["orderBy"];
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DeliveryUserProfileWidget(
                            userId: userId, orderId: widget.orderId),
                        SizedBox(
                          height: mq.height * .02,
                        ),
                        OrderDeliveryLocationWidget(
                          orderDataMap: orderDataMap,
                          userId: userId,
                          orderStatus: orderStatus,
                        ),
                        globalMethod.buldRichText(
                            context: context,
                            simpleText: "Tracking Number :",
                            colorText: orderDataMap["trackingnumber"],
                            function: () {}),
                        SizedBox(
                          height: mq.height * .05,
                        ),
                        _buildOrderStatusContainer(),
                        SizedBox(
                          height: mq.height * .025,
                        ),
                        OrderItemWidget(
                          orderDataMap: orderDataMap,
                          seperateQuantilies: widget.seperateQuantilies,
                        ),
                      ],
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const EmptyWidget(
                    image: 'asset/empty/empty.png',
                    title: 'Currently Now No order Found',
                  );
                } else if (snapshot.hasError) {
                  return EmptyWidget(
                    image: 'asset/empty/empty.png',
                    title: 'Error Found: ${snapshot.hasError}',
                  );
                }
                return const EmptyWidget(
                  image: 'asset/empty/empty.png',
                  title: 'Something is Error',
                );
              } catch (e) {
                return EmptyWidget(
                  image: 'asset/empty/empty.png',
                  title: 'Error Occured: $e',
                );
              }
            }),
      ),
    );
  }
}
*/