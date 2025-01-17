import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seller_apps/res/app_function.dart';
import 'package:seller_apps/res/app_string.dart';

import '../res/apps_color.dart';
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
      title: _buildTitleRow(),
      content: Text(
        content,
      ),
      actions: _buildActions(),
    );
  }

  Row _buildTitleRow() {
    return Row(
      children: [
        Text(title),
        AppsFunction.horizontalSpace(10),
        Container(
          padding: EdgeInsets.all(5.r),
          decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
          child: Icon(
            icon,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildActions() {
    return [
      OutlinedTextButtonWidget(
        color: yesButtonColor,
        title: AppString.yes,
        onPressed: onYesPressed,
      ),
      OutlinedTextButtonWidget(
        color: noButtonColor,
        title: AppString.no,
        onPressed: onNoPressed ?? () => Get.back(),
      ),
    ];
  }
}
