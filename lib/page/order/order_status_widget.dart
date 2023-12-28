import 'package:flutter/material.dart';
import 'package:seller_apps/const/const.dart';

import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.onTap,
  });

  final String imageAsset;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: mq.width * .044),
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Image.asset(
            imageAsset,
            height: mq.height * 0.24,
            width: mq.width,
          ),
          SizedBox(height: mq.height * 0.018),
          InkWell(
            onTap: () {
              onTap();
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: mq.width * 0.044, vertical: mq.height * .018),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: deepGreen,
              ),
              child: Text(
                title,
                style: textstyle.mediumTextbold.copyWith(color: white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
