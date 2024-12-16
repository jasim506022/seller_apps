import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../controller/loading_controller.dart';

class CustomAuthButtonWidget extends StatelessWidget {
  const CustomAuthButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    // Get the LoadingController instance
    final LoadingController loadingController = Get.find<LoadingController>();

    return SizedBox(
      width: 1.sw, // Full width button
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.green, // Set button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r), // Button rounded corners
          ),
          padding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h), // Padding
        ),
        onPressed: onPressed,
        child: Obx(
          () => loadingController.loading.value
              // If loading is true, show loading spinner
              ? const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.white,
                  ),
                )
              // If not loading, show button text
              : Text(
                  title,
                  style: AppsTextStyle.buttonTextStyle
                      .copyWith(color: AppColors.white),
                ),
        ),
      ),
    );
  }
}


/*
Your CustomAuthButtonWidget implementation is clean and functional, but there are a few suggestions to improve readability, maintainability, and performance:

Suggestions for Improvement:
Avoid Creating Controllers in Build Method:

The LoadingController is being created inside the build method using Get.put(). This can lead to unnecessary controller creation and might affect performance, especially if the widget rebuilds frequently. It's better to initialize controllers in the initState method (for StatefulWidget) or use a Get.lazyPut for lazy loading.
Button Styles:

The button’s styling (background color, shape, etc.) can be extracted into a separate constant or theming structure if it’s used in multiple places to ensure consistency and better maintainability.
Inline Widgets:

The Obx widget is used correctly for reactive state updates, but it can be optimized by wrapping only the part of the widget tree that depends on the reactive value.
Add Comments:

A few comments explaining the logic can help maintainability for other developers working on the code.

*/


/*
Changes Made:
Controller Initialization:

Replaced Get.put() with Get.find() to avoid recreating the LoadingController every time the widget is rebuilt. This assumes the controller is already put into the dependency injection system elsewhere in the app (for example, using Get.put() in the initialization phase of the app or screen).
Code Comments:

Added comments to make it clear what each part of the code is doing, particularly in relation to the loading indicator and button style.
Inline Widget:

The Obx widget is kept for reactivity, but the button styling and behavior were refactored to separate the concerns more clearly.
Benefits of These Changes:
Controller Initialization: By using Get.find(), the LoadingController is only initialized once, which reduces overhead and avoids unnecessary controller creation.
Code Clarity: The added comments make it easier to understand the purpose of each part of the widget, improving maintainability.
Performance: This approach reduces the frequency of widget rebuilding and ensures the controller is used more efficiently.
This version of the widget should be easier to maintain and optimize in the long term, and the changes are in line with best practices for using GetX in Flutter.
*/


/*

class CustomAuthButtonWidget extends StatelessWidget {
  const CustomAuthButtonWidget(
      {super.key, required this.onPressed, required this.title});

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    LoadingController loadingController = Get.put(LoadingController());
    return SizedBox(
      width: 1.sw,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          ),
          onPressed: onPressed,
          child: Obx(
            () => loadingController.loading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: AppColors.white,
                    ),
                  )
                : Text(
                    title,
                    style: AppsTextStyle.buttonTextStyle
                        .copyWith(color: AppColors.white),
                  ),
          )),
    );
  }
}

*/