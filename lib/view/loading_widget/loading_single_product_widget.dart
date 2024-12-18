import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/app_function.dart';
import '../../res/apps_color.dart';
import '../../res/utils.dart';

class LoadingSingleProductWidget extends StatelessWidget {
  const LoadingSingleProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Utils Utils = Utils(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Container(
        height: 160.h, //160
        width: .9.sw,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: AppColors.black,
                spreadRadius: .05,
              )
            ],
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20.r)),
        child: Shimmer.fromColors(
          baseColor: ThemeUtils.shimmerBaseColor,
          highlightColor: ThemeUtils.shimmerHighlightColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppsFunction.lineShimmer(130.h, 130.h),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(3, (index) {
                      return AppsFunction.lineShimmer(
                          20.h); // Shimmer for text lines
                    }),
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
