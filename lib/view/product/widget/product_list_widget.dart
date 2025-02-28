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

/// Displays a list of products using Firestore stream.
/// It listens to real-time updates from Firestore and updates the UI accordingly.
class ProductGridViewStream extends StatelessWidget {
  const ProductGridViewStream({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Find the CategoryManagerController using GetX
    final ProductController productController = Get.find<ProductController>();
    return Obx(() => StreamBuilder(
          /// Fetches product snapshots from Firestore using the controller.
          stream: productController.fetchProductSnapshots(),
          builder: (context, snapshot) {
            // Displays a loading indicator while waiting for data.
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingListProductWidget();
            }
            // Displays an error or empty state if no data is available or an error occurs.
            if (!snapshot.hasData ||
                snapshot.data!.docs.isEmpty ||
                snapshot.hasError) {
              return EmptyWidget(
                  image: AppImage.error,
                  title: snapshot.hasError
                      ? '${AppStrings.errorOccurred}: ${snapshot.error}'
                      : AppStrings.noDataAvaiableError);
            }
            // If data is available, build and display the product grid.
            if (snapshot.hasData) {
              return _buildProductGrid(snapshot.data!.docs);
            }
            // Default loading state fallback.
            return const LoadingListProductWidget();
          },
        ));
  }

  /// Builds the product grid when data is available.
  ///
  /// Takes a list of Firestore document snapshots and maps them to product models.
  GridView _buildProductGrid(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> productDocs) {
    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: productDocs.length,
      gridDelegate: AppsFunction.defaultProductGridDelegate(),
      itemBuilder: (context, index) {
        // Converts Firestore document data into a ProductModel instance.
        ProductModel productModel =
            ProductModel.fromMap(productDocs[index].data());
        // Provides the ProductModel instance to the ProductWidget using Provider.
        return ChangeNotifierProvider.value(
          value: productModel,
          child: const ProductWidget(),
        );
      },
    );
  }
}
