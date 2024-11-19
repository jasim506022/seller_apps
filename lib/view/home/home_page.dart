import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import '../../res/app_asset/image_asset.dart';
import '../../res/app_string.dart';
import '../../res/apps_color.dart';
import '../../res/apps_text_style.dart';
import '../../res/routes/routes_name.dart';

import '../../const/gobalcolor.dart';

import 'widget/grid_view_item.dart';
import 'widget/profile_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: greenColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light));
    return SafeArea(
      child: Scaffold(
        // stack
        body: Stack(
          children: [
            Container(
              height: 1.sh,
              width: 1.sw,
              color: AppColors.backgroundLightHomePage,
            ),
            //aspectRaation

            AspectRatio(
              aspectRatio: 16 / 11,
              child: Container(
                height: 0.35.sh,
                width: 1.sw,
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60.r),
                      bottomRight: Radius.circular(60.r)),
                ),
              ),
            ),

            SingleChildScrollView(
              child: SizedBox(
                height: 1.sh,
                width: 1.sw,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      const ProfileWidget(),
                      SizedBox(
                        height: 10.h,
                      ),
                      _buildSearchProduct(context),
                      SizedBox(
                        height: 20.h,
                      ),
                      // const UploadWidget(),
                      SizedBox(
                        height: 0.18.sh,
                        width: 1.sw,
                        child: GridViewItem(
                          image: ImagesAsset.uploadProductImage,
                          text: AppString.uploadYourProduct,
                          function: () {
                            Get.toNamed(RoutesName.uploadProduct);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 1.sw,
                          child: GridView.count(
                            primary: false,
                            crossAxisSpacing: 20.w,
                            mainAxisSpacing: 15.h,
                            childAspectRatio: .95,
                            crossAxisCount: 2,
                            children: [
                              GridViewItem(
                                image: ImagesAsset.allProductImage,
                                text: AppString.allProduct,
                                function: () {
                                  Get.offAndToNamed(RoutesName.mainPage,
                                      arguments: 1);
                                },
                              ),
                              GridViewItem(
                                image: ImagesAsset.totalsalesImages,
                                text: AppString.totalSales,
                                function: () {
                                  Get.toNamed(
                                    RoutesName.totalSales,
                                  );
                                },
                              ),
                              GridViewItem(
                                image: ImagesAsset.runningOrderImages,
                                text: AppString.runningOrder,
                                function: () {
                                  Get.toNamed(
                                    RoutesName.orderPage,
                                  );
                                },
                              ),
                              GridViewItem(
                                image: ImagesAsset.completeOrderImages,
                                text: AppString.completeOrder,
                                function: () {
                                  Get.toNamed(
                                    RoutesName.completeOrderPage,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  InkWell _buildSearchProduct(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutesName.mainPage,
          arguments: 2,
        );
      },
      child: Container(
        height: 60.h,
        margin: EdgeInsets.symmetric(vertical: 15.w),
        width: 1.sw,
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(15.r)),
        child: Padding(
          padding: EdgeInsets.only(left: 25.w),
          child: Row(
            children: [
              Text(AppString.searchHint, style: AppsTextStyle.hintTextStyle),
              const Spacer(),
              const Icon(
                IconlyLight.search,
              ),
              SizedBox(
                width: 20.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
