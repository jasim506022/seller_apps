import 'package:flutter/material.dart';
import 'package:seller_apps/res/app_function.dart';

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
        AppsFunction.horizontalSpace(10),
        Text(title, style: AppsTextStyle.largeBoldText)
      ],
    );
  }
}
