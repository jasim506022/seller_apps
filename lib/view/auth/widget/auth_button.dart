import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seller_apps/res/network_utilis.dart';

import '../../../../../res/apps_text_style.dart';
import '../../../controller/loading_controller.dart';

/// A custom authentication button that shows a loading indicator when an operation is in progress.
///
/// This button takes a title and a callback function to handle the button press event.
/// It listens to the [LoadingController] to determine whether to show a loading spinner or the button text.
class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    final LoadingController loadingController = Get.find<LoadingController>();

    return SizedBox(
      height: 55.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async =>
            await NetworkUtils.executeWithInternetCheck(action: onPressed),
        child: Obx(
          () => loadingController.loading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Text(label, style: AppsTextStyle.button),
        ),
      ),
    );
  }
}
/*
What is Void Call Back
# when use double.infinity and when use 1.sw
*/