import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/product_search_controller.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/app_button.dart';
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
          AppsFunction.verticalSpacing(10),
          const ProductPriceBoxWidget(),
          AppsFunction.verticalSpacing(10),
          _buildCategoryDropdown(searchController),
          AppsFunction.verticalSpacing(10),
          _buildActionButtons(context, searchController),
        ],
      ),
    );
  }

  /// Builds the title section for the dialog.
  Widget _buildTitle() {
    return Center(
      child: Text(
        AppStrings.filterSearch,
        style: AppsTextStyle.titleTextStyle.copyWith(color: AppColors.green),
      ),
    );
  }

  /// Builds the category dropdown section.
  Widget _buildCategoryDropdown(ProductSearchController searchController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.productCategory, style: AppsTextStyle.mediumBoldText),
        AppsFunction.verticalSpacing(10),
        CustomDropdownWidget(
          value: searchController.selectedCategory.value,
          items: AppConstants.allCategories,
          onChanged: (category) {
            if (category != null) {
              searchController.updateSelectedCategory(category);
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
            searchController.resetFilters();
            // Get.back();
            WidgetsBinding.instance.addPostFrameCallback((_) => Get.back());
            FocusScope.of(context).unfocus();
          },
          child: Text(
            AppStrings.reset,
            style: AppsTextStyle.largeBoldText.copyWith(color: AppColors.red),
          ),
        ),
        Row(
          children: [
            _buildActionButton(AppStrings.close, () {
              Get.back();
              FocusScope.of(context).unfocus();
            }),
            AppsFunction.horizontalSpacing(15),
            _buildActionButton(AppStrings.save, () {
              searchController.applyFilters();
              FocusScope.of(context).unfocus();
            }),
          ],
        ),
      ],
    );
  }

  AppButton _buildActionButton(String title, VoidCallback onTap) {
    return AppButton(width: 80, title: title, onPressed: onTap);
  }
}

/*
WidgetsBinding.instance.addPostFrameCallback((_) => Get.back()); why use this 
why sometimes onTap() work and sometimes doesn't work 
*/