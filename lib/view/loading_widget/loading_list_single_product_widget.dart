import 'package:flutter/material.dart';

import 'loading_single_product_widget.dart';

class LoadingListSingleProductWidget extends StatelessWidget {
  const LoadingListSingleProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) => const LoadingSingleProductWidget(),
    );
  }
}