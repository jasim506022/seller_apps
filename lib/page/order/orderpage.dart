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
  }
}
