import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../model/productsmodel.dart';
import '../res/app_function.dart';
import '../res/apps_color.dart';
import '../res/apps_text_style.dart';
import '../res/internet_utilis.dart';
import '../res/routes/routes_name.dart';
import 'product_image_widget.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);

    return InkWell(
      onTap: () async {
        if (!(await NetworkUtili.verifyInternetStatus())) {
          Get.toNamed(RoutesName.detailsPage,
              arguments: {"productModel": productModel});
        }
      },
      child: Card(
        child: Container(
          height: 1.sh,
          width: 1.sw,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  spreadRadius: .08,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImageWidget(
                imageHeith: 90.h,
                productModel: productModel,
                height: 100.h,
                width: 1.sw,
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
      ),
    );
  }

  Column _buildProductDetails(
    ProductModel productModel,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "৳. ${AppsFunction.getDiscountedPrice(productModel.productprice!, productModel.discount!.toDouble())}",
              style: AppsTextStyle.largeBoldText.copyWith(color: AppColors.red),
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              "${(productModel.productprice!)}",
              style: AppsTextStyle.mediumText400lineThrough,
            ),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        FittedBox(
          child: Text(
            productModel.productname!,
            style: AppsTextStyle.largeBoldText, //15
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        InkWell(
            onTap: () async {
              if (!(await NetworkUtili.verifyInternetStatus())) {
                Get.toNamed(RoutesName.uploadProduct, arguments: {
                  "isUpdate": true,
                  "productModel": productModel
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 45.h,
              width: 1.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: AppColors.green,
              ),
              child: Text(
                "Edit/Update",
                style: AppsTextStyle.buttonTextStyle,
              ),
            )),
        SizedBox(
          height: 7.h,
        ),
      ],
    );
  }
}
