import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_apps/res/routes/routes_name.dart';

import '../const/global.dart';
import '../model/productsmodel.dart';
import '../repository/add_product_repository.dart';
import '../res/app_function.dart';
import '../widget/show_alert_dialog_widget.dart';
import 'category_controller.dart';
import 'loading_controller.dart';

class AddProductController extends GetxController {
  TextEditingController nameTEC = TextEditingController();
  TextEditingController priceTEC = TextEditingController();
  TextEditingController ratingTEC = TextEditingController();
  TextEditingController descriptionTEC = TextEditingController();
  TextEditingController discountTEC = TextEditingController();

  // Dependencies
  AddProductRepository addProductRepository = AddProductRepository();
  LoadingController loadingController = Get.put(LoadingController());
  var categoryController = Get.find<CategoryController>();

//Reactive Variable
  var isUpdateChange = false.obs;
  var productModel = ProductModel().obs;
  var productImageFile = <dynamic>[].obs;

  var productId = "";

  Future<void> uploadProductImage(ImageSource source) async {
    try {
      final images = await addProductRepository.captureImage(source);
      productImageFile.addAll(images);
    } catch (e) {
      AppsFunction.flutterToast(msg: "Image upload failed. Please try again.");
    }
  }

  // Remove product image by index
  void removeProductImageFile(int index) {
    productImageFile.removeAt(index);
  }

  Future<void> uploadProduct({required bool isUpdate}) async {
    if (productImageFile.isEmpty) {
      AppsFunction.flutterToast(msg: "Please Select at least One Image");
    }

    loadingController.setLoading(true);
    try {
      if (!isUpdate) {
        productId = DateTime.now().millisecondsSinceEpoch.toString();
      }

      // Separate new images from existing ones
      List<XFile> newImages = productImageFile.whereType<XFile>().toList();
      List<String> existingImageUrls =
          _extractExistingImageUrls(productImageFile, isUpdate);

      // Upload new images and combine with existing URLs
      List<String> uploadedImageUrls =
          await addProductRepository.uploadImageStorage(imageList: newImages);
      if (isUpdate) {
        uploadedImageUrls.addAll(existingImageUrls);
      }

      // Create a new ProductModel with all product details
      ProductModel product = _buildProductModel(isUpdate, uploadedImageUrls);

      // Upload product details to Firestore
      await addProductRepository.uploadProductSnapshot(
          isUpdate: isUpdate, productModel: product);

      loadingController.setLoading(false);
      // Clear loading state and navigate back
      clearInputField();

      Get.toNamed(RoutesName.mainPage, arguments: 0);

      AppsFunction.flutterToast(
          msg: isUpdate
              ? "Succesfully update a New Product"
              : "Succesfully Upload a New Product");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Build ProductModel for uploading
  ProductModel _buildProductModel(bool isUpdate, List<String> imageUrls) {
    return ProductModel(
      productId: productId,
      sellerId: sharedPreference!.getString("uid"),
      sellerName: sharedPreference!.getString("name"),
      productname: nameTEC.text.trim(),
      productcategory: categoryController.getCategory,
      productprice: double.tryParse(priceTEC.text.trim()) ?? 0.0,
      productunit: categoryController.getUnit,
      productrating: double.tryParse(ratingTEC.text.trim()) ?? 0.0,
      productdescription: descriptionTEC.text.trim(),
      publishDate: isUpdate
          ? productModel.value.publishDate
          : Timestamp.fromDate(DateTime.now()),
      discount: double.tryParse(discountTEC.text.trim()) ?? 0.0,
      productimage: imageUrls,
      stutus: "available",
    );
  }

  List<String> _extractExistingImageUrls(
      List<dynamic> imageList, bool isUpdate) {
    if (!isUpdate) return [];
    imageList.removeWhere((image) => image is XFile);
    return imageList.cast<String>().toList();
  }

  void addChangeListener() {
    final controllers = [
      nameTEC,
      priceTEC,
      discountTEC,
      ratingTEC,
      descriptionTEC,
    ];

    for (var textField in controllers) {
      textField.addListener(() {
        isUpdateChange.value = true;
      });
    }
    if (!isUpdateChange.value) {
      isUpdateChange.value = true;
    }
  }

  void handleBackNavigaion(bool didPop) {
    if (didPop) return;

    if (isUpdateChange.value == false) {
      Get.back();
    } else {
      Get.dialog(CustomAlertDialogWidget(
        icon: Icons.question_mark_rounded,
        title: "Save Changed?",
        content: 'do you want to save change?',
        yesOnPress: () => Get.back(),
        noOnPress: () {
          clearInputField();
          isUpdateChange.value = false;
          Get.close(2);
        },
      ));
    }
  }

  void clearInputField() {
    nameTEC.clear();
    priceTEC.clear();
    discountTEC.clear();
    ratingTEC.clear();
    descriptionTEC.clear();
    categoryController
      ..setCategory(category: categoryList.first)
      ..setUnit(unit: unitList.first);
    productImageFile.value = [];
  }
}
