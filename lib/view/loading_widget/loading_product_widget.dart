import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/app_function.dart';
import '../../widget/defaul_shimmer_widget.dart';

/// A shimmer effect widget that represents the loading state of a product.
class LoadingProductWidget extends StatelessWidget {
  const LoadingProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultShimmerWidget(
      widget: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppsFunction.shimmerPlaceholder(height: 135),
          ),
          Padding(
            padding: EdgeInsets.all(10.0.r),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    3,
                    (_) => Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: AppsFunction.shimmerPlaceholder(height: 15),
                        ))),
          )
        ],
      ),
    );
  }
}
