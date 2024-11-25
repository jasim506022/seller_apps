import 'package:flutter/material.dart';

import 'widget/order_status_list_widget.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const OrderStatusListWidget(
      appBarTitle: "Order Page",
      orderStatus: "normal",
    );
  }
}
