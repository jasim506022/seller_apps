import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../res/app_string.dart';
import '../../../res/utils.dart';
import '../../../controller/product_search_controller.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/custom_text_form_field.dart';
import 'product_filter_dialog.dart';

/// **ProductSearchBar**
/// Provides a search input field and a filter button for product searches.
class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductSearchController searchController =
        Get.find<ProductSearchController>();
    return SizedBox(
      height: 85.h,
      width: 1.sw,
      child: Row(
        children: [
          Expanded(flex: 4, child: _buildSearchField(searchController)),
          AppsFunction.horizontalSpacing(8),
          _buildFilterButton()
        ],
      ),
    );
  }

  /// **buildSearchField**
  /// Creates the search input field.
  Widget _buildSearchField(ProductSearchController searchController) {
    return CustomTextFormField(
        hintText: AppStrings.minimumHint,
        style: AppsTextStyle.mediumNormalText
            .copyWith(color: ThemeUtils.baseTextColor),
        decoration:
            AppsFunction.inputDecoration(hint: AppStrings.searchProductHint),
        controller: searchController.searchTextTEC,
        onChanged: searchController.searchProducts);
  }

  /// Builds the filter button, which opens the filter dialog.
  IconButton _buildFilterButton() {
    return IconButton(
        onPressed: () => Get.dialog(const ProductFilterDialog()),
        icon: const Icon(
          FontAwesomeIcons.sliders,
          color: AppColors.green,
        ));
  }
}

/*

_buildSearchField → buildSearchField (Remove underscore since it's used within a stateless
Why onChanged: searchController.searchProducts, // Directly passing function reference
*/