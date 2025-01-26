import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/search_controller.dart';
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
        Text('Product Price', style: AppsTextStyle.mediumBoldText),
        Row(
          children: [
            Expanded(
                child: TextFormFieldWidget(
                    hintText: "Minium",
                    controller: searchController.minPriceTEC)),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              child: TextFormFieldWidget(
                  controller: searchController.maxPriceTEC,
                  hintText: "Maximum"),
            ),
          ],
        ),
      ],
    );
  }
}
