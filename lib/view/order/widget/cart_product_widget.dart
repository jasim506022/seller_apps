import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../model/productsmodel.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/product_image_widget.dart';

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({super.key, required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    return Container(
      height: 110.h,
      width: 0.9.w,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImageWidget(
            height: 100.h,
            width: 120.w,
            imageHeith: 110.h,
            productModel: productModel,
          ),
          Expanded(
            child: _buildProductDetails(productModel, context),
          )
        ],
      ),
    );
  }

  Padding _buildProductDetails(
      ProductModel productModel, BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 20.w, right: 12.w, top: 15.h, bottom: 15.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              productModel.productname!,
              style: AppsTextStyle.largeBoldText,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Text(productModel.productunit!.toString(),
                  style: AppsTextStyle.mediumBoldText.copyWith(
                    color: Theme.of(context).hintColor,
                  )),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("$quantity * ",
                      style: AppsTextStyle.mediumNormalText
                          .copyWith(color: AppColors.green)),
                  Text(
                      "${AppsFunction.productPrice(productModel.productprice!, productModel.discount!.toDouble())}",
                      style: AppsTextStyle.mediumNormalText
                          .copyWith(color: AppColors.green)),
                ],
              ),
              const Spacer(),
              Text(
                  "= ৳. ${AppsFunction.productPriceWithQuantity(productModel.productprice!, productModel.discount!.toDouble(), quantity).toStringAsFixed(2)}",
                  style: AppsTextStyle.largeBoldText
                      .copyWith(color: AppColors.green)),
            ],
          ),
        ],
      ),
    );
  }
}
