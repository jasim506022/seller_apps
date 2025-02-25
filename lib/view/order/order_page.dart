import 'package:flutter/material.dart';

import '../../res/app_string.dart';
import 'widget/order_status_by_list_widget.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const OrderListByStatusWidget(
      appBarTitle: AppStrings.orderPageTitle,
    );
  }
}
