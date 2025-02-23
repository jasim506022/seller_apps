import 'package:flutter/cupertino.dart';

import '../../../res/app_function.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/app_logo_widget.dart';

/// This widget is commonly used in authentication screens (e.g., Sign In, Sign Up, Forgot Password).
class AuthIntroWidget extends StatelessWidget {
  const AuthIntroWidget(
      {super.key,
      required this.title,
      required this.description,
      this.customWidget});

  final String title;
  final String description;

  /// An optional custom widget (e.g., an image or illustration).
  /// If not provided, it defaults to `AppLogoWidget`
  final Widget? customWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppsFunction.verticalSpacing(50),

        /// Displays the custom widget if provided, otherwise shows the default app logo.
        customWidget ?? const AppLogoWidget(),
        AppsFunction.verticalSpacing(10),
        Text(title, style: AppsTextStyle.authTitle),
        AppsFunction.verticalSpacing(10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: AppsTextStyle.authDescription,
        ),
        AppsFunction.verticalSpacing(40),
      ],
    );
  }
}

/*
#: Understand ??
*/
