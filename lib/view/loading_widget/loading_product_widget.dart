import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/app_function.dart';
import '../../res/utils.dart';

class LoadingProductWidget extends StatelessWidget {
  const LoadingProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Utils Utils = Utils(context);
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Container(
        color: Theme.of(context).cardColor,
        height: 1.sh,
        width: .1.sw,
        child: Shimmer.fromColors(
          baseColor: ThemeUtils.shimmerBaseColor,
          highlightColor: ThemeUtils.shimmerHighlightColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppsFunction.lineShimmer(135.h),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppsFunction.lineShimmer(15.h),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppsFunction.lineShimmer(15.h),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppsFunction.lineShimmer(15.h),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
