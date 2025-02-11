import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/app_function.dart';
import '../../widget/defaul_shimmer_widget.dart';

class DeliveryUserLoading extends StatelessWidget {
  const DeliveryUserLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultShimmerWidget(
      height: 120,
      useCard: false,
      widget: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppsFunction.circleShimmer(90),
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                      List.generate(4, (index) => AppsFunction.lineShimmer(15))

                  //  [
                  //   for (int i = 0; i <= 3; i++) AppsFunction.lineShimmer(15),
                  // ],
                  ),
            ),
          )
        ],
      ),
    );

    /*
    Container(
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
  
  */
  }
}
