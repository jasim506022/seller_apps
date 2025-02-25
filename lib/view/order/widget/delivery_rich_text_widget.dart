import 'package:flutter/material.dart';

import '../../../res/app_function.dart';
import '../../../res/apps_text_style.dart';

/// A widget displaying key delivery details using styled rich text.
class DeliveryRichTextWidget extends StatelessWidget {
  const DeliveryRichTextWidget({
    super.key,
    required this.title,
    required this.description,
    this.color,
  });

  final String title;
  final String description;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: title, style: AppsTextStyle.mediumBoldText),
          WidgetSpan(child: AppsFunction.horizontalSpacing(10)),
          TextSpan(
              text: description,
              style: AppsTextStyle.mediumBoldText
                  .copyWith(color: color ?? Theme.of(context).primaryColor)),
        ],
      ),
    );
  }
}
