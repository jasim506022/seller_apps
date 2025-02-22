import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_apps/res/app_string.dart';

import '../model/app_exception.dart';
import '../model/product_model.dart';
import '../repository/add_product_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_constants.dart';
import '../res/app_function.dart';
import '../res/routes/routes_name.dart';
import '../widget/error_dialog_widget.dart';
import '../widget/show_alert_dialog_widget.dart';
import 'category_manager_controller.dart';
import 'loading_controller.dart';

class ManageProductController extends GetxController {
  // Controllers for form inputs
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  // Dependencies
  final AddProductRepository repository;
  final LoadingController loadingController = Get.find<LoadingController>();
  final CategoryManagerController categoryController =
      Get.find<CategoryManagerController>();

//Reactive Variable
  var hasProductsChanged = false.obs;
  var selectedImagesList = <dynamic>[].obs;

  // Product metadata
  String productId = "";
  Timestamp publishDate = Timestamp.fromDate(DateTime.now());

  ManageProductController({required this.repository});

  /// Selects product images from the given source (camera or gallery).
  /// Handles errors and updates UI accordingly
  Future<void> pickProductImage(ImageSource source) async {
    try {
      // Capture images using the repository and add them to the selectedImages list
      final images = await repository.captureImage(source);
      selectedImagesList.addAll(images);
      // Indicate that product data has change
      hasProductsChanged(true);
    } catch (e) {
      AppsFunction.flutterToast(msg: AppStrings.imageUploadFailToast);
    }
  }

  /// Remove a selected image from the list based on its index.
  void removeProductImageFile(int index) {
    selectedImagesList.removeAt(index);
  }

  /// Saves the product by either uploading a new one or updating an existing product.
  /// Ensures image selection, manages loading state, and handles product storage.
  Future<void> saveProduct({required bool isUpdate}) async {
    // Ensure at least one image is selected before proceeding.
    if (selectedImagesList.isEmpty) {
      AppsFunction.flutterToast(msg: AppStrings.selectOneImageToast);
      return;
    }
    loadingController.setLoading(true);

    try {
      // Generate a product ID for new products, retain existing ID for updates.
      productId = isUpdate
          ? productId
          : DateTime.now().millisecondsSinceEpoch.toString();

      // Separate new images from existing ones.
      List<XFile> newImages = selectedImagesList.whereType<XFile>().toList();
      List<String> existingImageUrls =
          _extractExistingImageUrls(selectedImagesList, isUpdate);

      // Upload new images and combine with existing URLs
      List<String> uploadedImageUrls = await repository.uploadImagesToStorage(
          imageList: newImages, productID: productId);

      if (isUpdate) uploadedImageUrls.addAll(existingImageUrls);

      // Construct the ProductModel with all necessary details.
      ProductModel product = _buildProductModel(isUpdate, uploadedImageUrls);

      // Save product data to Firestore.
      await repository.saveProductToDatabase(
          isUpdate: isUpdate, productModel: product);
      loadingController.setLoading(false);

      // Clear loading state and navigate back
      resetProductInputs();

      Get.toNamed(RoutesName.mainPage, arguments: 0);
      AppsFunction.flutterToast(
          msg: isUpdate
              ? AppStrings.updateProductToastMessage
              : AppStrings.uploadProductToastMessage);
    } catch (e) {
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
    } finally {
      loadingController.setLoading(false);
    }
  }

  /// Populates the controller fields with product details for editing.
  /// Ensures safe data assignment and updates the UI accordingly.
  void updateProductsFields(ProductModel model) {
    productId = model.productId ?? "";
    nameController.text = model.productname ?? "";
    priceController.text = model.productprice?.toString() ?? "0.0";
    ratingController.text = model.productrating?.toString() ?? "0.0";
    descriptionController.text = model.productdescription ?? "";
    discountController.text = model.discount!.toString();
    // Set publish date, default to current date if null
    publishDate = model.publishDate ?? Timestamp.fromDate(DateTime.now());
    categoryController
      ..updateCategory(model.productcategory!)
      ..updateUnit(model.productunit!);

    // Populate selected images
    selectedImagesList.value = model.productimage ?? [];
  }

