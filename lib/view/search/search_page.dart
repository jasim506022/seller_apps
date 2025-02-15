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
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.find<ProductSearchController>();
    return GestureDetector(
      onTap: () => FocusScope.of(context)
          .unfocus(), // Hide keyboard when tapping outside
      child: Scaffold(
        appBar: AppBar(title: Text(AppString.searchProducts)),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              const ProductSearchBar(),
              _buildProductGrid(searchController),
            ],
          ),
        ),
      ),
    );
  }

  /// **_buildProductGrid**: Displays search results or a loading indicator.
  Expanded _buildProductGrid(ProductSearchController controller) {
    var searchController = Get.find<ProductSearchController>();
    return Expanded(
        child: Obx(
      () => StreamBuilder(
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
      ),
    ));
  }
}

/*
why use final
*/