import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../controller/product_controller.dart';
import '../../../model/product_model.dart';
import '../../../res/app_asset/image_asset.dart';
import '../../../res/app_string.dart';
import '../../../widget/single_empty_widget.dart.dart';
import '../../loading_widget/loading_similar_widet.dart';
import 'similar_product_widget.dart';

/// **SimilarProductsHorizontalList**
/// Displays a horizontally scrollable list of similar products based on the provided product.
class SimilarProductList extends StatelessWidget {
  const SimilarProductList({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    // Get the ProductController instance
    final ProductController productController = Get.find<ProductController>();
    return SizedBox(
      height: 160.h,
      width: 1.sw,
      child: StreamBuilder(
        stream: productController.fetchSimilarProductsStream(
            productModel: productModel),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingSimilierWidget();
          }
          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty ||
              snapshot.hasError) {
            return SingleEmptyWidget(
                image: AppImage.singleError,
                title: snapshot.hasError
                    ? '${AppStrings.errorOccurred} ${snapshot.error}'
                    : AppStrings.noDataAvaiableError);
          }
          if (snapshot.hasData) {
            final products = snapshot.data!.docs;
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length > 5 ? 5 : products.length,
                itemBuilder: (context, index) {
                  ProductModel productModel =
                      ProductModel.fromMap(products[index].data());
                  return ChangeNotifierProvider.value(
                    value: productModel,
                    child: const SimilarProductCard(),
                  );
                });
          }
          return const LoadingSimilierWidget();
        },
      ),
    );
  }
}
