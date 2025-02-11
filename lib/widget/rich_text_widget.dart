import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../res/apps_color.dart';
import '../res/apps_text_style.dart';
import '../res/network_utilis.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.simpleText,
    required this.colorText,
    required this.tap,
  });

  final String simpleText;
  final String colorText;
  final VoidCallback tap;
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: simpleText,
        style: AppsTextStyle.mediumBoldText,
      ),
      TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              await NetworkUtils.executeWithInternetCheck(action: tap);
            },
          text: colorText,
          style: AppsTextStyle.buttonTextStyle.copyWith(
              decoration: TextDecoration.underline, color: AppColors.green))
    ]));
  }
}
