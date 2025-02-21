import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_apps/res/app_function.dart';

import '../../../controller/product_search_controller.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/custom_text_form_field.dart';

class ProductPriceBoxWidget extends StatelessWidget {
  const ProductPriceBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var searchController = Get.find<ProductSearchController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.productPriceHint, style: AppsTextStyle.mediumBoldText),
        Row(
          children: [
            Expanded(
                child: CustomTextFormField(
                    hintText: AppStrings.minium,
                    controller: searchController.minPriceController)),
            AppsFunction.horizontalSpacing(15),
            Expanded(
              child: CustomTextFormField(
                  controller: searchController.maxPriceController,
                  hintText: AppStrings.maximum),
            ),
          ],
        ),
      ],
    );
  }
}
