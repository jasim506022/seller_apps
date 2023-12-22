import 'package:flutter/material.dart';

import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem({
    super.key,
    required this.image,
    required this.text,
    required this.function,
  });
  final String image;
  final String text;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    return InkWell(
      onTap: function,
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: mq.height * .085,
                width: mq.height * .085,
                color: greenColor,
              ),
              SizedBox(
                height: mq.height * .012,
              ),
              Text(text, style: textstyle.largeText)
            ],
          )),
    );
  }
}
