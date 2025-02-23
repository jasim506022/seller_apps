import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../controller/product_search_controller.dart';
import '../../../model/product_model.dart';
import '../../../res/app_asset/image_asset.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../widget/empty_widget.dart';
import '../../../widget/product_widget.dart';

/// **SearchProductGridWidget**
/// Displays a grid of products based on search and filter criteria.
class SearchProductGridWidget extends StatelessWidget {
  const SearchProductGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductSearchController searchController =
        Get.find<ProductSearchController>();
    return Obx(() {
      // Encapsulated filtering logic in controller
      final productList = _getFilteredProducts(searchController);

      return productList.isEmpty
          ? EmptyWidget(
              image: AppImage.error,
              title: AppStrings.noDataAvaiableError,
            )

          /// Builds the product grid using the filtered product list.
          : GridView.builder(
              itemCount: productList.length,
              gridDelegate: AppsFunction.defaultProductGridDelegate(),
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: productList[index], child: const ProductWidget());
              });
    });
  }

  /// Filters the product list based on the current state of the search and filter controllers.
  List<ProductModel> _getFilteredProducts(
      ProductSearchController searchController) {
    if (searchController.isFilterActive.value &&
        searchController.searchTextTEC.text.isEmpty) {
      return searchController.filteredProducts;
    }
    if (searchController.isSearchActive.value &&
        searchController.searchTextTEC.text.isNotEmpty) {
      return searchController.searchResults;
    }
    return searchController.allProducts;
  }
}
