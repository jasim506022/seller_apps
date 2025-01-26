import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_apps/res/app_string.dart';

import '../model/productsmodel.dart';
import '../repository/add_product_repository.dart';
import '../res/app_constants.dart';
import '../res/app_function.dart';
import '../res/routes/routes_name.dart';
import '../widget/show_alert_dialog_widget.dart';
import 'category_manager_controller.dart';
import 'loading_controller.dart';

class AddProductController extends GetxController {
  // Controllers for form inputs
  TextEditingController nameTEC = TextEditingController();
  TextEditingController priceTEC = TextEditingController();
  TextEditingController ratingTEC = TextEditingController();
  TextEditingController descriptionTEC = TextEditingController();
  TextEditingController discountTEC = TextEditingController();

  // Dependencies
  AddProductRepository repository;
  final loadingController = Get.find<LoadingController>();
  final categoryController = Get.find<CategoryManagerController>();
  // var categoryController = Get.find<CategoryController>();

//Reactive Variable
  var isProductUpdated = false.obs;
  var selectedProductImagesList = <dynamic>[].obs;

  // Product metadata
  var productId = "";
  Timestamp publishDate = Timestamp.fromDate(DateTime.now());

  AddProductController({required this.repository});

  // Upload product images
  Future<void> uploadProductImage(ImageSource source) async {
    try {
      final images = await repository.captureImage(source);
      selectedProductImagesList.addAll(images);
      isProductUpdated(true);
    } catch (e) {
      AppsFunction.flutterToast(msg: AppString.imageUploadFail);
      isProductUpdated(false);
    }
  }

  // Remove product image by index
  void removeProductImageFile(int index) {
    selectedProductImagesList.removeAt(index);
  }

  /// Upload or update product
  Future<void> uploadOrUpdateProduct({required bool isUpdate}) async {
    if (selectedProductImagesList.isEmpty) {
      AppsFunction.flutterToast(msg: AppString.selectOneImage);
      return;
    }
    loadingController.setLoading(true);

    try {
      productId = isUpdate
          ? productId
          : DateTime.now().millisecondsSinceEpoch.toString();

      // Separate new images from existing ones
      List<XFile> newImages =
          selectedProductImagesList.whereType<XFile>().toList();

      List<String> existingImageUrls =
          _extractExistingImageUrls(selectedProductImagesList, isUpdate);
      // Upload new images and combine with existing URLs
      List<String> uploadedImageUrls = await repository.uploadImagesToStorage(
          imageList: newImages, productID: productId);

      if (isUpdate) uploadedImageUrls.addAll(existingImageUrls);

      // Create a new ProductModel with all product details
      ProductModel product = _buildProductModel(isUpdate, uploadedImageUrls);

      // Upload product details to Firestore
      await repository.saveProductToDatabase(
          isUpdate: isUpdate, productModel: product);
      loadingController.setLoading(false);

      // Clear loading state and navigate back
      resetInputs();
      Get.toNamed(RoutesName.mainPage, arguments: 0);
      AppsFunction.flutterToast(
          msg: isUpdate
              ? AppString.updateProductToastMessage
              : AppString.uploadProductToastMessage);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      loadingController.setLoading(false);
    }
  }

  // Populate fields in the controller for updating a product
  void updateProductsField(ProductModel model) {
    productId = model.productId!;

    nameTEC.text = model.productname!;
    priceTEC.text = model.productprice!.toString();
    ratingTEC.text = model.productrating!.toString();
    descriptionTEC.text = model.productdescription!;
    discountTEC.text = model.discount!.toString();
    publishDate = model.publishDate ?? Timestamp.fromDate(DateTime.now());
    categoryController
      ..updateCategory(model.productcategory!)
      ..updateUnit(model.productunit!);

    selectedProductImagesList.value = model.productimage!;
  }

  // Build ProductModel for uploading
  ProductModel _buildProductModel(bool isUpdate, List<String> imageUrls) {
    return ProductModel(
      productId: productId,
      sellerId: AppConstants.sharedPreference!
          .getString(AppString.uidSharedPreference),
      sellerName: AppConstants.sharedPreference!
          .getString(AppString.nameSharedPreference),
      productname: nameTEC.text.trim(),
      productcategory: categoryController.selectedCategory.value,
      productprice: double.tryParse(priceTEC.text.trim()),
      productunit: categoryController.selectedUnit.value,
      productrating: double.tryParse(ratingTEC.text.trim()),
      productdescription: descriptionTEC.text.trim(),
      publishDate: isUpdate ? publishDate : Timestamp.fromDate(DateTime.now()),
      discount: double.tryParse(discountTEC.text.trim()),
      productimage: imageUrls,
      stutus: AppString.available,
    );
  }

// Okay
  List<String> _extractExistingImageUrls(
      List<dynamic> imageList, bool isUpdate) {
    if (!isUpdate) return [];
    imageList.removeWhere((image) => image is XFile);
    return imageList.cast<String>().toList();
  }

  //okay
  void trackInputChanges() {
    for (var tec in [
      nameTEC,
      priceTEC,
      discountTEC,
      ratingTEC,
      descriptionTEC
    ]) {
      tec.addListener(() => isProductUpdated(true));
    }
  }

  // Okay
  void confirmUnsavedChangesOnBack(bool didPop) {
    if (didPop) return;

    if (isProductUpdated.value == false) {
      Get.back();
    } else {
      Get.dialog(ShowAlertDialogWidget(
        icon: Icons.question_mark_rounded,
        title: AppString.saveChanges,
        content: AppString.saveMessage,
        onYesPressed: () => Get.back(),
        onNoPressed: () {
          resetInputs();
          isProductUpdated(false);
          Get.close(2);
        },
      ));
    }
  }

// Okay
  void resetInputs() {
    for (var element in [
      nameTEC,
      priceTEC,
      discountTEC,
      ratingTEC,
      descriptionTEC
    ]) {
      element.clear;
    }
    categoryController
      ..updateCategory(AppConstants.categories.first)
      ..updateUnit(AppConstants.units.first);
    selectedProductImagesList.clear();
    isProductUpdated(false);
  }
}
