import 'package:flutter/material.dart';

import '../../controller/product_search_controller.dart';
import '../../model/product_model.dart';
import '../../res/app_string.dart';
import '../loading_widget/loading_list_product_widget.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'widget/product_search_bar.dart';
import 'widget/search_product_grid_widget.dart';

/// **SearchPage**: Displays a search bar and dynamically updates product results.
///
/// This page allows users to search for products in real time using a search bar.
/// It listens to the search query and updates the product results accordingly.
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductSearchController searchController =
        Get.find<ProductSearchController>();
    return GestureDetector(
      // Hide keyboard when tapping outside
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text(AppStrings.searchTitle)),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              const ProductSearchBar(),
              _buildSearchResults(searchController),
            ],
          ),
        ),
      ),
    );
  }

  /// **buildSearchResults**
  /// Displays search results or a loading indicator.
  ///
  /// - Uses `StreamBuilder` to listen to product updates.
  /// - Updates the product list when new data arrives.
  /// - Displays a loading indicator while fetching data
  Expanded _buildSearchResults(ProductSearchController searchController) {
    return Expanded(
        child: Obx(() => StreamBuilder(
              stream: searchController.fetchProductStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active &&
                    snapshot.hasData) {
                  searchController.updateProductList(snapshot.data!.docs
                      .map((e) => ProductModel.fromMap(e.data()))
                      .toList());

                  return const SearchProductGridWidget();
                }
                return const LoadingListProductWidget();
              },
            )));
  }
}
