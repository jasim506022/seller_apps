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
  }
}
