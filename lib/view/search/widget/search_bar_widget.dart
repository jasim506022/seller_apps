import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../res/app_string.dart';
import '../../../res/utils.dart';
import '../../../controller/search_controller.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/text_field_form_widget.dart';
import 'filter_dialog_widget.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.1.sh,
      width: 1.sw,
      child: Row(
        children: [_buildSearchField(), _buildFilterButton(context)],
      ),
    );
  }

  /// Builds the filter button.
  IconButton _buildFilterButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          Get.dialog(const FilterDialogWidget());
        },
        icon: const Icon(
          FontAwesomeIcons.sliders,
          color: AppColors.green,
        ));
  }

  /// Builds the search input field.
  Flexible _buildSearchField() {
    var searchController = Get.find<ProductSearchController>();
    return Flexible(
        flex: 4,
        child: TextFormFieldWidget(
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
        ));
  }
}
