import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../res/apps_color.dart';
import '../res/apps_text_style.dart';

import '../res/routes/routes_name.dart';
import 'app_button.dart';
import 'product_image_widget.dart';

/// **ProductWidget**
/// Displays a product card with image, price, and navigation options.
class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get Product Model by Provider
    final product = Provider.of<ProductModel>(context);
    // Main structure of the product widget with tap handling
    return InkWell(
      onTap: () => _navigateToPage(product),
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image Section
            ProductImageWidget(
              imageHeight: 90,
              productModel: product,
              height: 100,
            ),
            // Expanded section to fit product info
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: _buildProductInfoSection(product),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Builds the product's information section with name, price, and action button.
  Column _buildProductInfoSection(ProductModel productModel) {
    // Calculate the discounted price of the product
    String productPrice = AppsFunction.getDiscountedPrice(
            productModel.productprice!, productModel.discount!.toDouble())
        .toStringAsFixed(2);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Display discounted price with red color
            Text(
              "${AppStrings.currencyIcon} $productPrice",
              style: AppsTextStyle.largeBold.copyWith(color: AppColors.red),
            ),
            AppsFunction.horizontalSpacing(15),
            // Display the original price with a line-through style
            Text(
              productModel.productprice!.toString(),
              style: AppsTextStyle.lineThroughText,
            ),
          ],
        ),
        AppsFunction.verticalSpacing(2),

        /// Product Name
        Text(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          productModel.productname!,
          style: AppsTextStyle.mediumBoldText,
        ),
        AppsFunction.verticalSpacing(5),
        AppButton(
          onPressed: () => _navigateToPage(productModel, true),
          title: AppStrings.btnUpdate,
        ),
        AppsFunction.verticalSpacing(5)
      ],
    );
  }

  /// Handles navigation based on the action (view details or update).
  void _navigateToPage(ProductModel productModel, [bool isUpdate = false]) {
    final routeName = isUpdate
        ? RoutesName.uploadAndUpdateProduct
        : RoutesName.productDetails;
    Get.toNamed(routeName, arguments: {
      AppStrings.productModelArgument: productModel,
      if (isUpdate) AppStrings.isUpdateArgument: true,
    });
  }
}

/*
# Understand this
void _navigateToPage(ProductModel productModel, [bool isUpdate = false]) {
    final routeName = isUpdate
        ? RoutesName.uploadAndUpdateProduct
        : RoutesName.productDetails;
    Get.toNamed(routeName, arguments: {
      AppStrings.productModel: productModel,
      if (isUpdate) AppStrings.isUpdate: true,
    });

    #: 
*/