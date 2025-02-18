import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../res/utils.dart';

/// A customizable shimmer widget with optional padding and card wrapper.
class DefaultShimmerWidget extends StatelessWidget {
  const DefaultShimmerWidget(
      {super.key,
      this.padding,
      this.height,
      required this.widget,
      this.useCard = true,
      this.width});

  final double? padding;
  final double? height;
  final double? width;
  final Widget widget;
  final bool useCard;

  @override
  Widget build(BuildContext context) {
    // Define shimmer content with default size values if not provided
    Widget shimmerContent = SizedBox(
      height: height?.h ?? 1.sh,
      width: width?.w ?? 1.sw,
      child: Shimmer.fromColors(
          baseColor: ThemeUtils.shimmerBaseColor,
          highlightColor: ThemeUtils.shimmerHighlightColor,
          child: widget),
    );

// Return the shimmer content, optionally wrapped in a Card widget
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding?.w ?? 0),
      // If `useCard` is true, wrap with Card:- // Otherwise, return the shimmer widget directly
      child: useCard ? Card(child: shimmerContent) : shimmerContent,
    );
  }
}
