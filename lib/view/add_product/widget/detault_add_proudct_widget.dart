import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seller_apps/res/apps_color.dart';
import 'package:seller_apps/res/apps_text_style.dart';

import '../../../widget/capture_image_selection_dialog_widget.dart';

class DetaultAddProductWidget extends StatelessWidget {
  const DetaultAddProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New  Product",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 0.23.sh,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                    backgroundColor: AppColors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r))),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        const CaptureImageSelectionDialogWidget(),
                  );
                },
                child: Text("Add New Product",
                    style: AppsTextStyle.buttonTextStyle
                        .copyWith(letterSpacing: 1.3)))
          ],
        ),
      ),
    );
  }
}
