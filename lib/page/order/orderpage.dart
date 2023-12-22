import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../const/cartmethod.dart';
import '../../database/firebasedatabase.dart';
import 'cart_order_widget.dart';

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
            "New Order",
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseDatabase.allOrderSnapshots(),
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
                            CartMethods.separateOrderItemQuantities((snapshot
                                .data!.docs[index]
                                .data())["productIds"]);
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
        ));
  }
}
