import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../const/const.dart';
import '../const/utils.dart';
import '../const/gobalcolor.dart';

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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .73,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          color: Theme.of(context).cardColor,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            color: Theme.of(context).cardColor,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Shimmer.fromColors(
              baseColor: utils.baseShimmerColor,
              highlightColor: utils.highlightShimmerColor,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: mq.height * .145,
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
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: red, width: .5),
                            borderRadius: BorderRadius.circular(15),
                            color: utils.widgetShimmerColor,
                          ),
                          child: Container(
                            height: 25,
                            width: 25,
                            color: utils.widgetShimmerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: mq.height * 0.025,
                          width: mq.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: utils.widgetShimmerColor,
                          ),
                        ),
                        SizedBox(height: mq.height * 0.02),
                        Container(
                          height: mq.height * 0.025,
                          width: mq.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: utils.widgetShimmerColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: mq.height * 0.05,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: utils.widgetShimmerColor,
                          ),
                        ),
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
