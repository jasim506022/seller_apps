import 'package:flutter/material.dart';
import 'main_order_page_widget.dart';

class ShiftedOrderPage extends StatefulWidget {
  const ShiftedOrderPage({super.key});

  @override
  State<ShiftedOrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<ShiftedOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Shifted Order",
          ),
        ),
        body: const MainOrderPage(
          status: 'delivery',
        ));
    /*
        StreamBuilder(
          stream: FirebaseDatabase.allOrderSnapshots(status: 'delivery'),
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
    /*
         StreamBuilder(
          stream: FirebaseDatabase.allOrderSnapshots(status: 'delivery'),
          builder: (context, orderSnapshot) {
            if (orderSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ));
            } else if (!orderSnapshot.hasData ||
                orderSnapshot.data!.docs.isEmpty) {
              return const EmptyWidget(
                image: 'asset/empty/empty.png',
                title: 'Currently Now No Shift order Found',
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
                      } else if (orderSnapshot.hasError) {
                        return Text(
                          'Error Occure: ${orderSnapshot.error}',
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
                      // Dialog for
                      return Text(
                        'Error Occure: ${datasnapshot.error}',
                      );
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
          },
        ));
 */
  }
}
