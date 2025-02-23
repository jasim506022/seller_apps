import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/apps_text_style.dart';

class SingleEmptyWidget extends StatelessWidget {
  const SingleEmptyWidget({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.h,
      width: .9.sw,
      child: Row(
        children: [
          Image.asset(
            image,
            height: 160.h,
            width: 160.w,
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Text(title, style: AppsTextStyle.emptyTextStyle),
          )
        ],
      ),
    );
  }
}
