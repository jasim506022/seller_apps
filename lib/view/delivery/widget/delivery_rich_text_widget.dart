import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/apps_text_style.dart';

class DeliveryRichTextWidget extends StatelessWidget {
  const DeliveryRichTextWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.color,
  });

  final String title;
  final String subTitle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: AppsTextStyle.mediumBoldText,
          ),
          WidgetSpan(
              child: SizedBox(
            width: 10.w,
          )),
          TextSpan(
              text: subTitle,
              style: AppsTextStyle.mediumBoldText
                  .copyWith(color: color ?? Theme.of(context).primaryColor)),
        ],
      ),
    );
  }
}
