import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../res/apps_color.dart';
import '../res/apps_text_style.dart';
import '../res/network_utilis.dart';

/// A reusable widget that displays rich text with a tappable highlighted portion.
///
/// This widget is useful for displaying interactive text where part of the text
/// (e.g., "Sign up", "Learn more") is tappable and executes a function when clicked.

class RichTextWidget extends StatelessWidget {
  /// - [normalText] is the non-clickable portion of the text.
  /// - [highlightedText] is the tappable portion of the text.
  /// - [onTap] is the function executed when the highlighted text is tapped.
  const RichTextWidget({
    super.key,
    required this.normalText,
    required this.highlightedText,
    required this.onTap,
  });

  final String normalText;
  final String highlightedText;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: normalText,
        style: AppsTextStyle.mediumBoldText,
      ),
      TextSpan(
        text: " $highlightedText",
        style: AppsTextStyle.button.copyWith(
            decoration: TextDecoration.underline, color: AppColors.green),
        recognizer: TapGestureRecognizer()
          ..onTap = () async =>
              await NetworkUtils.executeWithInternetCheck(action: onTap),
      ),
    ]));
  }
}
