import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controller/add_product_controller.dart';
import '../../model/productsmodel.dart';

import 'widget/add_product_widget.dart';
import 'widget/detault_add_proudct_widget.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({
    super.key,
    //  this.isUpdate = false, this.productModel
  });

  // bool? isUpdate;
  // ProductModel? productModel;

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  late bool isUpdate;
  var addProductController = Get.put(AddProductController());
  late ProductModel productModel;
  @override
  void initState() {
    var data = Get.arguments;

    // isUpdate = data == null ? false : data["isUpdate"] ?? false;
    // Understand the code

    isUpdate = data?["isUpdate"] ?? false;

    if (isUpdate) {
      productModel = data?["productModel"];
      _populateProductFields(productModel);
    }

    super.initState();
  }

  // Populate fields in the controller for updating a product
  void _populateProductFields(ProductModel model) {
    addProductController.productModel.value = model;
    addProductController.productId = model.productId ?? "";

    addProductController.nameTEC.text = model.productname ?? "";
    addProductController.priceTEC.text = model.productprice?.toString() ?? "";
    addProductController.ratingTEC.text = model.productrating?.toString() ?? "";
    addProductController.descriptionTEC.text = model.productdescription ?? "";
    addProductController.discountTEC.text = model.discount?.toString() ?? "";

    addProductController.categoryController
      ..setCategory( model.productcategory ?? "")
      ..setUnit( model.productunit ?? "");

    // Load existing product images into the observable list
    addProductController.productImageFile.value = model.productimage ?? [];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Theme.of(context).brightness));

    return Obx(() {
      if (addProductController.productImageFile.isEmpty &&
          isUpdate == false &&
          !addProductController.isUpdateChange.value) {
        return const DetaultAddProductWidget();
      }
      return AddProductWidget(
        isUpdate: isUpdate,
      );
    });
  }
}
