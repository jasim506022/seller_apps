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
            /*
            Consumer<CateoryDropValueProvider>(
              builder: (context, dropvaluesall, child) {
                return DropdownButtonFormField(
                  decoration:
                      globalMethod.decorationDropDownButtonForm(context),
                  value: dropvaluesall.cateoryDropValue,
                  isExpanded: true,
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                  focusColor: Theme.of(context).primaryColor,
                  elevation: 16,
                  iconEnabledColor: Theme.of(context).primaryColor,
                  items: allCategoryList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) {
                    if (kDebugMode) {
                      print(value);
                    }
                    Provider.of<CateoryDropValueProvider>(context,
                            listen: false)
                        .setDroupValue(selectValue: value!);
                  },
                );
              },
            ),
           */
            DropdownCategoryWidget(
              list: allCategoryList,
              value: categoryController.getCategory,
              onChangeds: (value) {
                categoryController.setCategory(category: value!.toString());
              },
            ),
            Expanded(child: ProductListWidget())
            /*
            Expanded(
              child: Consumer<CateoryDropValueProvider>(
                builder: (context, cateoryDropValueProvider, child) {
                  return StreamBuilder(
                    stream: FirebaseDatabase.allProductListSnapshots(
                        category: cateoryDropValueProvider.cateoryDropValue),
                    builder: (context, snapshot) {
                      try {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingProductWidget();
                        } else if (snapshot.hasData) {
                          return GridView.builder(
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: .78,
                                    crossAxisSpacing: mq.width * .009,
                                    mainAxisSpacing: mq.width * .018),
                            itemBuilder: (context, index) {
                              ProductModel productModel = ProductModel.fromMap(
                                  snapshot.data!.docs[index].data());
                              return ChangeNotifierProvider.value(
                                value: productModel,
                                child: const ProductWidget(),
                              );
                            },
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return const Text(
                            'asset/payment/emptytow.png',
                            style: TextStyle(color: Colors.black),
                          );
                        } else if (!snapshot.hasData) {
                          return const EmptyWidget(
                            image: 'asset/empty/empty.png',
                            title: 'No Data Found',
                          );
                        }
                        return const LoadingProductWidget();
                      } catch (error) {
                        return EmptyWidget(
                          image: 'asset/empty/empty.png',
                          title: 'An Error Occured: $error',
                        );
                      }
                    },
                  );
                },
              ),
            ),
          
          */
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
              return LoadingListProductWidget();
/*
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
            */
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
      physics: AlwaysScrollableScrollPhysics(),
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
