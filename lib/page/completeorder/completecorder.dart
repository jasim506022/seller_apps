import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/cartmethod.dart';
import '../../const/const.dart';
import '../../database/firebasedatabase.dart';
import '../../service/provider/totalamountprovider.dart';
import '../order/cart_order_widget.dart';

class CompleteOrderPage extends StatefulWidget {
  const CompleteOrderPage({super.key});

  @override
  State<CompleteOrderPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<CompleteOrderPage> {
  double totalAmount = 0.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TotalAmountProvider>(context, listen: false).setZeroAmount();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Shift Order Page",
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseDatabase.allShiftOrderSnaphort(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Text(
                      'asset/payment/empty.png',
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      'Error Occure: ${snapshot.error}',
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index].data();
                        if (kDebugMode) {
                          print(data);
                        }
                        return FutureBuilder(
                          future: FirebaseDatabase.orderProductSnapshots(
                              snpshot: snapshot.data!.docs[index].data()),
                          builder: (context, datasnapshot) {
                            if (datasnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Text(
                                'asset/payment/empty.png',
                              );
                            } else if (snapshot.hasError) {
                              return Text(
                                'Error Occure: ${snapshot.error}',
                              );
                            } else {
                              List<dynamic> listItem =
                                  CartMethods.separateOrderItemQuantities(
                                      (snapshot.data!.docs[index]
                                          .data())["productIds"]);
                              for (var i = 0;
                                  i < datasnapshot.data!.docs.length;
                                  i++) {
                                print(listItem[i] *
                                    datasnapshot.data!.docs[i]['productprice']);
                                Future.delayed(Duration.zero, () {
                                  Provider.of<TotalAmountProvider>(context,
                                          listen: false)
                                      .setAmount(
                                          amount: listItem[i] *
                                              datasnapshot.data!.docs[i]
                                                  ['productprice']);
                                });
                              }

                              return CartOrderWidget(
                                itemCount: datasnapshot.data!.docs.length,
                                data: datasnapshot.data!.docs,
                                orderId: snapshot.data!.docs[index].id,
                                seperateQuantilies: listItem,
                              );
                            }
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Consumer<TotalAmountProvider>(
              builder: (context, value, child) => Text(
                "Total Amount: ${value.amount}",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ));
  }
}
