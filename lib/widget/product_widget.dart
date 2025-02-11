import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../res/apps_color.dart';
import '../res/apps_text_style.dart';
import '../res/network_utilis.dart';
import '../res/routes/routes_name.dart';
import 'app_button..dart';
import 'product_image_widget.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    return InkWell(
      onTap: () {
        _navigateToPage(productModel);
      },
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageWidget(
              imageHeight: 90,
              productModel: productModel,
              height: 100,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: _buildProductDetails(productModel),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _buildProductDetails(ProductModel productModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "${AppString.currencyIcon} ${AppsFunction.getDiscountedPrice(productModel.productprice!, productModel.discount!.toDouble()).toStringAsFixed(2)}",
              style: AppsTextStyle.largeCustomBoldText
                  .copyWith(color: AppColors.red),
            ),
            AppsFunction.horizontalSpace(15),
            Text(
              productModel.productprice!.toString(),
              style: AppsTextStyle.mediumTextCustom400lineThrough,
            ),
          ],
        ),
        AppsFunction.verticalSpace(2),
        Text(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          productModel.productname!,
          style: AppsTextStyle.largeBoldText,
        ),
        AppsFunction.verticalSpace(5),
        AppButton(
          onPressed: () {
            _navigateToPage(productModel, true);
          },
          title: AppString.update,
        ),
        AppsFunction.verticalSpace(5)
      ],
    );
  }

  /// Handles navigation based on the action (product details or update).
  Future<void> _navigateToPage(ProductModel productModel,
      [bool isUpdate = false]) async {
/*
    if (!(await NetworkUtili.verifyInternetStatus())) {
      final routeName = isUpdate
          ? RoutesName.uploadAndUpdateProduct
          : RoutesName.productDetails;
      Get.toNamed(routeName, arguments: {
        AppString.productModel: productModel,
        if (isUpdate) AppString.isUpdate: true,
      });

    }
    */
  }
}
