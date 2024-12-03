import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seller_apps/view/other/pushnotification.dart';
import 'package:seller_apps/widget/show_error_dialog_widget.dart';

import '../../model/order_model.dart';
import 'widget/delivary_infor_widget.dart';
import 'widget/delivery_user_profile_stream.dart';
import 'order_delivery_locationn_widget.dart';
import 'order_status_widget.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'widget/order_item_widget.dart';

class OrderDeliveryPage extends StatefulWidget {
  const OrderDeliveryPage({
    super.key,
  });

  @override
  State<OrderDeliveryPage> createState() => _OrderDeliveryPageState();
}

class _OrderDeliveryPageState extends State<OrderDeliveryPage> {
  late OrderModel orderModel;

  Map<String, Map<String, String>> orderStatusData = {
    "normal": {
      "imageAsset": "asset/order/readyfordeliver.png",
      "title": "Please Sent your product on Admin",
    },
    "delivery": {
      "imageAsset": "asset/order/readyfordeliver.png",
      "title": "Thanks For send product to Admin",
    },
    "complete": {
      "imageAsset": "asset/order/doneorder.png",
      "title": "Order Delivery Complete",
    },
  };
/*
  void _showOrderCompleteDialog() {
    showDialog(
        context: context,
        builder: (context) => const ShowErrorDialogWidget(
            title: "Order Complete",
            message: "Order Already HandOver to User"));
  }

*/

  Widget _buildOrderStatusContainer(String orderStatus) {
    final statusData = orderStatusData[orderStatus];

    if (statusData == null) {
      return const SizedBox.shrink(); // Return empty widget for invalid status
    }

    final imageAsset = statusData["imageAsset"]!;
    final title = statusData["title"]!;

    return OrderStatusWidget(
      imageAsset: imageAsset,
      title: title,
      onTap: () {
        if (orderStatus == "complete") {
          // _showOrderCompleteDialog();
          Get.dialog(const ShowErrorDialogWidget(
              title: "Order Complete",
              message: "Order Already HandOver to User"));
        } else {
          _handleOrderUpdate(orderStatus);
        }
      },
    );
  }

  void _handleOrderUpdate(String currentStatus) {
    // Replace with logic to update order status
    final notification = PushNotification();
    notification.sendNotificationUser(
      "Bangladesh",
      "Indian",
      "Order status updated to $currentStatus",
    );

    if (currentStatus == "normal") _updateOrderStatus("delivery");
    if (currentStatus == "delivery") _updateOrderStatus("complete");
  }

  void _updateOrderStatus(String status) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderModel.orderId)
        .update({"status": status});
    await FirebaseFirestore.instance
        .collection("users")
        .doc(orderModel.orderBy)
        .collection("orders")
        .doc(orderModel.orderId)
        .update({"status": status});
    setState(() {});
  }

  @override
  void initState() {
    orderModel = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // OrderModel orderModel = Get.arguments;
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
                DeliveryUserProfileStream(
                    userId: orderModel.orderBy, orderId: orderModel.orderId),
                SizedBox(
                  height: 5.h,
                ),
                OrderDeliveryLocationWidget(
                  orderModel: orderModel,
                ),
                SizedBox(
                  height: 10.h,
                ),
                ChangeNotifierProvider.value(
                  value: orderModel,
                  child: const DeliveryInfoWidget(),
                ),
                SizedBox(
                  height: 10.h,
                ),
                _buildOrderStatusContainer(orderModel.status),
                SizedBox(
                  height: 15.h,
                ),
                ChangeNotifierProvider.value(
                  value: orderModel,
                  child: const OrderItemWidget(),
                )
              ],
            ),
          )),
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