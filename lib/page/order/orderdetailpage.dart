import 'package:flutter/material.dart';
import 'package:seller_apps/page/main/mainscreen.dart';

import '../../const/cartmethod.dart';
import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../database/firebasedatabase.dart';
import '../../model/productsmodel.dart';
import '../../model/profilemodel.dart';
import 'delivery_cart_widget.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage(
      {super.key,
      required this.orderId,
      required this.addressId,
      required this.order,
      required this.itemQuantityList});
  final String orderId;
  final String addressId;
  final List<dynamic> order;
  final List<dynamic> itemQuantityList;
  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Details",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            /*
            StreamBuilder(
                stream: FirebaseDatabase.userDetails(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.hasData) {
                    ProfileModel profileModel =
                        ProfileModel.fromMap(userSnapshot.data!.data()!);
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 20),
                      decoration:
                          BoxDecoration(color: Theme.of(context).cardColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ship & Bill To",
                            style: textstyle.largeBoldText
                                .copyWith(color: Theme.of(context).hintColor),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("Receiver: ${profileModel.name!}",
                              style: textstyle.mediumText600.copyWith(
                                  color: Theme.of(context).primaryColor)),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(profileModel.phone!,
                              style: textstyle.mediumText600.copyWith(
                                  color: Theme.of(context).primaryColor)),
                          const SizedBox(
                            height: 8,
                          ),
                          StreamBuilder(
                              stream: FirebaseDatabase.orderAddressSnapsot(
                                  addressId: widget.addressId),
                              builder: (context, addressSnashot) {
                                if (addressSnashot.hasData) {
                                  return Text(
                                      addressSnashot.data!
                                          .data()!['completeaddress'],
                                      style: textstyle.mediumText600.copyWith(
                                          color: Theme.of(context).hintColor));
                                }
                                return const CircularProgressIndicator();
                              }),
                        ],
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                }),
            */
            SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              child: StreamBuilder(
                stream: FirebaseDatabase.orderSelerSnapshots(
                    list:
                        CartMethods.separateOrderSellerCartList(widget.order)),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var sellerId = snapshot.data!.docs[index]["name"];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: RichText(
                                  text: TextSpan(
                                      style: textstyle.largeBoldText.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                      children: [
                                    const TextSpan(text: "Seller Name:\t"),
                                    TextSpan(
                                      text: sellerId,
                                      style: textstyle.largeBoldText
                                          .copyWith(color: red),
                                    )
                                  ])),
                            ),
                            Flexible(
                              child: FutureBuilder(
                                future: FirebaseDatabase
                                    .deliveryOrderProductSnapshots(
                                        list: widget.order),
                                builder: (context, productSnashot) {
                                  if (productSnashot.hasData) {
                                    return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          productSnashot.data!.docs.length,
                                      itemBuilder: (context, itemIndex) {
                                        ProductModel productModel =
                                            ProductModel.fromMap(productSnashot
                                                .data!.docs[itemIndex]
                                                .data());

                                        return DeliveryCartWidget(
                                          productModel: productModel,
                                          itemQunter: widget
                                              .itemQuantityList[itemIndex],
                                          index: itemIndex,
                                        );
                                      },
                                    );
                                  }
                                  return const CircularProgressIndicator();
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order #${widget.orderId}",
                        style: textstyle.largeBoldText.copyWith(
                          color: greenColor,
                        )),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                        "Placed On ${globalMethod.getFormateDate(context: context, datetime: widget.orderId)}",
                        style: textstyle.mediumText600
                            .copyWith(color: Theme.of(context).hintColor)),
                    const SizedBox(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: greenColor,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30)),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(index: 0),
                                ),
                                (route) => false);
                          },
                          child: Text(
                            "Home Page",
                            style: textstyle.largestText
                                .copyWith(color: white, fontSize: 20),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
