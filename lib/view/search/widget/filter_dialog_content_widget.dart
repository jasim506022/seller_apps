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

/// **FilterDialogContentWidget**
/// This widget is responsible for rendering the content of the filter dialog.
/// It allows users to filter products by price range, category, and provides options to reset, save, or close the dialog.

class FilterDialogContentWidget extends StatelessWidget {
  const FilterDialogContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtain the instance of ProductSearchController using GetX for state management
    final ProductSearchController searchController =
        Get.find<ProductSearchController>();
    return Padding(
      // Add padding around the content of the filter dialog
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
        AppStrings.filterSearchTitle,
        style: AppsTextStyle.titleText.copyWith(color: AppColors.green),
      ),
    );
  }

  /// **_buildCategoryDropdown**: Builds the dropdown for selecting product categories.
  /// This section allows the user to choose from a list of categories.
  /// The selected category is stored in the `ProductSearchController`.
  Widget _buildCategoryDropdown(ProductSearchController searchController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.productCategoryTitle,
            style: AppsTextStyle.mediumBoldText),
        AppsFunction.verticalSpacing(10),
        CustomDropdownWidget(
            value: searchController.selectedCategory.value,
            items: AppConstants.allCategories,
            onChanged: (category) {
              if (category != null) {
                searchController.updateSelectedCategory(category);
              }
            })
      ],
    );
  }

  /// **_buildActionButtons**: Builds the action buttons (Reset, Close, Save).
  /// The reset button will reset the filters, the close button will close the dialog,
  /// and the save button will apply the selected filters.
  Widget _buildActionButtons(
      BuildContext context, ProductSearchController searchController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: () {
              searchController.resetFilters();
              _dismissDialogAndUnfocus(context);
            },
            child: Text(
              AppStrings.btnReset,
              style:
                  AppsTextStyle.mediumBoldText.copyWith(color: AppColors.red),
            )),
        Row(
          children: [
            _buildActionButton(
                AppStrings.btnClose, () => _dismissDialogAndUnfocus(context)),
            AppsFunction.horizontalSpacing(15),
            _buildActionButton(AppStrings.btnSave, () {
              searchController.applyFilters();
              _dismissDialogAndUnfocus(context);
            }),
          ],
        ),
      ],
    );
  }

  /// **_buildActionButton**: Creates a custom action button with a specific title and onTap behavior.
  AppButton _buildActionButton(String title, VoidCallback onTap) {
    return AppButton(width: 80, title: title, onPressed: onTap);
  }

  /// **_dismissDialogAndUnfocus**: Utility function to close the filter dialog and unfocus the keyboard.
  /// This is called when either the Close or Reset button is pressed.
  void _dismissDialogAndUnfocus(BuildContext context) {
    Get.back();
    FocusScope.of(context).unfocus();
  }
}
