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

import '../../res/utils.dart';
import 'widget/grid_view_item.dart';
import 'widget/profile_header_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.green,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light));
    return SafeArea(
      child: Scaffold(
        // stack
        body: Stack(
          children: [
            /// Background color for the entire screen
            Container(
                height: 1.sh, width: 1.sw, color: ThemeUtils.backgroundColor
                // AppColors.backgroundHomePageLight,
                ),
            //aspectRaation

            /// Top green banner with rounded corners
            AspectRatio(
              aspectRatio: 16 / 11,
              child: Container(
                height: 0.35.sh,
                width: 1.sw,
                decoration: BoxDecoration(
                  color: AppColors.green,
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
                      const ProfileHeaderWidget(),
                      SizedBox(
                        height: 10.h,
                      ),
                      _buildSearchProduct(context),
                      SizedBox(
                        height: 20.h,
                      ),
                      _buildUploadProductButton(),
                      SizedBox(
                        height: 15.h,
                      ),
                      _buildGridMenu(),
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

  Expanded _buildGridMenu() {
    return Expanded(
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
              onTap: () => Get.offAndToNamed(RoutesName.mainPage, arguments: 1),
            ),
            GridViewItem(
                image: ImagesAsset.totalsalesImages,
                text: AppString.totalSales,
                onTap: () => Get.toNamed(
                      RoutesName.totalSales,
                    )),
            GridViewItem(
              image: ImagesAsset.runningOrderImages,
              text: AppString.runningOrder,
              onTap: () => Get.toNamed(
                RoutesName.runningOrder,
              ),
            ),
            GridViewItem(
                image: ImagesAsset.completeOrderImages,
                text: AppString.completeOrder,
                onTap: () => Get.toNamed(
                      RoutesName.completeOrderPage,
                    )),
          ],
        ),
      ),
    );
  }

  SizedBox _buildUploadProductButton() {
    return SizedBox(
      height: 0.18.sh,
      width: 1.sw,
      child: GridViewItem(
        image: ImagesAsset.uploadProductImage,
        text: AppString.uploadYourProduct,
        onTap: () {
          Get.toNamed(RoutesName.uploadProduct);
        },
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
