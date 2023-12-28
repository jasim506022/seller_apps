import 'package:flutter/material.dart';

import 'main_order_page_widget.dart';

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
            "Running Order",
          ),
        ),
        body: const MainOrderPage(
          status: 'normal',
        ));

    /*
         StreamBuilder(
          stream: FirebaseDatabase.allOrderSnapshots(status: 'normal'),
          builder: (context, orderSnapshot) {
            try {
              if (orderSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: red,
                ));
              } else if (!orderSnapshot.hasData ||
                  orderSnapshot.data!.docs.isEmpty) {
                return const EmptyWidget(
                  image: 'asset/empty/empty.png',
                  title: 'Currently Now No order Found',
                );
              } else if (orderSnapshot.hasData) {
                var listOrderSnapshot = orderSnapshot.data!.docs;
                return ListView.builder(
                  itemCount: listOrderSnapshot.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future: FirebaseDatabase.orderProductSnapshots(
                          snpshot: listOrderSnapshot[index].data()),
                      builder: (context, datasnapshot) {
                        if (datasnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingSingleProductWidget();
                        } else if (datasnapshot.hasError) {
                          return EmptyWidget(
                            image: 'asset/empty/empty.png',
                            title: 'Error Found: ${datasnapshot.hasError}',
                          );
                        } else if (datasnapshot.hasData) {
                          List<dynamic> listItem =
                              CartMethods.separateOrderItemQuantities(
                                  (listOrderSnapshot[index]
                                      .data())["productIds"]);
                          return CartOrderWidget(
                            itemCount: datasnapshot.data!.docs.length,
                            data: datasnapshot.data!.docs,
                            orderId: listOrderSnapshot[index].id,
                            seperateQuantilies: listItem,
                          );
                        }
                        return const LoadingSingleProductWidget();
                      },
                    );
                  },
                );
              } else if (orderSnapshot.hasError) {
                return EmptyWidget(
                  image: 'asset/empty/empty.png',
                  title: 'Error Found: ${orderSnapshot.hasError}',
                );
              }
              return const EmptyWidget(
                image: 'asset/empty/empty.png',
                title: 'Currently Now No order Found',
              );
            } catch (e) {
              return EmptyWidget(
                image: 'asset/empty/empty.png',
                title: 'Error Occured: $e',
              );
            }
          },
        ));
  */
  }
}
