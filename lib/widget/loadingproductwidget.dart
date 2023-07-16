import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingProductWidget extends StatelessWidget {
  const LoadingProductWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color baseShimmerColor = Colors.grey.shade200;
    Color highlightShimmerColor = Colors.grey.shade400;
    Color widgetShimmerColor = Colors.grey.shade100;
    Size size = MediaQuery.of(context).size;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .78,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Shimmer.fromColors(
              baseColor: baseShimmerColor,
              highlightColor: highlightShimmerColor,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 140,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color(0xfff6f5f1),
                            borderRadius: BorderRadius.circular(5)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 100,
                            width: size.width,
                            color: widgetShimmerColor,
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
                              border: Border.all(color: Colors.red, width: .5),
                              borderRadius: BorderRadius.circular(15),
                              color: widgetShimmerColor),
                          child: Container(
                            height: 25,
                            width: 25,
                            color: widgetShimmerColor,
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
                          height: size.height * 0.025,
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: widgetShimmerColor,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: size.height * 0.025,
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: widgetShimmerColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: size.height * 0.05,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: widgetShimmerColor,
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
