import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seller_apps/res/app_string.dart';

import '../../../controller/search_controller.dart';
import '../../../res/app_constants.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/custom_round_action_button_widget.dart';
import '../../../widget/drop_down_category_widget.dart';
import 'product_price_box_widget.dart';

class FilterDialogContentWidget extends StatelessWidget {
  const FilterDialogContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.find<SearchControllers>();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(),
          SizedBox(height: 10.h),
          const ProductPriceBoxWidget(),
          SizedBox(height: 10.h),
          _buildCategoryDropdown(searchController),
          SizedBox(height: 10.h),
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
  Widget _buildCategoryDropdown(SearchControllers searchController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppString.productCategory, style: AppsTextStyle.mediumBoldText),
        SizedBox(height: 10.h),
        DropdownCategoryWidget(
          value: AppConstants.allCategoryList[0],
          list: AppConstants.allCategoryList,
          onChanged: (category) {
            if (category != null) {
              searchController.setCategory(category);
            }
          },
        ),
      ],
    );
  }

  /// Builds the action buttons section.
  Widget _buildActionButtons(
      BuildContext context, SearchControllers searchController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: searchController.resetFilters,
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
              onTap: () => Get.back(),
            ),
            SizedBox(width: 10.w),
            CustomRoundActionButtonWidget(
              horizontal: 10.w,
              title: AppString.save,
              onTap: () {
                FocusScope.of(context).unfocus();
                searchController.applyFilters();
              },
            ),
          ],
        ),
      ],
    );
  }
}


/*
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
      padding:  EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              AppString.filterSearch,
              style:
                  AppsTextStyle.titleTextStyle.copyWith(color: AppColors.green),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          const ProductPriceBoxWidget(),
          SizedBox(
            height: 10.h,
          ),
          Text(AppString.productCategory, style: AppsTextStyle.mediumBoldText),
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
                    AppString.reset,
                    style: AppsTextStyle.largeBoldText
                        .copyWith(color: AppColors.red),
                  )),
              Row(
                children: [
                  CustomRoundActionButtonWidget(
                    horizontal: 10.w,
                    title: AppString.close,
                    onTap: () => Get.back(),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  CustomRoundActionButtonWidget(
                    title: AppString.save,
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

*/