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
import 'widget/grid_item_widget.dart';
import 'widget/dashboard_grid_widget.dart';
import 'widget/home_profile_header_stream.dart';

/// HomePage - Displays the main dashboard with profile, search, and product management options.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Set status bar color
    _configureStatusBar();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            /// Background color
            Container(
                height: 1.sh, width: 1.sw, color: ThemeUtils.backgroundColor),

            /// Green Header Background with Curved Borders
            AspectRatio(
                aspectRatio: 16 / 11,
                child: Container(
                    decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60.r),
                      bottomRight: Radius.circular(60.r)),
                ))),

            /// Main Content Section
            SingleChildScrollView(
              child: SizedBox(
                height: 1.sh,
                width: 1.sw,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    children: [
                      AppsFunction.verticalSpacing(10),

                      /// Profile Header displaying user info
                      const HomeProfileHeaderStream(),
                      AppsFunction.verticalSpacing(10),

                      /// Search Bar for product search functionality
                      _buildSearchBar(context),
                      AppsFunction.verticalSpacing(20),

                      /// Upload Product Section as a Grid Item

                      _buildUploadProductTile(),

                      AppsFunction.verticalSpacing(15),

                      /// Dashboard Grid View - Displays main dashboard options
                      const Expanded(child: DashboardGridWidget()),
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

  /// Configures the status bar appearance, setting the color and icon brightness.
  void _configureStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.green,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light));
  }

  /// Builds a tile for uploading a product, allowing users to navigate to the upload screen.
  SizedBox _buildUploadProductTile() {
    return SizedBox(
      height: 153.h,
      width: 1.sw,
      child: GridItemWidet(
          image: AppImage.uploadProductImage,
          label: AppStrings.updateProductTitle,
          onTap: () => Get.toNamed(RoutesName.uploadAndUpdateProduct)),
    );
  }

  /// Builds the search bar that navigates to the search page upon tapping.
  InkWell _buildSearchBar(BuildContext context) {
    return InkWell(
      onTap: () => Get.offAndToNamed(RoutesName.mainPage, arguments: 2),
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
              Text(AppStrings.searchHint, style: AppsTextStyle.hintText),
              const Spacer(),
              const Icon(IconlyLight.search),
              AppsFunction.horizontalSpacing(20)
            ],
          ),
        ),
      ),
    );
  }
}

/*
#: Why do we use safearea?
#: Understand Clear Stack
#: Understand AspectRatio clear
#: Why use expended

*/