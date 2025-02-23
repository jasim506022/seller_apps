import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../model/product_model.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../widget/error_dialog_widget.dart';
import 'product_controller.dart';

/// **ProductSearchController**
/// This controller is responsible for managing the search and filtering operations
/// for products. It provides methods for applying price range filters, searching
/// products based on user input, and fetching product data from Firestore.
///
/// It also manages the state of the search and filter UI, including the selected category,
/// price range, and search text.
class ProductSearchController extends GetxController {
  // Dependencies
  final productController = Get.find<ProductController>();

// Text editing controllers for price range and search input
  final TextEditingController minPriceController =
      TextEditingController(text: "0.00");
  final TextEditingController maxPriceController =
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
    resetFilters();
    super.onInit();
  }

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    minPriceController.dispose();
    maxPriceController.dispose();
    searchTextTEC.dispose();
    super.onClose();
  }

  /// **updateProductList**: Updates the list of all products with the provided list of products.
  /// This is used when fetching products from the server or Firestore.
  void updateProductList(List<ProductModel> products) =>
      allProducts.assignAll(products); // Clean way to update the list

  /// **resetFilters**: Resets the filters to their default state, clearing the search text and resetting the price range and category.
  void resetFilters() {
    minPriceController.text = "0.00";
    maxPriceController.text = "10000.00";
    selectedCategory.value = "All";
    searchTextTEC.clear();
    isSearchActive(false);
    isFilterActive(false);
  }

  /// **searchProducts**: Searches for products that match the provided text.
  /// It compares the search text (case-insensitive) with the product name.
  /// It searches from either the filtered products (if filters are active) or all products.
  void updateSelectedCategory(String category) =>
      selectedCategory.value = category;

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

  /// **applyPriceRangeFilter**: Applies the price range filter based on the values
  /// entered in the min and max price text controllers. It filters products to show
  /// those within the specified price range, including any applicable discounts.
  void applyPriceRangeFilter() {
    final double minPrice = double.tryParse(minPriceController.text) ?? 0.00;
    final double maxPrice =
        double.tryParse(maxPriceController.text) ?? 10000.00;

    if (minPrice > maxPrice) {
      AppsFunction.flutterToast(msg: AppStrings.minPriceExceedsMaxToast);
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

  /// **applyFilters**: Applies all active filters, including clearing the search text and applying the price range filter.
  void applyFilters() {
    searchTextTEC.clear();
    applyPriceRangeFilter();
  }

  /// **fetchProductStream**: Retrieves the product data stream from Firestore for the selected category.
  /// This method uses the ProductController to fetch product data from the repository.
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchProductStream() {
    try {
      return productController.repository
          .fetchProductSnapshots(category: selectedCategory.value);
    } catch (e) {
      _handleException(e);

      rethrow;
    }
  }

  /// **_handleException**: Handles exceptions that occur during the product fetching process.
  /// It displays an error dialog with the exception details.
  void _handleException(dynamic e) {
    if (e is AppException) {
      Get.dialog(
        ErrorDialogWidget(
          icon: AppIcons.warningIcon,
          title: e.title!,
          content: e.message,
          buttonText: AppStrings.btnOkay,
        ),
      );
    }
  }
}
