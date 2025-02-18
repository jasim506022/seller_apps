import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/product_model.dart';
import '../res/apps_color.dart';
import 'discount_badge.dart';

/// A reusable widget for displaying a product image with a shimmer effect and an optional discount badge.
/// This widget shows the product's image and, if the product has a discount, a badge with the discount percentage.
class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({
    super.key,
    required this.productModel,
    required this.height,
    this.width,
    required this.imageHeight,
  });
  final ProductModel productModel;
  final double height;
  final double? width;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: height.h,
            width: width?.w ??
                1.sw, //If no width is provided, default to full screen width.
            alignment: Alignment.center,
            margin: EdgeInsets.all(10.r),
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
                color: AppColors.cardImageBg,
                borderRadius: BorderRadius.circular(5.r)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: FancyShimmerImage(
                  height: imageHeight.h,
                  boxFit: BoxFit.contain,
                  imageUrl: productModel.productimage![0],
                ))),
        // Displays the discount badge if the product has a discount.
        DiscountBadge(discount: productModel.discount!),
      ],
    );
  }
}
