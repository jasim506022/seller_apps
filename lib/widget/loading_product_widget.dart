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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .73,
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
                      Positioned(
                        left: mq.width * .022,
                        top: mq.width * .012,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: mq.width * .018,
                              vertical: mq.height * .065),
                          decoration: BoxDecoration(
                            border: Border.all(color: red, width: .5),
                            borderRadius: BorderRadius.circular(15),
                            color: utils.widgetShimmerColor,
                          ),
                          child: Container(
                            height: mq.height * .0294,
                            width: mq.height * .0294,
                            color: utils.widgetShimmerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: mq.height * .022,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildShimmerTextContainer(utils, mq.height * 0.025),
                        SizedBox(height: mq.height * 0.02),
                        _buildShimmerTextContainer(utils, mq.height * 0.025),
                        SizedBox(height: mq.height * 0.012),
                        _buildShimmerTextContainer(utils, mq.height * 0.05),
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

  Container _buildShimmerTextContainer(Utils utils, double height) {
    return Container(
      height: height,
      width: mq.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: utils.widgetShimmerColor,
      ),
    );
  }
}
