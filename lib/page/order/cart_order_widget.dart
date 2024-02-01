import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seller_apps/page/order/single_card_widget.dart';

import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../model/productsmodel.dart';
import 'deliverypage.dart';

class CartOrderWidget extends StatefulWidget {
  const CartOrderWidget(
      {super.key,
      required this.itemCount,
      required this.data,
      required this.orderId,
      required this.seperateQuantilies});

  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderId;
  final List<dynamic> seperateQuantilies;

  @override
  State<CartOrderWidget> createState() => _CartOrderWidgetState();
}

class _CartOrderWidgetState extends State<CartOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeliveryPage(
                orderId: widget.orderId,
                seperateQuantilies: widget.seperateQuantilies,
              ),
            ));
      },
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 5,
        margin: EdgeInsets.symmetric(
            horizontal: mq.width * .033, vertical: mq.width * .012),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        shadowColor: black,
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          height: widget.itemCount * mq.height * .151,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.itemCount,
            itemBuilder: (context, index) {
              ProductModel model = ProductModel.fromMap(
                  widget.data[index].data() as Map<String, dynamic>);
              return SingleCardWidget(
                index: index,
                productModel: model,
                seperateQuantilies: widget.seperateQuantilies,
              );
            },
          ),
        ),
      ),
    );
  }
}
