import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/widget/drop_down_category_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/const.dart';

import '../../const/global.dart';
import '../../const/utils.dart';
import '../../controller/category_controller.dart';
import '../../controller/product_controller.dart';
import '../../res/app_asset/image_asset.dart';
import '../../res/app_function.dart';
import '../../service/database/firebasedatabase.dart';
import '../../model/productsmodel.dart';
import '../../service/provider/dropvalueselectallprovider.dart';
import '../../widget/empty_widget.dart';
import '../../widget/product_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<CateoryDropValueProvider>(context, listen: false)
          .setDroupValue(selectValue: allCategoryList.first);
    });
    super.initState();
  }

  final categoryController = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Products",
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            DropdownCategoryWidget(
              list: allCategoryList,
              value: categoryController.getCategory,
              onChangeds: (value) {
                categoryController.setCategory(category: value!.toString());
              },
            ),
            const Expanded(child: ProductListWidget())
          ],
        ),
      ),
    );
  }
}

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var productController = Get.put(ProductController());
    return Obx(() => StreamBuilder(
          stream: productController.allProductListSnapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingListProductWidget();
            }
            if (!snapshot.hasData ||
                snapshot.data!.docs.isEmpty ||
                snapshot.hasError) {
              return EmptyWidget(
                image: ImagesAsset.appLogoImage, //ImagesAsset.error
                title: snapshot.hasError
                    ? 'Error Occure: ${snapshot.error}'
                    : 'No Data Available',
              );
            }
            if (snapshot.hasData) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .76, //78
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  ProductModel productModel =
                      ProductModel.fromMap(snapshot.data!.docs[index].data());
                  return ChangeNotifierProvider.value(
                    value: productModel,
                    child: const ProductWidget(),
                  );
                },
              );
            }
            return const LoadingListProductWidget();
          },
        ));
  }
}

class LoadingListProductWidget extends StatelessWidget {
  const LoadingListProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .76,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8),
      itemCount: 20,
      itemBuilder: (context, index) {
        return const LoadingProductWidget();
      },
    );
  }
}

class LoadingProductWidget extends StatelessWidget {
  const LoadingProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Container(
        color: Theme.of(context).cardColor,
        height: 1.sh,
        width: .1.sw,
        child: Shimmer.fromColors(
          baseColor: utils.baseShimmerColor,
          highlightColor: utils.highlightShimmerColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppsFunction.lineShimmer(utils, 135.h),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppsFunction.lineShimmer(utils, 15.h),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppsFunction.lineShimmer(utils, 15.h),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppsFunction.lineShimmer(utils, 15.h),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
