import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Container(
        height: 160,
        width: MediaQuery.of(context).size.width * .8,
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
                    height: 140,
                    width: 140,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: const Color(0xfff6f5f1),
                        borderRadius: BorderRadius.circular(5)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 120,
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
                        border: Border.all(
                            color: const Color(0xffed6767), width: .5),
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 251, 196, 192)
                            .withOpacity(.2),
                      ),
                      child: Container(
                        height: 20,
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
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.7,
                        color: utils.widgetShimmerColor,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
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
