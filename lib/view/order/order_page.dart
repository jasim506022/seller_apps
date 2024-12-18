import 'package:flutter/material.dart';
import 'package:seller_apps/res/app_string.dart';

import 'widget/order_status_list_widget.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OrderStatusListWidget(
      appBarTitle: AppString.orderPage,
    );
  }
}
