import 'package:flutter/material.dart';

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
        // Product name displayed with the title text style
        Text(product.productname!, style: AppsTextStyle.titleText),
        AppsFunction.verticalSpacing(15),
        // Price section: displays the discounted price and the original price with discount percentage
        _buildPriceRow(),
        AppsFunction.verticalSpacing(15),
        Text(product.productdescription!,
            textAlign: TextAlign.justify,
            style: AppsTextStyle.mediumNormalText),
        AppsFunction.verticalSpacing(20),
        _buildRatingBar(context),
        AppsFunction.verticalSpacing(20),
      ],
    );
  }

  /// Builds a row displaying the product price, discounted price, and discount percentage
  Row _buildPriceRow() {
    String discountedPrice = AppsFunction.getDiscountedPrice(
            product.productprice!, product.discount!.toDouble())
        .toStringAsFixed(2);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Display the discounted price with currency symbol and unit
        RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: "${AppStrings.currencyIcon} $discountedPrice ",
              style: AppsTextStyle.titleText.copyWith(color: AppColors.red),
            ),
            TextSpan(
              text: product.productunit,
              style: AppsTextStyle.mediumBoldText,
            ),
          ],
        )),

        // Display the original price and discount percentage
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${AppStrings.discountLabel}: ${product.discount!}% ",
                style:
                    AppsTextStyle.mediumBoldText.copyWith(color: AppColors.red),
              ),
              WidgetSpan(child: AppsFunction.horizontalSpacing(10)),
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

  /// Builds the rating bar
  Row _buildRatingBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Icon(Icons.star, color: AppColors.yellow),
        RichText(
          text: TextSpan(
              style: AppsTextStyle.ratingText
                  .copyWith(color: Theme.of(context).primaryColor),
              children: [
                const TextSpan(text: "( "),
                TextSpan(text: product.productrating!.toString()),
                TextSpan(
                    text: " ${AppStrings.ratingLabel} ",
                    style: AppsTextStyle.ratingText),
                TextSpan(
                    text: ")",
                    style: AppsTextStyle.ratingText
                        .copyWith(color: Theme.of(context).primaryColor)),
              ]),
        ),
      ],
    );
  }
}
