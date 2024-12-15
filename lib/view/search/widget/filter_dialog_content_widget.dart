import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/search_controller.dart';
import '../../../res/app_constants.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/custom_round_action_button_widget.dart';
import '../../../widget/drop_down_category_widget.dart';
import 'product_price_box_widget.dart';

class FilterDialogContentWidget extends StatelessWidget {
  const FilterDialogContentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var searchController = Get.find<SearchControllers>();
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15.r)),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              "Filter Search",
              style: AppsTextStyle.titleTextStyle
                  .copyWith(color: AppColors.yellow),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          const ProductPriceBoxWidget(),
          SizedBox(
            height: 10.h,
          ),
          Text('Product Category', style: AppsTextStyle.mediumBoldText),
          SizedBox(
            height: 10.h,
          ),
          DropdownCategoryWidget(
            value: AppConstants.allCategoryList[0],
            list: AppConstants.allCategoryList,
            onChanged: (category) {
              searchController.setCategory(category!);
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    searchController.resetFilters();
                  },
                  child: Text(
                    "Reset",
                    style: AppsTextStyle.largeBoldText
                        .copyWith(color: AppColors.red),
                  )),
              Row(
                children: [
                  CustomRoundActionButtonWidget(
                    horizontal: 10.w,
                    title: 'Close',
                    onTap: () => Get.back(),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  CustomRoundActionButtonWidget(
                    title: 'Save',
                    horizontal: 10.w,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      searchController.applyFilters();
                    },
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
