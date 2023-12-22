import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/gobalcolor.dart';
import '../../const/utils.dart';

class LoadingCardWidget extends StatelessWidget {
  const LoadingCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Container(
            height: 130,
            width: MediaQuery.of(context).size.width * .9,
            decoration: BoxDecoration(
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
                        height: 110,
                        width: 140,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 120,
                            width: 130,
                            color: utils.widgetShimmerColor,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: red, width: .5),
                            borderRadius: BorderRadius.circular(15),
                            color: lightred.withOpacity(.2),
                          ),
                          child: Container(
                            height: 10,
                            width: 20,
                            color: utils.widgetShimmerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 12, top: 15, bottom: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 15,
                            width: MediaQuery.of(context).size.width,
                            color: utils.widgetShimmerColor,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 15,
                            width: MediaQuery.of(context).size.width,
                            color: utils.widgetShimmerColor,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 15,
                            width: MediaQuery.of(context).size.width,
                            color: utils.widgetShimmerColor,
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
