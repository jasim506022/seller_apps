import 'package:flutter/material.dart';

import 'main_order_page_widget.dart';

class CompleteOrderPage extends StatefulWidget {
  const CompleteOrderPage({super.key});

  @override
  State<CompleteOrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<CompleteOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Complete Order Page",
          ),
        ),
        body: const MainOrderPage(
          status: 'complete',
        ));
  }
}
