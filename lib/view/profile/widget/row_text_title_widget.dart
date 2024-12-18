import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/apps_text_style.dart';

class RowTextTitleWidget extends StatelessWidget {
  const RowTextTitleWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(title, style: AppsTextStyle.largeBoldText)
      ],
    );
  }
}
