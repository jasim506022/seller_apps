import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../model/productsmodel.dart';
import '../res/app_function.dart';
import '../res/apps_color.dart';
import '../res/apps_text_style.dart';
import '../res/routes/routes_name.dart';
import '../view/product/detailsproductpage.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);

    return InkWell(
      onTap: () async {
        if (!(await AppsFunction.verifyInternetStatus())) {
          Get.to(ProductDetailsPage(),
              arguments: {"productModel": productModel});
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => ProductDetailsPage(
          //         // productModel: productModel,
          //       ),
          //     ));
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
                  color: AppColors.white,
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
              "৳. ${AppsFunction.productPrice(productModel.productprice!, productModel.discount!.toDouble())}",
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
              if (!(await AppsFunction.verifyInternetStatus())) {
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
                color: AppColors.greenColor,
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

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({
    super.key,
    required this.productModel,
    required this.height,
    required this.width,
    required this.imageHeith,
  });
  final ProductModel productModel;
  final double height;
  final double width;
  final double imageHeith;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          margin: EdgeInsets.all(10.r),
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
              color: AppColors.cardImageBg,
              borderRadius: BorderRadius.circular(5.r)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: FancyShimmerImage(
              height: imageHeith,
              boxFit: BoxFit.contain,
              imageUrl: productModel.productimage![0],
            ),
          ),
        ),
        ProductDiscountWidget(discount: productModel.discount!),
      ],
    );
  }
}

class ProductDiscountWidget extends StatelessWidget {
  const ProductDiscountWidget({
    super.key,
    required this.discount,
  });

  final num discount;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10.w,
      top: 10.h,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.red, width: .5.w),
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.lightred.withOpacity(.2),
        ),
        child: Text(
          "$discount% Off",
          style: AppsTextStyle.smallBoldText.copyWith(
            color: AppColors.red,
          ),
        ),
      ),
    );
  }
}

/*
class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    final productModel = Provider.of<ProductModel>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(
                productModel: productModel,
              ),
            ));
      },
      child: Card(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: white,
                  spreadRadius: .08,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 0.125.sh,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: cardImageBg,
                        borderRadius: BorderRadius.circular(5)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FancyShimmerImage(
                        height: 85.h,
                        boxFit: BoxFit.contain,
                        imageUrl: productModel.productimage![0],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10.w,
                    top: 10.h,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: red, width: .5),
                        borderRadius: BorderRadius.circular(15),
                        color: lightred.withOpacity(.2),
                      ),
                      child: Text("${productModel.discount}% Off",
                          style: textstyle.mediumText600),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "৳. ${globalMethod.discountedPrice(productModel.productprice!.toDouble(), productModel.discount!.toDouble())}",
                            style: textstyle.largeText.copyWith(color: red),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            "${(productModel.productprice!)}",
                            style: Textstyle.mediumText400lineThrough,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      FittedBox(
                        child: Text(
                          productModel.productname!,
                          style: textstyle.largeText,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      InkWell(
                        onTap: () {

                          Get.toNamed(RoutesName.uploadProduct, arguments: {
                            "isUpdate": true,
                            "productModel": productModel
                          });

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => AddProductPage(
                          //           isUpdate: true, productModel: productModel),
                          //     ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: greenColor,
                          ),
                          child: Text(
                            "Edit/Update",
                            style: textstyle.largeText
                                .copyWith(color: white, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

*/