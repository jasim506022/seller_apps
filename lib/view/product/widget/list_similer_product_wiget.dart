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
    var productController = Get.find<ProductController>();
    return SizedBox(
      height: 160.h,
      width: 1.sw,
      child: StreamBuilder(
        stream: productController.getSimilarProductsStream(
            productModel: productModel),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingSimilierWidget();
          } else if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty ||
              snapshot.hasError) {
            return SingleEmptyWidget(
                image: AppImage.singleError, //ImagesAsset.errorSingle,
                title: snapshot.hasError
                    ? '${AppStrings.errorOccure} ${snapshot.error}'
                    : AppStrings.noDataAvaiable);
          }
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length > 5
                    ? 5
                    : snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  ProductModel productModel =
                      ProductModel.fromMap(snapshot.data!.docs[index].data());
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

/*
#: min(5, snapshot.data!.docs.length)
*/