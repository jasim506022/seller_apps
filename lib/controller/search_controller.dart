import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../model/productsmodel.dart';
import '../res/app_function.dart';
import 'product_controller.dart';

class SearchControllers extends GetxController {
  // Dependencies
  final productController = Get.find<ProductController>();

  // Text editing controllers for price and search input
  final TextEditingController minPriceTEC = TextEditingController(text: "0.00");
  final TextEditingController maxPriceTEC =
      TextEditingController(text: "10000.00");
  final TextEditingController searchTextTEC = TextEditingController(text: "");

  // Observables for category selection, product lists, and flags
  final RxString selectedCategory = "All".obs;
  final RxList<ProductModel> allProductList = <ProductModel>[].obs;
  final RxList<ProductModel> searchProductList = <ProductModel>[].obs;
  final RxList<ProductModel> filterProductList = <ProductModel>[].obs;
  final RxBool isSearchEnabled = false.obs;
  final RxBool isFilterEnabled = false.obs;

  @override
  void onInit() {
    // searchTextTEC.text = "";
    // selectedCategory.value = "All";
    // minPriceTEC.text = "0.00";
    // maxPriceTEC.text = "10000.00";
    _initializeDefaults();
    super.onInit();
  }

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    minPriceTEC.dispose();
    maxPriceTEC.dispose();
    searchTextTEC.dispose();
    super.onClose();
  }

  // Initialize default values for controllers and observables
  void _initializeDefaults() {
    minPriceTEC.text = "0.00";
    maxPriceTEC.text = "10000.00";
    selectedCategory.value = "All";
  }

  // Set selected category
  void setCategory(String category) => selectedCategory.value = category;

/*
  void updateProductList(String text) {
    searchProductList.clear();

    var searchText = text.toLowerCase();

    final productListToSearch =
        isFilterEnabled.value ? filterProductList : allProductList;

    searchProductList.addAll(productListToSearch.where((productModel) =>
        productModel.productname!.toLowerCase().contains(searchText)));

    isSearchEnabled.value = true;
  }
*/
  // Update product list based on search input
  void updateProductList(String text) {
    final searchText = text.toLowerCase();
    final productListToSearch =
        isFilterEnabled.value ? filterProductList : allProductList;

    searchProductList
      ..clear()
      ..addAll(productListToSearch.where((productModel) =>
          productModel.productname?.toLowerCase().contains(searchText) ??
          false));

    isSearchEnabled.value = true;
  }

/*
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

*/

// Apply price filter to products
  void applyPriceFilter() {
    final double minPrice = double.tryParse(minPriceTEC.text) ?? 0.00;
    final double maxPrice = double.tryParse(maxPriceTEC.text) ?? 10000.00;

    filterProductList
      ..clear()
      ..addAll(allProductList.where((productModel) {
        final double effectivePrice = AppsFunction.productPrice(
          productModel.productprice ?? 0.0,
          productModel.discount?.toDouble() ?? 0.0,
        );
        return effectivePrice >= minPrice && effectivePrice <= maxPrice;
      }));

    isFilterEnabled.value = true;
  }

/*
  resetFilters() {
    isFilterEnabled.value = false;
    setCategory("All");
    maxPriceTEC.text = "10000.0";
    minPriceTEC.text = "0.0";
    Get.back();
  }


*/
  // Reset filters to default values
  void resetFilters() {
    isFilterEnabled.value = false;
    _initializeDefaults();
    Get.back();
  }

/*
  applyButton() {
    searchTextTEC.text = "";
    applyPriceFilter();
    Get.back();
  }

*/
  // Apply filters and close the filter dialog
  void applyFilters() {
    searchTextTEC.clear();
    applyPriceFilter();
    Get.back();
  }

/*
  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots() {
    try {
      return productController.repository
          .productSnapshots(category: selectedCategory.value);
    } catch (e) {
      if (e is AppException) {}
      rethrow;
    }
  }

*/
// Retrieve product snapshots from Firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots() {
    try {
      return productController.repository
          .productSnapshots(category: selectedCategory.value);
    } on AppException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Handle application-specific exceptions here
      rethrow;
    }
  }
}
