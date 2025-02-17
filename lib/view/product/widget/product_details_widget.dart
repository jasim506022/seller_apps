import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/product_model.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';

/// A widget that displays product details including name, description, price, and rating.
class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.productname!,
            style: AppsTextStyle.largeBoldText.copyWith(fontSize: 20.sp)),
        AppsFunction.verticalSpace(15),
        _buildPriceDetailsRow(),
        AppsFunction.verticalSpace(15),
        Text(product.productdescription!,
            textAlign: TextAlign.justify,
            style: AppsTextStyle.mediumNormalText),
        AppsFunction.verticalSpace(20),
        _buildRatingBar(context),
        AppsFunction.verticalSpace(20),
      ],
    );
  }

  /// Builds the rating bar
  Row _buildRatingBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Icon(Icons.star, color: AppColors.yellow),
        RichText(
          text: TextSpan(
              style: AppsTextStyle.rattingText.copyWith(
                color: Theme.of(context).primaryColor,
              ),
              children: [
                const TextSpan(text: "( "),
                TextSpan(text: product.productrating!.toString()),
                TextSpan(
                    text: " ${AppStrings.rating} ",
                    style: AppsTextStyle.rattingText),
                TextSpan(
                    text: ")",
                    style: AppsTextStyle.rattingText.copyWith(
                      color: Theme.of(context).primaryColor,
                    )),
              ]),
        ),
      ],
    );
  }

  /// Builds the price and discount details
  Row _buildPriceDetailsRow() {
    var productPrice = AppsFunction.getDiscountedPrice(
            product.productprice!, product.discount!.toDouble())
        .toStringAsFixed(2);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${AppStrings.currencyIcon} $productPrice ",
                style:
                    AppsTextStyle.titleTextStyle.copyWith(color: AppColors.red),
              ),
              TextSpan(
                text: product.productunit,
                style: AppsTextStyle.smallBoldText,
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${AppStrings.discount}: ${product.discount!}% ",
                style:
                    AppsTextStyle.mediumBoldText.copyWith(color: AppColors.red),
              ),
              WidgetSpan(child: AppsFunction.horizontalSpace(10)),
              TextSpan(
                text: product.productprice!.toString(),
                style: AppsTextStyle.mediumBoldText.copyWith(
                  color: AppColors.red,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
