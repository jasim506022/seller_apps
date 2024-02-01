import 'package:flutter/material.dart';
import 'package:seller_apps/const/const.dart';
import 'package:shimmer/shimmer.dart';

import '../const/gobalcolor.dart';
import '../const/utils.dart';

class LoadingSingleProductWidget extends StatelessWidget {
  const LoadingSingleProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: mq.width * .022, vertical: mq.height * .01),
      child: Container(
        height: mq.height * .188,
        width: mq.width * .8,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: black,
                spreadRadius: .05,
              )
            ],
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20)),
        child: Shimmer.fromColors(
          baseColor: utils.baseShimmerColor,
          highlightColor: utils.highlightShimmerColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: mq.height * .165,
                    width: mq.height * .165,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: const Color(0xfff6f5f1),
                        borderRadius: BorderRadius.circular(5)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: mq.height * .141,
                        color: utils.widgetShimmerColor,
                      ),
                    ),
                  ),
                  Positioned(
                    left: mq.width * .022,
                    top: mq.height * .012,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: mq.width * .02,
                          vertical: mq.height * .007),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xffed6767), width: .5),
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 251, 196, 192)
                            .withOpacity(.2),
                      ),
                      child: Container(
                        height: mq.width * .044,
                        width: mq.width * .044,
                        color: utils.widgetShimmerColor,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: mq.width * .044,
                      right: mq.width * .025,
                      top: mq.height * .02,
                      bottom: mq.height * .02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      globalMethod.buildShimmerTextContainer(
                          utils.widgetShimmerColor, mq.height * 0.02),
                      SizedBox(
                        height: mq.height * .008,
                      ),
                      globalMethod.buildShimmerTextContainer(
                          utils.widgetShimmerColor, mq.height * 0.02),
                      SizedBox(
                        height: mq.height * .008,
                      ),
                      globalMethod.buildShimmerTextContainer(
                          utils.widgetShimmerColor, mq.height * 0.02),
                      /*
                      Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.7,
                        color: utils.widgetShimmerColor,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 30,
                        width: mq.width,
                        color: utils.widgetShimmerColor,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: utils.widgetShimmerColor,
                        ),
                      ),
                   
                   */
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
