import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/const.dart';
import '../../const/utils.dart';

class LoadingSimilierWidget extends StatelessWidget {
  const LoadingSimilierWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          height: mq.height * .18,
          width: mq.width * .2,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(left: 15),
          color: Theme.of(context).cardColor,
          child: Shimmer.fromColors(
            baseColor: utils.baseShimmerColor,
            highlightColor: utils.highlightShimmerColor,
            child: Column(
              children: [
                Container(
                  height: mq.height * .12,
                  width: mq.width * .15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: utils.widgetShimmerColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: mq.height * .02,
                  width: mq.width * .15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: utils.widgetShimmerColor),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
