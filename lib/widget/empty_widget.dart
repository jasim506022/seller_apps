import 'package:flutter/material.dart';
import 'package:seller_apps/const/const.dart';

import '../const/textstyle.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          image,
          height: mq.height * .65,
          width: mq.width * .7,
        ),
        Positioned(
          top: 120,
          left: 130,
          right: 40,
          child: Center(
            child: Container(
              height: 300,
              width: 130,
              alignment: Alignment.center,
              child: Text(title, style: Textstyle.emptyTestStyle),
            ),
          ),
        )
      ],
    );
  }
}
