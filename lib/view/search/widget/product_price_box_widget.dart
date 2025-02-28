import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/product_search_controller.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/custom_text_form_field.dart';

/// A widget that provides input fields for entering a minimum and maximum product price.
///
/// This widget allows users to specify a price range using two text fields.
/// The values are managed by `ProductSearchController`, which handles the min and max price inputs.
class ProductPriceBoxWidget extends StatelessWidget {
  const ProductPriceBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Retrieve the ProductSearchController instance using GetX.
    final ProductSearchController searchController =
        Get.find<ProductSearchController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Displays the label for the price input section.
        Text(AppStrings.productPriceLabel, style: AppsTextStyle.mediumBoldText),
        Row(
          children: [
            /// Minimum price input field.
            Expanded(
                child: CustomTextFormField(
                    textInputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    hintText: AppStrings.minimumHint,
                    controller: searchController.minPriceController)),
            AppsFunction.horizontalSpacing(15),

            /// Maximum price input field.
            Expanded(
              child: CustomTextFormField(
                  textInputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: searchController.maxPriceController,
                  hintText: AppStrings.maximumHint),
            ),
          ],
        ),
      ],
    );
  }
}
