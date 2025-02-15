import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A customizable rounded container with an optional background color.
/// It provides a standard padding and rounded corners.
class BackgroundShapeWidget extends StatelessWidget {
  const BackgroundShapeWidget(
      {super.key, required this.child, this.backgroundColor});

  /// The widget displayed inside the container.
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10.r)),
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.w),
      child: child,
    );
  }
}


/*
#: What is different Between 1.sw and double.infinity

*/