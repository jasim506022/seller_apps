import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seller_apps/res/internet_utilis.dart';

import '../../../res/app_function.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });
  final String image;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!await NetworkUtili.verifyInternetStatus()) {
          onTap;
        }
      },
      child: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 70.h,
                width: 70.h,
                color: AppColors.green,
              ),
              AppsFunction.verticalSpace(10),
              Text(
                text,
                style: AppsTextStyle.titleTextStyle,
                textAlign: TextAlign.center,
              )
            ],
          )),
    );
  }
}
