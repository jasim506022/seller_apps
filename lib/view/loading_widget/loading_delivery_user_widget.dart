import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/app_function.dart';
import '../../res/utils.dart';

class DeliveryUserLoading extends StatelessWidget {
  const DeliveryUserLoading({super.key});

  @override
  Widget build(BuildContext context) {
    // Utils Utils = Utils(context);
    return Container(
        height: 0.155.sh,
        width: 1.sw,
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          child: Shimmer.fromColors(
            baseColor: ThemeUtils.shimmerBaseColor,
            highlightColor: ThemeUtils.shimmerHighlightColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppsFunction.circleShimmer(0.12.sh),
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 0; i <= 3; i++)
                          AppsFunction.lineShimmer(15.h),
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
