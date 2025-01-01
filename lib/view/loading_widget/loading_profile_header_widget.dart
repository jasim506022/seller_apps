
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/app_function.dart';
import '../../res/utils.dart';

class LoadingProfileHeaderWidget extends StatelessWidget {
  const LoadingProfileHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Shimmer.fromColors(
        baseColor: ThemeUtils.shimmerBaseColor,
        highlightColor: ThemeUtils.shimmerHighlightColor,
        child: Row(
          children: [
            AppsFunction.circleShimmer(60),
            AppsFunction.horizontalSpace(15),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  2,
                  (index) => AppsFunction.lineShimmer(15, 280),
                ))
          ],
        ),
      ),
    );
  }
}

