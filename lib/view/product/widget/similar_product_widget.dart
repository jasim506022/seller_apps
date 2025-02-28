import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../model/product_model.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/network_utilis.dart';
import '../../../res/routes/routes_name.dart';

/// **SimilarProductCard**
/// Displays a single product in the "Similar Products" list.
/// Tapping it navigates to the Product Details page.
class SimilarProductCard extends StatelessWidget {
  const SimilarProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);

    return InkWell(
      onTap: () async {
        // Check Internet before navigating
        NetworkUtils.executeWithInternetCheck(action: () {
          Get.offAndToNamed(
            RoutesName.productDetails,
            arguments: {AppStrings.productModelArgument: productModel},
          );
        });
      },
      child: Card(
        child: Container(
          height: 160.h,
          width: 120.w,
          padding: EdgeInsets.all(10.r),
          margin: EdgeInsets.only(left: 15.w),
          color: Theme.of(context).cardColor,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: FancyShimmerImage(
                  height: 80.h,
                  boxFit: BoxFit.fill,
                  imageUrl: productModel.productimage![0],
                ),
              ),
              AppsFunction.verticalSpacing(10),
              // Display the product name, truncating if it's too long
              Text(productModel.productname!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppsTextStyle.ratingText
                      .copyWith(color: Theme.of(context).primaryColor)),
            ],
          ),
        ),
      ),
    );
  }
}
