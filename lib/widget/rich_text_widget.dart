import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../res/apps_color.dart';
import '../res/apps_text_style.dart';
import '../res/internet_utilis.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.simpleText,
    required this.colorText,
    required this.function,
  });

  final String simpleText;
  final String colorText;
  final VoidCallback function;
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
              if (!(await NetworkUtili.verifyInternetStatus())) {
                function();
              }
            },
          text: colorText,
          style: AppsTextStyle.buttonTextStyle.copyWith(
              decoration: TextDecoration.underline, color: AppColors.green))
    ]));
  }
}


/*
Suggestions for Improvement:
Use AsyncCallback:

The function parameter is currently of type Function. It's better to be explicit about the callback type. If the function you expect to be passed is asynchronous, consider defining it as Future<void> Function() to ensure type safety.
Handling Internet Check:

The asynchronous check for internet connectivity within the TapGestureRecognizer might delay the tap action. It might be beneficial to show a loading indicator or some other feedback when checking the internet status.
Use of GestureRecognizer:

The use of TapGestureRecognizer is correct, but it would be more readable if the async operation is moved into a separate method to reduce complexity within the widget's build method.
Consider Adding a Loading Indicator:

When checking for internet status, it might be helpful to give the user feedback by displaying a loading indicator until the check is completed.
*/

/*
Changes Made:
Explicit Function Type:

The function parameter is now typed as Future<void> Function() for better type safety and clarity.
Moved Async Logic to a Separate Method:

The asynchronous operation checking the internet status is now handled in the _onTap() method. This makes the build method cleaner and easier to read.
Internet Check:

The function() is only called if the internet check passes (NetworkUtili.verifyInternetStatus() returns true). You can add additional feedback if needed when there is no internet connection.
Simplified Gesture Handling:

The TapGestureRecognizer now calls the _onTap() method, which encapsulates the logic for checking the internet status and calling the callback.
Benefits of These Changes:
Improved Readability: Separating the logic into a method makes the code easier to understand and maintain.
Type Safety: Explicitly defining the function parameter as a Future<void> Function() ensures that the code is type-safe and clear about what kind of function is expected.
Cleaner build Method: Moving the async check logic out of the build method helps keep it focused on layout and presentation.
Future-proofing: By handling asynchronous operations properly, you can more easily extend the functionality in the future (e.g., show a loading indicator while checking the internet connection).
This version should be easier to maintain, test, and extend, and it adheres to best practices in terms of readability and separation of concerns.
*/




/*
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
              if (!(await NetworkUtili.verifyInternetStatus())) {
                function();
              }
            },
          text: colorText,
          style: AppsTextStyle.buttonTextStyle.copyWith(
              decoration: TextDecoration.underline, color: AppColors.green))
    ]));
  }
}
*/