import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/controller/product_controller.dart';

import '../../../model/productsmodel.dart';
import '../../../res/app_asset/image_asset.dart';
import '../../../widget/single_empty_widget.dart.dart';
import '../../loading_widget/loading_similar_widet.dart';
import 'similar_product_widget.dart';

class SimilarProductList extends StatelessWidget {
  const SimilarProductList({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    var productController = Get.put(ProductController());
    return SizedBox(
      height: 150.h,
      width: 1.sw,
      child: StreamBuilder(
        stream: productController.similarProductSnapshot(
            productModel: productModel),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingSimilierWidget();
          } else if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty ||
              snapshot.hasError) {
            return SingleEmptyWidget(
              image: ImagesAsset.appLogoImage,
              title: snapshot.hasError
                  ? 'Error Occure: ${snapshot.error}'
                  : 'No Data Available',
            );
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
                    child: const SimilarProductWidget(),
                  );
                });
          }
          return const LoadingSimilierWidget();
        },
      ),
    );
  }
}
