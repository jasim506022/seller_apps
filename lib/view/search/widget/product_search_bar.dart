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
import '../../../widget/text_field_form_widget.dart';
import 'product_filter_dialog.dart';

/// A widget that provides a search field and a filter button for product searches.
class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final searchController = Get.find<ProductSearchController>();
    return SizedBox(
      height: 0.1.sh,
      width: 1.sw,
      child: Row(
        children: [
          Expanded(flex: 4, child: _buildSearchField(searchController)),
          AppsFunction.horizontalSpace(8),
          _buildFilterButton(context)
        ],
      ),
    );
  }

  /// Builds the search input field.
  Widget _buildSearchField(ProductSearchController searchController) {
    return TextFormFieldWidget(
      style: AppsTextStyle.mediumNormalText
          .copyWith(color: ThemeUtils.baseTextColor),
      isUdateDecoration: true,
      decoration: AppsFunction.inputDecoration(
        hint: AppString.searchProductHere,
      ),
      controller: searchController.searchTextTEC,
      onChanged: (text) {
        searchController.searchProducts(text);
      },
    );
  }

  /// Builds the filter button, which opens the filter dialog.
  IconButton _buildFilterButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          Get.dialog(const ProductFilterDialog());
        },
        icon: const Icon(
          FontAwesomeIcons.sliders,
          color: AppColors.green,
        ));
  }
}

/*
When use Expendend and when use Flexable
*/