import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';

class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({
    super.key,
    required this.function,
    required this.color,
    required this.image,
    required this.title,
  });

  final VoidCallback function; // Defined function type more explicitly
  final Color color;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function, // Directly call the function
      child: Container(
        alignment: Alignment.center,
        height: 60.h,
        width: 1.sw,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height:
                  0.04.sh, // Consider adjusting size for better responsiveness
              width: 0.04.sh,
              color: AppColors.white,
            ),
            SizedBox(
                width: 10.w), // Using width from ScreenUtil for consistency
            Text(
              title,
              style: AppsTextStyle.buttonTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

/*
Suggestions for Improvement:
Function Type:

The function parameter is defined as Function, which is very generic. It's better to define the type explicitly for clarity and type safety. If it's a void callback, you can define it as VoidCallback.
Nested InkWell:

There's an InkWell wrapped around the entire container, and then another InkWell inside the Row. There's no need for the inner InkWell since the outer InkWell is sufficient to handle the tap gesture. You can remove the inner InkWell to simplify the widget.
Spacing Consistency:

Instead of using width: 10.h, consider using a constant for padding to maintain consistency across the app.
Responsiveness:

You're using ScreenUtil well, but ensure that the height and width values make sense on all screen sizes. For example, .04.sh for the image height could be adjusted based on the context.
*/


/*
Changes Made:
Explicit Function Type:

Changed function to VoidCallback for better type safety.
Removed Nested InkWell:

Removed the inner InkWell to simplify the widget structure. The outer InkWell is sufficient for handling taps.
Consistent Spacing:

Replaced 10.h with 10.w for consistency in spacing based on the screen width.
Benefits of These Changes:
Type Safety: Explicitly defining VoidCallback for the function parameter improves readability and ensures type safety.
Simplified Structure: Removing the unnecessary inner InkWell simplifies the widget, making it more maintainable.
Consistency: Using 10.w for spacing ensures the padding is consistent across different screen sizes.
This refactor makes the widget more efficient, readable, and easier to maintain in the long run.
*/

/*

class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({
    super.key,
    required this.function,
    required this.color,
    required this.image,
    required this.title,
  });
  final Function function;
  final Color color;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        alignment: Alignment.center,
        height: 60.h,
        width: 1.sw,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10.r)),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: .04.sh,
                width: .04.sh,
                color: AppColors.white,
              ),
              SizedBox(
                width: 10.h,
              ),
              Text(
                title,
                style: AppsTextStyle.buttonTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

*/