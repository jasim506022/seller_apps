import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../res/app_string.dart';
import '../../res/utils.dart';
import '../../res/routes/routes_name.dart';

import '../../model/product_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/product_controller.dart';
import '../../res/app_function.dart';
import '../../res/apps_text_style.dart';
import 'widget/details_page_image_slider.dart';
import 'widget/list_similer_product_wiget.dart';
import 'widget/product_details_widget.dart';

/// Displays product details along with similar products.
class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  var productController = Get.find<ProductController>();
  late ProductModel productModel;

  @override
  void initState() {
    _initializeProductModel();
    super.initState();
  }

  /// Initializes the product model from arguments
  void _initializeProductModel() {
    final arguments = Get.arguments;
    productModel = arguments[AppStrings.productModel];
  }

  @override
  void didChangeDependencies() {
    _statusBar();
    super.didChangeDependencies();
  }

  /// Configures the status bar style
  void _statusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ThemeUtils.green300,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          Get.offAndToNamed(RoutesName.mainPage);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppsFunction.verticalSpace(20),
              DetailsPageImageSlideWithCartBridgeWidget(
                productModel: productModel,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductDetailsWidget(
                      product: productModel,
                    ),
                    Text(
                      AppStrings.similarProducts,
                      style: AppsTextStyle.titleTextStyle,
                    ),
                    AppsFunction.verticalSpace(10),
                    SimilarProductList(
                      productModel: productModel,
                    ),
                    AppsFunction.verticalSpace(20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
