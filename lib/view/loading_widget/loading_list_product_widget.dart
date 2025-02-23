import 'package:flutter/material.dart';

import '../../res/app_function.dart';
import 'loading_product_widget.dart';

/// A widget that displays a grid of loading product placeholders.
/// This is typically used when product data is being fetched or processed.
/// It shows a grid of placeholder widgets that represent product items
class LoadingListProductWidget extends StatelessWidget {
  const LoadingListProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: AppsFunction.defaultProductGridDelegate(),
      itemCount: 20,
      itemBuilder: (context, index) {
        return const LoadingProductWidget();
      },
    );
  }
}
// Undestand ShriknWrap 
