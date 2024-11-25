import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../const/utils.dart';
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
    var searchController = Get.find<SearchControllers>();
    Utils utils = Utils(context);
    return SizedBox(
      height: 0.1.sh,
      width: 1.sw,
      child: Row(
        children: [
          Flexible(
              flex: 4,
              child: TextFormFieldWidget(
                style: AppsTextStyle.mediumNormalText
                    .copyWith(color: utils.getColor),
                isUdateDecoration: true,
                decoration: AppsFunction.inputDecoration(
                  hint: "Search Product Here",
                ),
                controller: searchController.searchTextTEC,
                onChanged: (text) {
                  searchController.updateProductList(text);
                },
              )),
          IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Get.dialog(const FilterDialogWidget());
              },
              icon: Icon(
                FontAwesomeIcons.sliders,
                color: AppColors.greenColor,
              ))
        ],
      ),
    );
  }
}
