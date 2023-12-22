import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../service/database/firebasedatabase.dart';
import '../../model/productsmodel.dart';
import '../../model/profilemodel.dart';
import 'delivery_cart_widget.dart';
import 'loadingwidget.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen(
      {super.key, required this.orderId, required this.seperateQuantilies});
  final String orderId;
  final List<dynamic> seperateQuantilies;
  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  String orderStatus = "";
  String userId = "";

  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Delivery Details",
        ),
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: StreamBuilder(
            stream:
                FirebaseDatabase.singleorderSnapshots(orderId: widget.orderId),
            builder: (context, snapshot) {
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
                      const SizedBox(
                        height: 10,
                      ),
                      if (orderStatus == "normal")
                        _buildOrderItem(orderDataMap)
                      else if (orderStatus == "delivery")
                        _buildOrderItem(orderDataMap),
                      if (orderStatus == "complete")
                        _buildOrderCompleteItem(textstyle, orderDataMap),
                    ],
                  ),
                );
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }

  Container _buildOrderCompleteItem(
    Textstyle textstyle,
    Map<String, dynamic> orderDataMap,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Theme.of(context).cardColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Please Ratting Product",
            style: textstyle.largestText,
          ),
          const SizedBox(
            height: 20,
          ),
          Flexible(
            child: FutureBuilder(
              future: FirebaseDatabase.orderDeliveryOrderProductSnapshot(
                  list: orderDataMap['productIds']),
              builder: (context, productSnashot) {
                if (productSnashot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: productSnashot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return const LoadingCardWidget();
                    },
                  );
                } else if (productSnashot.hasData) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: productSnashot.data!.docs.length,
                    itemBuilder: (context, itemIndex) {
                      ProductModel productModel = ProductModel.fromMap(
                          productSnashot.data!.docs[itemIndex].data());

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
                  itemBuilder: (context, index) {
                    return const LoadingCardWidget();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusContainer(
      String imageAsset, String buttonText, Function onTap) {
    Textstyle textstyle = Textstyle(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Image.asset(
            imageAsset,
            height: 200,
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: () {
              onTap();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: deepGreen,
              ),
              child: Text(
                buttonText,
                style: textstyle.mediumTextbold.copyWith(color: white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildDeliveryAddress(
      Textstyle textstyle, Map<String, dynamic> orderDataMap) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Delivery Address: ",
                  style: textstyle.mediumTextbold
                      .copyWith(color: Theme.of(context).primaryColor)),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseDatabase.userDeliverysnapshot(
                        addressId: orderDataMap['addressId'], userId: userId),
                    builder: (context, addressSnashot) {
                      if (addressSnashot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (addressSnashot.hasData) {
                        return Text(
                            addressSnashot.data!.data()!['completeaddress'],
                            style: textstyle.mediumText);
                      }
                      return const Text("Address Not Found");
                    }),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          decoration: BoxDecoration(
              color: deepGreen, borderRadius: BorderRadius.circular(10)),
          padding:
              const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Estimated Delivery Date is: ",
                  style: textstyle.largeText.copyWith(
                    color: white,
                    fontSize: 15,
                  )),
              const SizedBox(
                width: 20,
              ),
              Text(
                orderStatus == "complete"
                    ? "Order Compete"
                    : globalMethod.getFormateDate(
                        context: context,
                        datetime: orderDataMap["deliverydate"]),
                style:
                    textstyle.largestText.copyWith(color: white, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: Text("Delivery Partner: ${orderDataMap["deliverypartner"]}",
              style: textstyle.mediumText600
                  .copyWith(color: Theme.of(context).primaryColor)),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

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
        StreamBuilder(
            stream: FirebaseDatabase.userDetailsSnaphots(userId: userId),
            builder: (context, usersnapshots) {
              if (usersnapshots.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (usersnapshots.hasData) {
                ProfileModel userProfile =
                    ProfileModel.fromMap(usersnapshots.data!.data()!);
                return Container(
                    height: MediaQuery.of(context).size.height * .155,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: mq.height * 0.12,
                            width: mq.height * 0.12,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(mq.height * 0.06),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: userProfile.imageurl!,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                  backgroundColor: white,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: mq.width * 0.05,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("name:\t${userProfile.name!}",
                                      style: textstyle.largeText.copyWith(
                                          fontSize: 16,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  SizedBox(
                                    height: mq.height * 0.01,
                                  ),
                                  Text("Emai:\t\t${userProfile.email!}",
                                      style: textstyle.mediumText600.copyWith(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor)),
                                  SizedBox(
                                    height: mq.height * 0.01,
                                  ),
                                  Text("Phone:\t\t 0${userProfile.phone!}",
                                      style: textstyle.mediumText600
                                          .copyWith(fontSize: 14, color: red)),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  // Speace and Line
                                  // Simple date Form
                                  Text(
                                    DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(widget.orderId))
                                        .toString(),
                                    style: textstyle.mediumText600.copyWith(
                                        color: Theme.of(context).primaryColor),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ));
              }
              return const CircularProgressIndicator();
            }),
      ],
    );
  }

  Container _buildOrderItem(Map<String, dynamic> orderDataMap) {
    Textstyle textstyle = Textstyle(context);
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
