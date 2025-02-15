import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../res/utils.dart';

class DefaultShimmerWidget extends StatelessWidget {
  const DefaultShimmerWidget(
      {super.key,
      this.padding,
      required this.height,
      required this.widget,
      this.useCard = true,
      this.width});

  final double? padding;
  final double height;
  final double? width;
  final Widget widget;
  final bool useCard;

  @override
  Widget build(BuildContext context) {
    Widget shimmerContent = SizedBox(
      height: height.h,
      width: width?.w ?? 1.sw,
      child: Shimmer.fromColors(
          baseColor: ThemeUtils.shimmerBaseColor,
          highlightColor: ThemeUtils.shimmerHighlightColor,
          child: widget),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding?.w ?? 0,
      ),
      child: useCard ? Card(child: shimmerContent) : shimmerContent,
    );
  }
}
