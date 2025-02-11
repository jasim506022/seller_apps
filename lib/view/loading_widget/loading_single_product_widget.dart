import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/app_function.dart';

import '../../widget/defaul_shimmer_widget.dart';

class LoadingSingleProductWidget extends StatelessWidget {
  const LoadingSingleProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultShimmerWidget(
      height: 130,
      padding: 15,
      widget: Padding(
        padding: EdgeInsets.all(8.r),
        child: Row(
          children: [
            AppsFunction.lineShimmer(130.h, 130.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(3, (index) {
                    return AppsFunction.lineShimmer(
                        15.h); // Shimmer for text lines
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );

/*
    Padding(
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
 
 */
  }
}
