import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          horizontal: 10.w, vertical: 10.h),
      child: Container(
        height: 0.188.h,
        width: 0.8.w,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: black,
                spreadRadius: .05,
              )
            ],
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20.r)),
        child: Shimmer.fromColors(
          baseColor: utils.baseShimmerColor,
          highlightColor: utils.highlightShimmerColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height:0.165.h,
                    width: 0.165.h,
                    alignment: Alignment.center,
                    margin:  EdgeInsets.all(10.r),
                    padding:  EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                        color: const Color(0xfff6f5f1),
                        borderRadius: BorderRadius.circular(5.r)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        height: 0.141.sh,
                        color: utils.widgetShimmerColor,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10.w,
                    top: 10.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 8.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xffed6767), width: .5),
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 251, 196, 192)
                            .withOpacity(.2),
                      ),
                      child: Container(
                        height:20.w,
                        width: 20.w,
                        color: utils.widgetShimmerColor,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 20.w,
                      right: 10.w,
                      top: 15.h,
                      bottom: 15.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      globalMethod.buildShimmerTextContainer(
                          utils.widgetShimmerColor, 15.h),
                      SizedBox(
                        height: 1.h
                      ),
                      globalMethod.buildShimmerTextContainer(
                          utils.widgetShimmerColor, 15.h),
                      SizedBox(
                        height: 1.h,
                      ),
                      globalMethod.buildShimmerTextContainer(
                          utils.widgetShimmerColor, 15.h),
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
