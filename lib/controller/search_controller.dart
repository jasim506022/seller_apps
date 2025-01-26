import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../model/productsmodel.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../widget/error_dialog_widget.dart';
import 'product_controller.dart';

class ProductSearchController extends GetxController {
  // Dependencies
  final productController = Get.find<ProductController>();

// Text editing controllers for price range and search input
  final TextEditingController minPriceTEC = TextEditingController(text: "0.00");
  final TextEditingController maxPriceTEC =
      TextEditingController(text: "10000.00");
  final TextEditingController searchTextTEC = TextEditingController(text: "");

  // Observables for category selection, product lists, and flags
  final RxString selectedCategory = "All".obs;
  final RxList<ProductModel> allProducts = <ProductModel>[].obs;
  final RxList<ProductModel> searchResults = <ProductModel>[].obs;
  final RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  final RxBool isSearchActive = false.obs;
  final RxBool isFilterActive = false.obs;

  @override
  void onInit() {
    initializeDefaults();
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

  void setProductList(List<ProductModel> products) {
    allProducts.assignAll(products); // Clean way to update the list
  }

  // reset to Defaults default values for controllers and observables
  void initializeDefaults() {
    minPriceTEC.text = "0.00";
    maxPriceTEC.text = "10000.00";
    selectedCategory.value = "All";
    searchTextTEC.clear();
    isSearchActive.value = false;
    isFilterActive.value = false;
  }

  // Set selected category
  void selectCategory(String category) => selectedCategory.value = category;

  // Search products based on input text
  void searchProducts(String text) {
    final searchText = text.toLowerCase();
    final productListToSearch =
        isFilterActive.value ? filteredProducts : allProducts;

    searchResults
      ..clear()
      ..addAll(productListToSearch.where((productModel) =>
          productModel.productname?.toLowerCase().contains(searchText) ??
          false));

    isSearchActive.value = true;
  }

// Apply price filter to products
  void applyPriceRangeFilter() {
    final double minPrice = double.tryParse(minPriceTEC.text) ?? 0.00;
    final double maxPrice = double.tryParse(maxPriceTEC.text) ?? 10000.00;

    if (minPrice > maxPrice) {
      AppsFunction.flutterToast(
          msg: 'Minimum price cannot exceed maximum price.');
      return;
    }

    filteredProducts.assignAll(allProducts.where((productModel) {
      final double effectivePrice = AppsFunction.getDiscountedPrice(
        productModel.productprice ?? 0.0,
        productModel.discount?.toDouble() ?? 0.0,
      );
      return effectivePrice >= minPrice && effectivePrice <= maxPrice;
    }));

    isFilterActive.value = true;
  }

  // Apply filters and close the filter dialog
  void applyFilters() {
    searchTextTEC.clear();
    applyPriceRangeFilter();
    Get.back();
  }

// Retrieve product snapshots from Firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots() {
    try {
      return productController.repository
          .productSnapshots(category: selectedCategory.value);
    } catch (e) {
      _handleException(e);

      rethrow;
    }
  }

  /// Handles exceptions by showing a dialog with error details
  void _handleException(dynamic e) {
    if (e is AppException) {
      Get.dialog(
        ErrorDialogWidget(
          icon: IconAsset.warningIcon,
          title: e.title!,
          content: e.message,
          buttonText: AppString.okay,
        ),
      );
    }
  }
}
