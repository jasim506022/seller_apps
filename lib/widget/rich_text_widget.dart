import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../res/app_function.dart';
import '../res/apps_color.dart';
import '../res/apps_text_style.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.simpleText,
    required this.colorText,
    required this.function,
  });

  final String simpleText;
  final String colorText;
  final Function function;
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
              bool checkInternet = await AppsFunction.internetChecking();
              if (checkInternet) {
                AppsFunction.showNoInternetSnackbar();
              } else {
                function();
              }
            },
          text: colorText,
          style: AppsTextStyle.buttonTextStyle.copyWith(
              decoration: TextDecoration.underline,
              color: AppColors.greenColor))
    ]));
  }
}