  /// Creates a ProductModel for upload or update operations.
  /// Ensures proper data handling and field validations.
  ProductModel _buildProductModel(bool isUpdate, List<String> imageUrls) {
    return ProductModel(
      productId: productId,
      sellerId: AppConstants.sharedPreference?.getString(AppStrings.prefUserId),
      sellerName:
          AppConstants.sharedPreference?.getString(AppStrings.prefUserName),
      productname: nameController.text.trim(),
      productcategory: categoryController.selectedCategory.value,
      productprice: double.tryParse(priceController.text.trim()),
      productunit: categoryController.selectedUnit.value,
      productrating: double.tryParse(ratingController.text.trim()),
      productdescription: descriptionController.text.trim(),
      publishDate: isUpdate ? publishDate : Timestamp.fromDate(DateTime.now()),
      discount: double.tryParse(discountController.text.trim()),
      productimage: imageUrls,
      stutus: AppStrings.available,
    );
  }

  /// Retrieves existing image URLs from the list while excluding new XFile objects.
  /// This ensures that only previously uploaded image links are retained.
  List<String> _extractExistingImageUrls(
      List<dynamic> imageList, bool isUpdate) {
    if (!isUpdate) return [];
    // Remove newly selected images (XFile instances) and return only URLs
    imageList.removeWhere((image) => image is XFile);
    return imageList.cast<String>().toList();
  }

  /// Tracks input changes in text fields and marks the product as changed.
  /// Ensures UI is aware of modifications for proper state management.
  void trackInputChanges() {
    for (var tec in [
      nameController,
      priceController,
      discountController,
      ratingController,
      descriptionController
    ]) {
      tec.addListener(() => hasProductsChanged(true));
    }
  }

// Handles navigation when there are unsaved product changes
  void handleUnsavedChangesOnBack(bool didPop) {
    // Prevent navigation if an upload process is still ongoing
    if (loadingController.loading.value) {
      AppsFunction.flutterToast(msg: AppStrings.toastWaitForUploadMessage);
      return;
    }
    // If navigation has already happened, do nothing
    if (didPop) return;

    // If no product updates have been made, navigate back immediately
    if (hasProductsChanged.value == false) {
      Get.back();
      return;
    }
    // Show a confirmation dialog before discarding unsaved changes
    Get.dialog(ShowAlertDialogWidget(
        icon: Icons.question_mark_rounded,
        title: AppStrings.saveChangesTitle,
        content: AppStrings.saveMessage,
        onConfirmPressed: () => Get.back(),
        onCancelPressed: () {
          resetProductInputs();
          hasProductsChanged(false);
          Get.back();
          Get.back();
        }));
  }

// Resets product-related input fields and selections
  void resetProductInputs() {
    for (var element in [
      nameController,
      priceController,
      discountController,
      ratingController,
      descriptionController
    ]) {
      element.clear;
    }
    // Reset category and unit to default values
    categoryController
      ..updateCategory(AppConstants.categories.first)
      ..updateUnit(AppConstants.units.first);
    // Clear selected product images
    selectedImagesList.clear();
    // Reset product change flag
    hasProductsChanged(false);
  }
}


/*
#: When use Is and When has?
Answer: Is Use: Use "is" when the variable represents a state, condition, or characteristic.
Has Use: Use "has" when the variable represents ownership, possession, or existence of something.
"is" when...	Use "has" when...
Describes a state or condition (adjective)	Describes possession or availability (noun)
✅ isLoading	✅ hasChanges
✅ isVisible	✅ hasError
✅ isConnected	✅ hasPermission
✅ isActive	✅ hasProducts

#: Understand All Loop

#: .. in flutter?
Answer: The cascade operator (..) in Dart (and by extension in Flutter) allows you to perform multiple operations on the same object without repeating its name.
Flexibility: Use with both non-nullable (..) and nullable (?..) objects

#: var selectedImages = <dynamic>[].obs (Descritive this Code)
#: Timestamp publishDate = Timestamp.fromDate(DateTime.now());

#: Understand Remove and RemoveAt in List
#:  List<XFile> newImages = selectedImagesList.whereType<XFile>().toList();
#: ?. Understand Clear
#: Different Between ?. !:
#: double.tryParse
#: 
imageList.removeWhere((image) => image is XFile);
    return imageList.cast<String>().toList();

#:  List<XFile> newImages = selectedImagesList.whereType<XFile>().toList();
*/