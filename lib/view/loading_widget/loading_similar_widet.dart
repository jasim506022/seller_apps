import 'package:flutter/material.dart';

import '../../res/app_function.dart';
import '../../widget/defaul_shimmer_widget.dart';

class LoadingSimilierWidget extends StatelessWidget {
  const LoadingSimilierWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return DefaultShimmerWidget(
          height: 140,
          width: 120,
          widget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AppsFunction.shimmerPlaceholder(height: 90),
                AppsFunction.verticalSpacing(10),
                AppsFunction.shimmerPlaceholder(height: 10),
                AppsFunction.verticalSpacing(10),
                AppsFunction.shimmerPlaceholder(height: 10)
              ],
            ),
          ),
        );
      },
    );
  }
}
