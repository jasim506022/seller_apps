import 'package:flutter/cupertino.dart';

import '../../../res/app_function.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/app_logo_widget.dart';

class AuthIntroWidget extends StatelessWidget {
  const AuthIntroWidget(
      {super.key,
      required this.title,
      required this.description,
      this.customWidget});

  final String title;
  final String description;

  final Widget? customWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppsFunction.verticalSpacing(50),
        customWidget ?? const AppLogoWidget(),
        AppsFunction.verticalSpacing(10),
        Text(title, style: AppsTextStyle.authIntroTitleTextStyle),
        AppsFunction.verticalSpacing(10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: AppsTextStyle.authIntroDescriptionTextStyle,
        ),
        AppsFunction.verticalSpacing(40),
      ],
    );
  }
}
