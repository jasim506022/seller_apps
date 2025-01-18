import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
    final loadingController = Get.find<LoadingController>();

    return SizedBox(
      width: 1.sw,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Obx(
          () => loadingController.loading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Text(title, style: AppsTextStyle.buttonTextStyle),
        ),
      ),
    );
  }
}
