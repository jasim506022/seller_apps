import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../model/productsmodel.dart';
import '../res/app_function.dart';
import 'product_controller.dart';

class SearchControllers extends GetxController {
  var productController = Get.find<ProductController>();

// Text editing controllers for price filtering and search input
  TextEditingController minPriceTEC = TextEditingController(text: "0.0");
  TextEditingController maxPriceTEC = TextEditingController(text: "10000.0");
  TextEditingController searchTextTEC = TextEditingController();

  // Observables for category selection, product lists, and flags
  var selectedCategory = "All".obs;

  var allProductList = <ProductModel>[].obs;
  var searchProductList = <ProductModel>[].obs;
  var filterProductList = <ProductModel>[].obs;

  var isSearchEnabled = false.obs;
  var isFilterEnabled = false.obs;

  @override
  void onInit() {
    searchTextTEC.text = "";
    super.onInit();
  }

  void setCategory(String category) => selectedCategory.value = category;

  void updateProductList(String text) {
    searchProductList.clear();

    var searchText = text.toLowerCase();

    final productListToSearch =
        isFilterEnabled.value ? filterProductList : allProductList;

    searchProductList.addAll(productListToSearch.where((productModel) =>
        productModel.productname!.toLowerCase().contains(searchText)));

    isSearchEnabled.value = true;
  }

  void applyPriceFilter() {
    filterProductList.clear();

    double minPrice = double.parse(minPriceTEC.text);
    double maxPrice = double.parse(maxPriceTEC.text);

    filterProductList.addAll(allProductList.where((productModel) {
      final double effectivePrice = AppsFunction.productPrice(
        productModel.productprice!,
        productModel.discount!.toDouble(),
      );
      return effectivePrice >= minPrice && effectivePrice <= maxPrice;
    }));

    isFilterEnabled.value = true;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots() {
    try {
      return productController.repository
          .productSnapshots(category: selectedCategory.value);
    } catch (e) {
      if (e is AppException) {
        // AppsFunction.errorDialog(
        //     icon: IconAsset.warningIcon,
        //     title: e.title!,
        //     content: e.message,
        //     buttonText: "Okay");
      }
      rethrow;
    }
  }
}
