import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/utils.dart';
import '../../res/app_function.dart';

class DeliveryUserLoading extends StatelessWidget {
  const DeliveryUserLoading({super.key});

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return Container(
        height: 0.155.sh,
        width: 1.sw,
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          child: Shimmer.fromColors(
            baseColor: utils.baseShimmerColor,
            highlightColor: utils.highlightShimmerColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppsFunction.circleShimmer(utils, 0.12.sh),
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppsFunction.lineShimmer(utils, 15.h),
                        AppsFunction.lineShimmer(utils, 15.h),
                        AppsFunction.lineShimmer(utils, 15.h),
                        AppsFunction.lineShimmer(utils, 15.h),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
