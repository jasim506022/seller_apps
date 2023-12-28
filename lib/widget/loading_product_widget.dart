import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../const/const.dart';
import '../const/utils.dart';

class LoadingProductWidget extends StatelessWidget {
  const LoadingProductWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    mq = MediaQuery.of(context).size;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .86,
          crossAxisSpacing: mq.width * .006,
          mainAxisSpacing: mq.width * .015),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          color: Theme.of(context).cardColor,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            color: Theme.of(context).cardColor,
            height: mq.height,
            width: mq.width,
            child: Shimmer.fromColors(
              baseColor: utils.baseShimmerColor,
              highlightColor: utils.highlightShimmerColor,
              child: Column(
                children: [
                  Container(
                    height: mq.height * .141,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color(0xfff6f5f1),
                        borderRadius: BorderRadius.circular(5)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: mq.height * .11,
                        width: mq.width,
                        color: utils.widgetShimmerColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mq.height * .01,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        globalMethod.buildShimmerTextContainer(
                            utils.widgetShimmerColor, mq.height * 0.02),
                        SizedBox(height: mq.height * 0.02),
                        globalMethod.buildShimmerTextContainer(
                            utils.widgetShimmerColor, mq.height * 0.02),
                        SizedBox(height: mq.height * 0.012),
                        globalMethod.buildShimmerTextContainer(
                            utils.widgetShimmerColor, mq.height * 0.02),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
