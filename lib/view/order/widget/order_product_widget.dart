import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../model/product_model.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/product_image_widget.dart';

/// A widget that displays a single ordered product with its details,
/// including quantity, unit, discounted price, and total price.
class OrderProductWidget extends StatelessWidget {
  const OrderProductWidget({super.key, required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    // Retrieve the product model from the provider.
    final productModel = Provider.of<ProductModel>(context, listen: false);
    return Container(
      height: 110.h,
      width: 0.9.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Displays the product image.
          ProductImageWidget(
            height: 100,
            width: 120,
            imageHeight: 110,
            productModel: productModel,
          ),
          // Displays product details such as name, unit, and pricing.
          Expanded(child: _buildProductInfo(context, productModel)),
        ],
      ),
    );
  }

  /// Builds the product information section, including:
  /// - The product name.
  /// - The unit of measurement (e.g., "1kg", "500g").
  /// - The discounted price per unit.
  /// - The total price for the given quantity.
  Padding _buildProductInfo(BuildContext context, ProductModel productModel) {
    // Calculate the discounted price per unit.
    final double discountedPrice = AppsFunction.getDiscountedPrice(
      productModel.productprice!,
      productModel.discount!.toDouble(),
    );
    // Calculate the total price for the ordered quantity.
    final String totalPrice = AppsFunction.calculateTotalPriceWithQuantity(
      productModel.productprice!,
      productModel.discount!.toDouble(),
      quantity,
    ).toStringAsFixed(2);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Displays the product name in a fitted text widget.
          FittedBox(
            child: Text(
              productModel.productname!,
              style: AppsTextStyle.mediumBoldText,
            ),
          ),
          Row(
            children: [
              // Displays the product unit (e.g., "1kg", "500g").
              Text(productModel.productunit!,
                  style: AppsTextStyle.mediumBoldText.copyWith(
                    color: Theme.of(context).hintColor,
                  )),
            ],
          ),
          // Displays the pricing details.
          Row(
            children: [
              // Displays the quantity and discounted price per unit.
              Text("$quantity × $discountedPrice",
                  style: AppsTextStyle.mediumNormalText
                      .copyWith(color: AppColors.green)),
              const Spacer(),
              // Displays the total price calculation.
              Text("= ${AppStrings.currencyIcon} $totalPrice",
                  style: AppsTextStyle.mediumBoldText
                      .copyWith(color: AppColors.green)),
            ],
          ),
        ],
      ),
    );
  }
}
