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

// Main widget build method
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
        return const SizedBox.shrink(); // Or some default widget if needed
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

// Helper function to display an alert dialog
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
                        // _buildUserDetails(textstyle),
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

/*
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Tracking Number : ",
                                style: textstyle.mediumText600.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              TextSpan(
                                text: orderDataMap["trackingnumber"],
                                style: textstyle.mediumText600.copyWith(),
                              ),
                            ],
                          ),
                        ),

                        */
                        SizedBox(
                          height: mq.height * .05,
                        ),
                        _buildOrderStatusContainer()
                        /*
                      if (orderStatus == "normal")
                        _buildStatusContainer(
                          "asset/order/readyfordeliver.png",
                          "Produt Ready to Handover on Delivery Man",
                          () {
                            FirebaseFirestore.instance
                                .collection("orders")
                                .doc(widget.orderId)
                                .update({"status": "delivery"}).then((value) {
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(userId)
                                  .collection("orders")
                                  .doc(widget.orderId)
                                  .update({"status": "delivery"}).then((value) {
                                setState(() {});
                              });
                            });
                          },
                        ),
                      if (orderStatus == "delivery")
                        _buildStatusContainer(
                          "asset/order/readyfordeliver.png",
                          "Product Pust to Delivery Man",
                          () {
                            FirebaseFirestore.instance
                                .collection("orders")
                                .doc(widget.orderId)
                                .update({"status": "complete"}).then((value) {
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(userId)
                                  .collection("orders")
                                  .doc(widget.orderId)
                                  .update({"status": "complete"}).then((value) {
                                setState(() {});
                              });
                            });
                          },
                        ),
                      if (orderStatus == "complete")
                        _buildStatusContainer(
                          "asset/order/doneorder.png",
                          "Order Delivery Complete",
                          () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  title: Text("Order Complete"),
                                  content:
                                      Text("Order Already HandOver to User"),
                                );
                              },
                            );
                          },
                        ),
                     
                     */

                        ,
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
/*
              if (snapshot.hasData) {
                final orderDataMap = snapshot.data!.data();
                orderStatus = orderDataMap!["status"];
                userId = orderDataMap["orderBy"];
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserDetails(textstyle),
                      SizedBox(
                        height: mq.height * .01,
                      ),
                      _buildDeliveryAddress(textstyle, orderDataMap),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Tracking Number : ",
                              style: textstyle.mediumText600.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            TextSpan(
                              text: orderDataMap["trackingnumber"],
                              style: textstyle.mediumText600.copyWith(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      buildOrderStatusContainer()
                      /*
                      if (orderStatus == "normal")
                        _buildStatusContainer(
                          "asset/order/readyfordeliver.png",
                          "Produt Ready to Handover on Delivery Man",
                          () {
                            FirebaseFirestore.instance
                                .collection("orders")
                                .doc(widget.orderId)
                                .update({"status": "delivery"}).then((value) {
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(userId)
                                  .collection("orders")
                                  .doc(widget.orderId)
                                  .update({"status": "delivery"}).then((value) {
                                setState(() {});
                              });
                            });
                          },
                        ),
                      if (orderStatus == "delivery")
                        _buildStatusContainer(
                          "asset/order/readyfordeliver.png",
                          "Product Pust to Delivery Man",
                          () {
                            FirebaseFirestore.instance
                                .collection("orders")
                                .doc(widget.orderId)
                                .update({"status": "complete"}).then((value) {
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(userId)
                                  .collection("orders")
                                  .doc(widget.orderId)
                                  .update({"status": "complete"}).then((value) {
                                setState(() {});
                              });
                            });
                          },
                        ),
                      if (orderStatus == "complete")
                        _buildStatusContainer(
                          "asset/order/doneorder.png",
                          "Order Delivery Complete",
                          () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  title: Text("Order Complete"),
                                  content:
                                      Text("Order Already HandOver to User"),
                                );
                              },
                            );
                          },
                        ),
                     
                     */
                      ,
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              }
*/
            }),
      ),
    );
  }

/*
  Widget _buildStatusContainer(
      String imageAsset, String buttonText, Function onTap) {
    Textstyle textstyle = Textstyle(context);
    return OrderStatusWidget(
        context: context, context: context, textstyle: textstyle);
  }
*/
/*
  _buildDeliveryAddress(
      Textstyle textstyle, Map<String, dynamic> orderDataMap) {
    return OrderDeliveryLocationWidget(
      orderDataMap: orderDataMap,
      userId: userId,
      orderStatus: orderStatus,
    );
  }
  */

/*
  _buildUserDetails(Textstyle textstyle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Text(
            "User Details: ",
            style: textstyle.largeBoldText.copyWith(color: red),
          ),
        ),
        DeliveryUserProfileWidget(userId: userId, widget: widget),
      ],
    );
  }

  */
  /*
  Container _buildOrderItem(Map<String, dynamic> orderDataMap) {
    Textstyle textstyle = Textstyle(context);
    return OrderItemWidget(context: context, textstyle: textstyle, context: context, widget: widget);
  }
  */
}


/*
class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({
    super.key,
    required this.textstyle,
    required this.widget,
  });

  final Textstyle textstyle;
  final DeliveryPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Theme.of(context).cardColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order No: ${orderDataMap["orderId"]}",
            style: textstyle.largeText
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 20),
          Flexible(
            child: FutureBuilder(
              future: FirebaseDatabase.orderDeliveryOrderProductSnapshot(
                  list: orderDataMap['productIds']),
              builder: (context, productSnapshot) {
                if (productSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) => const LoadingCardWidget(),
                  );
                } else if (productSnapshot.hasData) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: productSnapshot.data!.docs.length,
                    itemBuilder: (context, itemIndex) {
                      ProductModel productModel = ProductModel.fromMap(
                        productSnapshot.data!.docs[itemIndex].data(),
                      );

                      return DeliveryCartWidget(
                        productModel: productModel,
                        itemQunter: widget.seperateQuantilies[itemIndex],
                        index: itemIndex + 1,
                      );
                    },
                  );
                }
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) => const LoadingCardWidget(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

*/