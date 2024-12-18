import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seller_apps/res/utils.dart';

import '../../../res/apps_text_style.dart';
import 'row_text_title_widget.dart';

class AboutDataItem extends StatelessWidget {
  final Map<String, dynamic> item;

  const AboutDataItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RowTextTitleWidget(
          icon: item['icon'] as IconData,
          title: item['label'] as String,
        ),
        SizedBox(height: 10.h),
        Container(
          width: 1.sw,
          padding: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
            color: ThemeUtils.textFieldColor, //utils.textFeildColor,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Text(
            item['value'] as String,
            style: AppsTextStyle.textFieldInputTextStyle(),
          ),
        ),
        SizedBox(height: 25.h),
      ],
    );
  }
}
