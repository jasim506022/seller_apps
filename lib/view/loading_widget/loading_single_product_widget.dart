import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/app_function.dart';

import '../../widget/defaul_shimmer_widget.dart';

/// A shimmer loading effect for a single product placeholder.
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
            AppsFunction.shimmerPlaceholder(height: 130, width: 130),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(3, (_) {
                    return AppsFunction.shimmerPlaceholder(
                        height: 15); // Shimmer for text lines
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
