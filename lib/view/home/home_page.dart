import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import '../../res/app_asset/image_asset.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../res/apps_color.dart';
import '../../res/apps_text_style.dart';
import '../../res/routes/routes_name.dart';

import '../../res/utils.dart';
import 'widget/grid_view_item.dart';
import 'widget/grid_view_list_widget.dart';
import 'widget/home_profile_header_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    _setStatusBar();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                height: 1.sh, width: 1.sw, color: ThemeUtils.backgroundColor),
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
                      AppsFunction.verticalSpace(10),
                      const HomeProfileHeaderWidget(),
                      AppsFunction.verticalSpace(10),
                      _buildSearchProduct(context),
                      AppsFunction.verticalSpace(20),
                      _buildUploadProductButton(),
                      AppsFunction.verticalSpace(15),
                      const Expanded(child: DashboardGridView()),
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

  void _setStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.green,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light));
  }

  SizedBox _buildUploadProductButton() {
    return SizedBox(
      height: 153.h,
      width: 1.sw,
      child: GridViewItem(
        image: ImagesAsset.uploadProductImage,
        label: AppString.uploadYourProduct,
        onTap: () async {
          Get.toNamed(RoutesName.uploadAndUpdateProduct);
        },
      ),
    );
  }

  InkWell _buildSearchProduct(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.offAndToNamed(RoutesName.mainPage, arguments: 2);
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
              AppsFunction.horizontalSpace(20)
            ],
          ),
        ),
      ),
    );
  }
}
