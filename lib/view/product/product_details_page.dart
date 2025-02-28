import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../res/app_string.dart';
import '../../res/utils.dart';
import '../../res/routes/routes_name.dart';

import '../../model/product_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../res/app_function.dart';
import '../../res/apps_text_style.dart';
import 'widget/details_page_image_slider.dart';
import 'widget/list_similer_product_wiget.dart';
import 'widget/product_details_widget.dart';

/// A page that displays the details of a specific product, including product images,
/// description, and a list of similar products.
class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Configure the status bar style as soon as the widget is built
    _statusBar(context);

    // Extract the ProductModel from the navigation arguments
    final arguments = Get.arguments;
    final ProductModel productModel =
        arguments[AppStrings.productModelArgument];

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        // Navigate back to Product Page
        if (!didPop) {
          Get.offAndToNamed(
            RoutesName.mainPage,
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppsFunction.verticalSpacing(20),
              DetailsPageImageSlideWithCartBridgeWidget(
                  productModel: productModel),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display product details such as title, description, etc.
                    ProductDetailsWidget(product: productModel),
                    Text(
                      AppStrings.similarProductTitle,
                      style: AppsTextStyle.titleText,
                    ),
                    AppsFunction.verticalSpacing(10),
                    SimilarProductList(productModel: productModel),
                    AppsFunction.verticalSpacing(20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Configures the status bar style for the product details page.
  ///
  /// This method customizes the status bar with a green background,
  /// dark brightness, and adjusts the icon brightness based on the current theme.
  void _statusBar(BuildContext context) {
    // Enable system UI mode for manual control over system UI overlays (top and bottom).
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    // Set the system UI overlay style, including status bar color and icon brightness.
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ThemeUtils.green300,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness));
  }
}
