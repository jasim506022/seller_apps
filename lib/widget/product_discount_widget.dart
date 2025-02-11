import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seller_apps/res/app_string.dart';

import '../res/apps_color.dart';
import '../res/apps_text_style.dart';

class ProductDiscountWidget extends StatelessWidget {
  const ProductDiscountWidget({
    super.key,
    required this.discount,
  });

  final num discount;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10.w,
      top: 10.h,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.red, width: .5.w),
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.lightRed.withOpacity(.2),
        ),
        child: Text(
          "$discount% ${AppString.off}",
          style: AppsTextStyle.smallBoldText.copyWith(
            color: AppColors.red,
          ),
        ),
      ),
    );
  }
}
