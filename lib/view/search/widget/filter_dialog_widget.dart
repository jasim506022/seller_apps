import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/search_controller.dart';

import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/drop_down_category_widget.dart';
import '../../../widget/text_field_form_widget.dart';

class FilterDialogWidget extends StatelessWidget {
  const FilterDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = Get.find<SearchControllers>();
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).cardColor,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      content: _contentData(searchController, context),
    );
  }

  _contentData(SearchControllers searchController, BuildContext context) {
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
              textAlign: TextAlign.center,
              style: AppsTextStyle.largeBoldText
                  .copyWith(color: AppColors.deepGreen),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          _productPriceSearch(searchController),
          const SizedBox(
            height: 10,
          ),
          Text('Product Category', style: AppsTextStyle.largeBoldText),
          SizedBox(
            height: 10.h,
          ),
          DropdownCategoryWidget(
            isSearch: true,
            list: [],
            onChangeds: (category) {
              searchController.setCategory(category!);
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          _dialogButtonWidget(searchController, context)
        ],
      ),
    );
  }

  Row _dialogButtonWidget(
      SearchControllers searchController, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: () {
              searchController.isFilterEnabled.value = false;
              searchController
                ..setCategory("All")
                ..maxPriceTEC.text = "10000.0"
                ..minPriceTEC.text = "0.0";
              Get.back();
            },
            child: Text(
              "Reset",
              style: AppsTextStyle.largeBoldText.copyWith(color: AppColors.red),
            )),
        Row(
          children: [
            CustomRoundActionButton(
              horizontal: 10.w,
              title: 'Close',
              onTap: () => Get.back(),
            ),
            SizedBox(
              width: 10.w,
            ),
            CustomRoundActionButton(
              title: 'Save',
              horizontal: 10.w,
              onTap: () {
                FocusScope.of(context).unfocus();
                searchController.searchTextTEC.text = "";
                searchController.applyPriceFilter();
                Get.back();
              },
            )
          ],
        )
      ],
    );
  }

  Column _productPriceSearch(SearchControllers searchController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Product Price', style: AppsTextStyle.titleTextStyle),
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

class CustomRoundActionButton extends StatelessWidget {
  const CustomRoundActionButton({
    super.key,
    required this.title,
    required this.onTap,
    this.horizontal,
  });
  final String title;
  final VoidCallback onTap;
  final double? horizontal;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.greenColor),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
              horizontal: horizontal ?? 40.w, vertical: 12.h)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: AppsTextStyle.buttonTextStyle,
        ));
  }
}
