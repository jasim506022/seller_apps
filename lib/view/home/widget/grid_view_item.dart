import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seller_apps/res/apps_text_style.dart';

import '../../../res/apps_color.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem({
    super.key,
    required this.image,
    required this.text,
    required this.function,
  });
  final String image;
  final String text;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
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
                color: AppColors.greenColor,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(text, style: AppsTextStyle.titleTextStyle)
            ],
          )),
    );
  }
}
