import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../res/app_function.dart';
import '../res/app_string.dart';
import '../res/apps_text_style.dart';

class PhoneNumberWidget extends StatelessWidget {
  const PhoneNumberWidget(
      {super.key,
      required this.controller,
      this.textInputAction = TextInputAction.next,
      this.style,
      this.enabled = true});

  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.phone, style: AppsTextStyle.labelTextStyle),
        AppsFunction.verticalSpacing(8),
        IntlPhoneField(
          enabled: enabled,
          textInputAction: textInputAction,
          controller: controller,
          style: style ?? AppsTextStyle.textFieldInputTextStyle(enabled),
          decoration: AppsFunction.textFormFielddecoration(
            hintText: AppStrings.phoneNumber,
            function: () {},
          ),
          languageCode: "en",
          initialCountryCode: 'BD',
        ),
      ],
    );
  }
}
