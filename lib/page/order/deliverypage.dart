import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../database/firebasedatabase.dart';
import '../../model/productsmodel.dart';
import '../../model/profilemodel.dart';
import 'delivery_cart_widget.dart';
import 'loadingwidget.dart';
import 'orderdetailpage.dart';

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
            stream: FirebaseDatabase.orderSnapshots(orderId: widget.orderId),
            builder: (context, snapshot) {
              Map? orderDataMap;
              if (snapshot.hasData) {
                orderDataMap = snapshot.data!.data();
                orderStatus = orderDataMap!["status"];
                userId = orderDataMap["orderBy"];
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Text(
                          "User Details: ",
                          style: textstyle.largeBoldText.copyWith(color: red),
                        ),
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .doc(userId)
                              .snapshots(),
                          builder: (context, usersnapshots) {
                            if (usersnapshots.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            if (snapshot.hasData) {
                              ProfileModel userProfile = ProfileModel.fromMap(
                                  usersnapshots.data!.data()!);
                              return Container(
                                  height:
                                      MediaQuery.of(context).size.height * .16,
                                  width: MediaQuery.of(context).size.width,
                                  color: Theme.of(context).cardColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .1,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                userProfile.imageurl!),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(userProfile.name!,
                                                    style: textstyle.largeText
                                                        .copyWith(
                                                            fontSize: 16,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor)),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(userProfile.email!,
                                                    style: textstyle
                                                        .mediumText600
                                                        .copyWith(
                                                            fontSize: 14,
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor)),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text("0${userProfile.phone!}",
                                                    style: textstyle
                                                        .mediumText600
                                                        .copyWith(
                                                            fontSize: 14,
                                                            color: red)),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  DateTime.fromMillisecondsSinceEpoch(
                                                          int.parse(
                                                              widget.orderId))
                                                      .toString(),
                                                  style: textstyle
                                                      .mediumTextbold
                                                      .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                )
                                                /*
                                                StreamBuilder(
                                                    stream: FirebaseDatabase
                                                        .orderAddressSnapsot(
                                                            addressId:
                                                                orderDataMap![
                                                                    'addressId'],
                                                            userUdi: userId),
                                                    builder: (context,
                                                        addressSnashot) {
                                                      if (addressSnashot
                                                          .hasData) {
                                                        return Text(
                                                            addressSnashot.data!
                                                                    .data()![
                                                                'completeaddress'],
                                                            style: textstyle
                                                                .mediumText600
                                                                .copyWith(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .hintColor));
                                                      }
                                                      return const Text(
                                                          "Address Not Found");
                                                    }),
                                              */
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            }
                            return const Text("Banglades");
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 20),
                        decoration:
                            BoxDecoration(color: Theme.of(context).cardColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Delivery Address: ",
                                style: textstyle.mediumTextbold.copyWith(
                                    color: Theme.of(context).primaryColor)),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: StreamBuilder(
                                  stream: FirebaseDatabase.orderAddressSnapsot(
                                      addressId: orderDataMap['addressId'],
                                      userUdi: userId),
                                  builder: (context, addressSnashot) {
                                    if (addressSnashot.hasData) {
                                      return Text(
                                          addressSnashot.data!
                                              .data()!['completeaddress'],
                                          style: textstyle.mediumText600
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor));
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
                            color: deepGreen,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, bottom: 10, right: 10),
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
                              globalMethod.getFormateDate(
                                  context: context,
                                  datetime: orderDataMap["deliverydate"]),
                              style: textstyle.largestText
                                  .copyWith(color: white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                        decoration:
                            BoxDecoration(color: Theme.of(context).cardColor),
                        child: Text(
                            "Delivery Partner: ${orderDataMap["deliverypartner"]}",
                            style: textstyle.mediumText600.copyWith(
                                color: Theme.of(context).primaryColor)),
                      ),
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
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          color: Theme.of(context).cardColor,
                          child: Column(
                            children: [
                              Image.asset(
                                "asset/order/readyfordeliver.png",
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection("orders")
                                      .doc(widget.orderId)
                                      .update({"status": "deliver"}).then(
                                          (value) {
                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(userId)
                                        .collection("orders")
                                        .doc(widget.orderId)
                                        .update({"status": "deliver"}).then(
                                            (value) {
                                      setState(() {});
                                    });
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 45, vertical: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: deepGreen,
                                  ),
                                  child: Text(
                                    "Produt Handover To Delivery",
                                    style: textstyle.mediumTextbold
                                        .copyWith(color: white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (orderStatus == "deliver")
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          color: Theme.of(context).cardColor,
                          child: Column(
                            children: [
                              Image.asset(
                                "asset/order/readyfordeliver.png",
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection("orders")
                                      .doc(widget.orderId)
                                      .update({"status": "complete"}).then(
                                          (value) {
                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(userId)
                                        .collection("orders")
                                        .doc(widget.orderId)
                                        .update({"status": "complete"}).then(
                                            (value) {
                                      setState(() {});
                                    });
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 45, vertical: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: deepGreen,
                                  ),
                                  child: Text(
                                    "Product Pust to Delivery Man",
                                    style: textstyle.largestText
                                        .copyWith(color: white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (orderStatus == "complete")
                        Container(
                          padding: const EdgeInsets.all(15),
                          color: Theme.of(context).cardColor,
                          child: Column(
                            children: [
                              Image.asset(
                                "asset/order/doneorder.png",
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 45, vertical: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: deepGreen,
                                ),
                                child: Text(
                                  "Order Delivery Complete",
                                  style: textstyle.largestText
                                      .copyWith(color: white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (orderStatus == "complete")
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                                  future: FirebaseDatabase
                                      .deliveryOrderProductSnapshots(
                                          list: orderDataMap['productIds']),
                                  builder: (context, productSnashot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            productSnashot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          return const LoadingCardWidget();
                                        },
                                      );
                                    } else if (productSnashot.hasData) {
                                      return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            productSnashot.data!.docs.length,
                                        itemBuilder: (context, itemIndex) {
                                          ProductModel productModel =
                                              ProductModel.fromMap(
                                                  productSnashot
                                                      .data!.docs[itemIndex]
                                                      .data());

                                          return DeliveryCartWidget(
                                            productModel: productModel,
                                            itemQunter: widget
                                                .seperateQuantilies[itemIndex],
                                            index: itemIndex + 1,
                                          );
                                        },
                                      );
                                    }
                                    return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
                        ),
                      if (orderStatus == "normal")
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          color: Theme.of(context).cardColor,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order ${orderDataMap["orderId"]}",
                                    style: textstyle.largeText.copyWith(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OrderDetailsPage(
                                              orderId: widget.orderId,
                                              addressId:
                                                  orderDataMap!['addressId'],
                                              order: orderDataMap['productIds'],
                                              itemQuantityList:
                                                  widget.seperateQuantilies,
                                            ),
                                          ));
                                    },
                                    child: Text(
                                      "Order Details >",
                                      style: GoogleFonts.roboto(
                                          fontSize: 13,
                                          color: red,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Flexible(
                                child: FutureBuilder(
                                  future: FirebaseDatabase
                                      .deliveryOrderProductSnapshots(
                                          list: orderDataMap['productIds']),
                                  builder: (context, productSnashot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            productSnashot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          return const LoadingCardWidget();
                                        },
                                      );
                                    } else if (productSnashot.hasData) {
                                      return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            productSnashot.data!.docs.length,
                                        itemBuilder: (context, itemIndex) {
                                          ProductModel productModel =
                                              ProductModel.fromMap(
                                                  productSnashot
                                                      .data!.docs[itemIndex]
                                                      .data());

                                          return DeliveryCartWidget(
                                            productModel: productModel,
                                            itemQunter: widget
                                                .seperateQuantilies[itemIndex],
                                            index: itemIndex + 1,
                                          );
                                        },
                                      );
                                    }
                                    return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
                        ),
                      if (orderStatus == "deliver")
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          color: Theme.of(context).cardColor,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order ${orderDataMap["orderId"]}",
                                    style: textstyle.largeText.copyWith(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OrderDetailsPage(
                                              orderId: widget.orderId,
                                              addressId:
                                                  orderDataMap!['addressId'],
                                              order: orderDataMap['productIds'],
                                              itemQuantityList:
                                                  widget.seperateQuantilies,
                                            ),
                                          ));
                                    },
                                    child: Text(
                                      "Order Details >",
                                      style: GoogleFonts.roboto(
                                          fontSize: 13,
                                          color: red,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Flexible(
                                child: FutureBuilder(
                                  future: FirebaseDatabase
                                      .deliveryOrderProductSnapshots(
                                          list: orderDataMap['productIds']),
                                  builder: (context, productSnashot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            productSnashot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          return const LoadingCardWidget();
                                        },
                                      );
                                    } else if (productSnashot.hasData) {
                                      return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            productSnashot.data!.docs.length,
                                        itemBuilder: (context, itemIndex) {
                                          ProductModel productModel =
                                              ProductModel.fromMap(
                                                  productSnashot
                                                      .data!.docs[itemIndex]
                                                      .data());

                                          return DeliveryCartWidget(
                                            productModel: productModel,
                                            itemQunter: widget
                                                .seperateQuantilies[itemIndex],
                                            index: itemIndex + 1,
                                          );
                                        },
                                      );
                                    }
                                    return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
                        )
                    ],
                  ),
                );
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
