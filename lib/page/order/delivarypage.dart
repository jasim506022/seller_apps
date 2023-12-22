import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../const/cartmethod.dart';
import '../../database/firebasedatabase.dart';
import 'cart_order_widget.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Shift Order Page",
          ),
        ),
        body: StreamBuilder(
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
