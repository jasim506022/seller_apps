import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/apps_text_style.dart';

/// A reusable widget that displays an image and a message when no data is available.
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          /// Background image for empty state.

          Image.asset(
            image,
            height: 550.h,
            width: 320.w,
          ),

          /// Title positioned on the image

          Positioned(
            top: 120.h,
            left: 130.w,
            right: 40.w,
            child: Center(
              child: SizedBox(
                height: 300.h,
                width: 130.w,
                child: Center(
                    child: Text(title, style: AppsTextStyle.emptyTextStyle)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
