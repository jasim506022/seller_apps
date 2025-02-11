import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../model/product_model.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/product_image_widget.dart';

class OrderProductWidget extends StatelessWidget {
  const OrderProductWidget({super.key, required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    return Container(
      height: 110.h,
      width: 0.9.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImageWidget(
            height: 100,
            width: 120,
            imageHeight: 110,
            productModel: productModel,
          ),
          Expanded(child: _buildProductDetails(context, productModel)),
        ],
      ),
    );
  }

  Padding _buildProductDetails(
      BuildContext context, ProductModel productModel) {
    final discountedPrice = AppsFunction.getDiscountedPrice(
      productModel.productprice!,
      productModel.discount!.toDouble(),
    );

    final totalPrice = AppsFunction.calculateTotalPriceWithQuantity(
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
          FittedBox(
            child: Text(
              productModel.productname!,
              style: AppsTextStyle.largeBoldText,
            ),
          ),
          Row(
            children: [
              Text(productModel.productunit!,
                  style: AppsTextStyle.mediumBoldText.copyWith(
                    color: Theme.of(context).hintColor,
                  )),
            ],
          ),
          Row(
            children: [
              Text("$quantity × $discountedPrice",
                  style: AppsTextStyle.mediumNormalText
                      .copyWith(color: AppColors.green)),
              const Spacer(),
              Text("= ${AppString.currencyIcon} $totalPrice",
                  style: AppsTextStyle.largeBoldText
                      .copyWith(color: AppColors.green)),
            ],
          ),
        ],
      ),
    );
  }
}
