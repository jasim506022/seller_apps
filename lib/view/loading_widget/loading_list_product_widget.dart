import 'package:flutter/material.dart';
import 'package:seller_apps/res/app_function.dart';

import 'loading_product_widget.dart';

class LoadingListProductWidget extends StatelessWidget {
  const LoadingListProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: AppsFunction.buildGridDelegate(),
      itemCount: 20,
      itemBuilder: (context, index) {
        return const LoadingProductWidget();
      },
    );
  }
}
