import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../res/apps_color.dart';
import '../res/apps_text_style.dart';
import 'outlined_text_button_widget.dart';

class ShowAlertDialogWidget extends StatelessWidget {
  const ShowAlertDialogWidget({
    super.key,
    required this.title,
    required this.content,
    required this.onYesPressed,
    this.onNoPressed,
    required this.icon,
    this.iconColor = AppColors.red,
    this.yesButtonColor = AppColors.red,
    this.noButtonColor = AppColors.green,
  });

  final String title;
  final String content;
  final VoidCallback onYesPressed;
  final VoidCallback? onNoPressed;
  final IconData icon;
  final Color iconColor;
  final Color yesButtonColor;
  final Color noButtonColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: _buildTitleRow(),
      content: Text(
        content,
        textAlign: TextAlign.start,
        style: AppsTextStyle.subTitleTextStyle.copyWith(
          color: Theme.of(context).primaryColor,
        ),
      ),
      actions: _buildActions(),
    );
  }

  Row _buildTitleRow() {
    return Row(
      children: [
        Text(title, style: AppsTextStyle.titleTextStyle),
        SizedBox(width: 10.w),
        Container(
          padding: EdgeInsets.all(5.r),
          decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
          child: Icon(icon, color: AppColors.white, size: 20.h),
        ),
      ],
    );
  }

  List<Widget> _buildActions() {
    return [
      OutlinedTextButtonWidget(
        color: yesButtonColor,
        title: "Yes",
        onPressed: onYesPressed,
      ),
      OutlinedTextButtonWidget(
        color: noButtonColor,
        title: "No",
        onPressed: onNoPressed ?? () => Get.back(),
      ),
    ];
  }
}

/*
1. General Structure
Strength: The widget is modular and adheres to the single responsibility principle.
Improvement: Use constants or externalized resources for repetitive values (e.g., padding, sizes).
2. Naming and Parameters
The parameter yesOnPress and noOnPress are straightforward but could be renamed to onYesPressed and onNoPressed for consistency with naming conventions.
Consider adding optional parameters for colors, icon sizes, or padding to make the widget more customizable.
3. Color Usage
Improvement: Avoid hardcoding AppColors.red, AppColors.green, etc., directly inside the widget. Instead, allow colors to be passed as parameters with default values.
This enhances the widget's adaptability for different themes.
4. Theme Adaptation
Strength: The use of Theme.of(context).dialogBackgroundColor and Theme.of(context).primaryColor ensures the widget adapts to theme changes.
Improvement: Extend theme awareness to button colors (e.g., retrieve colors from the theme if not passed explicitly).
5. Text Alignment
Improvement: The TextAlign.justify is not commonly used for dialog text. Consider using TextAlign.start for consistency with common UI practices.
6. Default Behavior
The noOnPress has a fallback to Get.back(). This is good but could be mentioned explicitly in the parameter documentation or as a comment.
7. Reusability
Extract the title row and actions into smaller private widgets or methods to enhance readability and allow reuse.






Improvements and Benefits
1. Parameter Renaming: Renamed yesOnPress and noOnPress to onYesPressed and onNoPressed for better readability.
2. Customizable Colors: Added optional parameters (iconColor, yesButtonColor, noButtonColor) for better reusability and theme adaptability.
3. Private Methods:
Extracted _buildTitleRow() and _buildActions() for better readability and maintainability.
These methods simplify debugging and allow reuse in future dialogs.
4. Alignment Consistency:
Replaced TextAlign.justify with TextAlign.start for standard alignment.
5. Default Behavior:
onNoPressed has a clear fallback to Get.back(), documented explicitly.
6. Modularity: The dialog is more adaptable for future customizations or changes.


*/



/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../res/apps_color.dart';
import '../res/apps_text_style.dart';
import 'outlined_text_button_widget.dart';

class ShowAlertDialogWidget extends StatelessWidget {
  const ShowAlertDialogWidget({
    super.key,
    required this.title,
    required this.content,
    required this.yesOnPress,
    this.noOnPress,
    required this.icon,
  });

  final String title;
  final String content;
  final VoidCallback yesOnPress;
  final VoidCallback? noOnPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      title: Row(
        children: [
          Text(title, style: AppsTextStyle.titleTextStyle),
          SizedBox(
            width: 10.w,
          ),
          Container(
              padding: EdgeInsets.all(5.r),
              decoration: const BoxDecoration(
                  color: AppColors.red, shape: BoxShape.circle),
              child: Icon(
                icon,
                color: AppColors.white,
                size: 20.h,
              )),
        ],
      ),
      content: Text(content,
          textAlign: TextAlign.justify,
          style: AppsTextStyle.subTitleTextStyle
              .copyWith(color: Theme.of(context).primaryColor)),
      actions: [
        OutlinedTextButtonWidget(
          color: AppColors.red,
          title: "Yes",
          onPressed: yesOnPress,
        ),
        OutlinedTextButtonWidget(
            color: AppColors.green,
            title: "No",
            onPressed: noOnPress ??
                () {
                  Get.back();
                }),
      ],
    );
  }
}

*/