import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../res/app_function.dart';
import '../res/app_string.dart';
import '../res/apps_text_style.dart';

/// This widget is useful for authentication forms or any UI requiring phone number input.
class PhoneNumberWidget extends StatelessWidget {
  const PhoneNumberWidget(
      {super.key,
      required this.controller,
      this.textInputAction = TextInputAction.next,
      this.textStyle,
      this.enabled = true});

  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final TextStyle? textStyle;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.phoneLabel, style: AppsTextStyle.label),
        AppsFunction.verticalSpacing(8),

        /// International phone input field.
        IntlPhoneField(
          enabled: enabled,
          textInputAction: textInputAction,
          controller: controller,
          style: textStyle ?? AppsTextStyle.inputText(enabled),

          /// Custom decoration with hint text.
          decoration: AppsFunction.textFieldInputDecoration(
            hintText: AppStrings.phoneHint,
          ),

          /// Language set to English.

          languageCode: "en",

          /// Default country code set to Bangladesh (BD).
          initialCountryCode: 'BD',
        ),
      ],
    );
  }
}


/*
 #: this.enabled = true
*/