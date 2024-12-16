import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../model/productsmodel.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/internet_utilis.dart';
import '../../../res/routes/routes_name.dart';

class SimilarProductWidget extends StatelessWidget {
  const SimilarProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);

    return InkWell(
      onTap: () async {
        if (!(await NetworkUtili.verifyInternetStatus())) {
          Get.offAndToNamed(
            RoutesName.detailsPage,
            arguments: {"productModel": productModel},
          );
        }
      },
      child: Container(
        height: 150.h,
        width: 100.w,
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
            SizedBox(
              height: 8.h,
            ),
            FittedBox(
                child: Text(productModel.productname!,
                    textAlign: TextAlign.justify,
                    style: AppsTextStyle.rattingText
                        .copyWith(color: Theme.of(context).primaryColor))),
          ],
        ),
      ),
    );
  }
}
