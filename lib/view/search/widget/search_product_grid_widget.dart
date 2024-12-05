import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../controller/search_controller.dart';
import '../../../model/productsmodel.dart';
import '../../../res/app_asset/image_asset.dart';
import '../../../widget/empty_widget.dart';
import '../../../widget/product_widget.dart';

class SearchProductGridWidget extends StatelessWidget {
  const SearchProductGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var searchController = Get.find<SearchControllers>();
    return Obx(() {
      final productList = _getProductList(searchController);

      if (productList.isEmpty) {
        return EmptyWidget(
          image: ImagesAsset.error,
          title: 'No Data Available',
        );
      }

      return GridView.builder(
        itemCount: productList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .78,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: productList[index],
            child: const ProductWidget(),
          );
        },
      );
    });
  }

  List<ProductModel> _getProductList(SearchControllers searchController) {
    if (searchController.isFilterEnabled.value &&
        searchController.searchTextTEC.text.isEmpty) {
      return searchController.filterProductList;
    }
    if (searchController.isSearchEnabled.value &&
        searchController.searchTextTEC.text.isNotEmpty) {
      return searchController.searchProductList;
    }
    return searchController.allProductList;
  }
}
