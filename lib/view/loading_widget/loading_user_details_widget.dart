import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/app_function.dart';
import '../../widget/defaul_shimmer_widget.dart';

/// A shimmer loading skeleton for the Delivery User section.
///
/// This widget is displayed as a placeholder while user details are being fetched.
///
/// ## Features:
/// - Displays a circular shimmer for the profile image.
/// - Shows multiple shimmering lines to simulate user information loading.
/// - Uses `DefaultShimmerWidget` to ensure consistency in the shimmer effect.
///
/// ## Example Usage:
/// ```dart
/// LoadingUserDetailsWidget()
/// ``
class LoadingUserDetailsWidget extends StatelessWidget {
  const LoadingUserDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultShimmerWidget(
      height: 120,
      useCard: false,
      widget: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Circular shimmer placeholder for profile image
          AppsFunction.shimmerPlaceholder(height: 90, isCircle: true),
          AppsFunction.horizontalSpacing(10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4,
                      (index) => AppsFunction.shimmerPlaceholder(height: 15))),
            ),
          )
        ],
      ),
    );
  }
}

/*
#: Understand List.generate

*/
