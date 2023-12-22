import 'package:flutter/material.dart';

import '../const/const.dart';
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
    return Center(
      child: Stack(
        children: [
          Image.asset(
            image,
            height: mq.height * .65,
            width: mq.width * .7,
          ),
          Positioned(
            top: mq.height * .1411,
            left: mq.width * .289,
            right: mq.width * .089,
            child: Center(
              child: Container(
                height: mq.height * .353,
                width: mq.height * .289,
                alignment: Alignment.center,
                child: Text(title, style: Textstyle.emptyTestStyle),
              ),
            ),
          )
        ],
      ),
    );
  }
}
