import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seller_apps/res/app_function.dart';
import 'package:seller_apps/res/app_string.dart';

import '../../../controller/search_controller.dart';
import '../../../res/app_constants.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/custom_round_action_button_widget.dart';
import '../../../widget/custom_drop_down_widget.dart';
import 'product_price_box_widget.dart';

class FilterDialogContentWidget extends StatelessWidget {
  const FilterDialogContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.find<ProductSearchController>();
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(),
          AppsFunction.verticalSpace(10),
          const ProductPriceBoxWidget(),
          AppsFunction.verticalSpace(10),
          _buildCategoryDropdown(searchController),
          AppsFunction.verticalSpace(10),
          _buildActionButtons(context, searchController),
        ],
      ),
    );
  }

  /// Builds the title section for the dialog.
  Widget _buildTitle() {
    return Center(
      child: Text(
        AppString.filterSearch,
        style: AppsTextStyle.titleTextStyle.copyWith(color: AppColors.green),
      ),
    );
  }

  /// Builds the category dropdown section.
  Widget _buildCategoryDropdown(ProductSearchController searchController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppString.productCategory, style: AppsTextStyle.mediumBoldText),
        AppsFunction.verticalSpace(10),
        CustomDropdownWidget(
          value: searchController.selectedCategory.value,
          items: AppConstants.allCategories,
          onChanged: (category) {
            if (category != null) {
              searchController.selectCategory(category);
            }
          },
        ),
      ],
    );
  }

  /// Builds the action buttons section.
  Widget _buildActionButtons(
      BuildContext context, ProductSearchController searchController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            searchController.initializeDefaults();
            Get.back();
            FocusScope.of(context).unfocus();
          },
          child: Text(
            AppString.reset,
            style: AppsTextStyle.largeBoldText.copyWith(color: AppColors.red),
          ),
        ),
        Row(
          children: [
            CustomRoundActionButtonWidget(
              horizontal: 10.w,
              title: AppString.close,
              onTap: () {
                Get.back();
                FocusScope.of(context).unfocus();
              },
            ),
            SizedBox(width: 10.w),
            CustomRoundActionButtonWidget(
              horizontal: 10.w,
              title: AppString.save,
              onTap: () {
                searchController.applyFilters();
                FocusScope.of(context).unfocus();
              },
            ),
          ],
        ),
      ],
    );
  }
}
