import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../controller/search_controller.dart';
import '../../../model/productsmodel.dart';
import '../../../res/app_asset/image_asset.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../widget/empty_widget.dart';
import '../../../widget/product_widget.dart';

class SearchProductGridWidget extends StatelessWidget {
  const SearchProductGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var searchController = Get.find<ProductSearchController>();
    return Obx(() {
      final productList = _getFilteredProducts(searchController);

      if (productList.isEmpty) {
        return EmptyWidget(
          image: ImagesAsset.error,
          title: AppString.noDataAvaiable,
        );
      }

      /// Builds the product grid using the filtered product list.
      return GridView.builder(
        itemCount: productList.length,
        gridDelegate: AppsFunction.buildGridDelegate(),
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: productList[index],
            child: const ProductWidget(),
          );
        },
      );
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
