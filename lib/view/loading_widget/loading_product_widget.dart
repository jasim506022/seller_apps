import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seller_apps/res/utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/app_function.dart';

class LoadingProductWidget extends StatelessWidget {
  const LoadingProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Shimmer.fromColors(
          baseColor: ThemeUtils.shimmerBaseColor,
          highlightColor: ThemeUtils.shimmerHighlightColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppsFunction.lineShimmer(135),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppsFunction.lineShimmer(15),
                      AppsFunction.verticalSpace(8),
                      AppsFunction.lineShimmer(15),
                      AppsFunction.verticalSpace(8),
                      AppsFunction.lineShimmer(15),
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
