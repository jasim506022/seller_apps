import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_apps/res/app_function.dart';

import '../../../controller/product_search_controller.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/text_field_form_widget.dart';

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
        Text(AppString.productPrice, style: AppsTextStyle.mediumBoldText),
        Row(
          children: [
            Expanded(
                child: TextFormFieldWidget(
                    hintText: AppString.minium,
                    controller: searchController.minPriceTEC)),
            AppsFunction.horizontalSpace(15),
            Expanded(
              child: TextFormFieldWidget(
                  controller: searchController.maxPriceTEC,
                  hintText: AppString.maximum),
            ),
          ],
        ),
      ],
    );
  }
}
