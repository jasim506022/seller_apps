import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seller_apps/res/network_utilis.dart';

import '../../../res/app_function.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';

/// **GridView Item**
/// A reusable widget that displays an item in a grid with an image, label, and a tap action.
/// The tap action is wrapped with a network check to ensure the device has internet connectivity.
class GridItemWidet extends StatelessWidget {
  const GridItemWidet({
    super.key,
    required this.image,
    required this.label,
    required this.onTap,
  });
  final String image;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Execute the provided function only if there's internet connectivity
      onTap: () async =>
          await NetworkUtils.executeWithInternetCheck(action: onTap),
      child: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display the image with specified dimensions and color tint
              Image.asset(image,
                  height: 70.h, width: 70.h, color: AppColors.green),
              AppsFunction.verticalSpacing(10),
              Text(
                label,
                style: AppsTextStyle.gridTitleText,
                textAlign: TextAlign.center,
              )
            ],
          )),
    );
  }
}
