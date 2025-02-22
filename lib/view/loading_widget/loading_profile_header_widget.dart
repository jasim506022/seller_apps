import 'package:flutter/material.dart';

import '../../res/app_function.dart';

import '../../widget/defaul_shimmer_widget.dart';

/// A placeholder widget for the profile header while data is loading.
/// This widget displays a shimmer effect to indicate a loading state.
class LoadingProfileHeaderWidget extends StatelessWidget {
  const LoadingProfileHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultShimmerWidget(
      useCard: false,
      height: 60,
      widget: Row(
        children: [
          /// Circular shimmer placeholder for the profile image
          AppsFunction.shimmerPlaceholder(height: 60, isCircle: true),
          AppsFunction.horizontalSpacing(15),

          /// Column containing shimmer placeholders for name and email
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                2,
                (index) =>
                    AppsFunction.shimmerPlaceholder(height: 15, width: 280),
              ))
        ],
      ),
    );
  }
}
