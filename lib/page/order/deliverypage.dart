import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seller_apps/widget/show_error_dialog_widget.dart';
import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../service/database/firebasedatabase.dart';

import '../../widget/empty_widget.dart';
import 'delivery_user_profile_widget.dart';
import 'order_delivery_locationn_widget.dart';
import 'order_item_widget.dart';
import 'order_status_widget.dart';

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
          onTap: () => _updateOrderStatus("delivery"),
        );
      case "delivery":
        return OrderStatusWidget(
          imageAsset: "asset/order/readyfordeliver.png",
          title: "Product Pushed to Delivery Man",
          onTap: () => _updateOrderStatus("complete"),
        );
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
