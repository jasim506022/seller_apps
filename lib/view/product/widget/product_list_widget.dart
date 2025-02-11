import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../controller/product_controller.dart';
import '../../../model/product_model.dart';
import '../../../res/app_asset/image_asset.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../widget/empty_widget.dart';
import '../../../widget/product_widget.dart';
import '../../loading_widget/loading_list_product_widget.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    return Obx(() => StreamBuilder(
          stream: productController.productSnapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingListProductWidget();
            }
            if (!snapshot.hasData ||
                snapshot.data!.docs.isEmpty ||
                snapshot.hasError) {
              return EmptyWidget(
                image: ImagesAsset.error,
                title: snapshot.hasError
                    ? '${AppString.errorOccure}: ${snapshot.error}'
                    : AppString.noDataAvaiable,
              );
            }
            if (snapshot.hasData) {
              return _buildProductGrid(snapshot);
            }
            return const LoadingListProductWidget();
          },
        ));
  }

  /// Builds the product grid when data is available
  GridView _buildProductGrid(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: snapshot.data!.docs.length,
      gridDelegate: AppsFunction.buildGridDelegate(),
      itemBuilder: (context, index) {
        ProductModel productModel =
            ProductModel.fromMap(snapshot.data!.docs[index].data());
        return ChangeNotifierProvider.value(
          value: productModel,
          child: const ProductWidget(),
        );
      },
    );
  }
}
