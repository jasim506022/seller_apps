import 'package:flutter/material.dart';

import 'widget/order_status_list_widget.dart';

class CompleteOrderPage extends StatelessWidget {
  const CompleteOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const OrderStatusListWidget(
      appBarTitle: "History",
      orderStatus: "complete",
    );
  }
}
