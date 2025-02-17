import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/apps_color.dart';

/// A customizable circular avatar widget with a shimmer effect and error handling.
class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({
    super.key,
    required this.imageUrl,
    required this.diameter,
  });

  /// Creates a circular profile avatar with a shimmer effect.
  ///
  /// [imageUrl] - The image URL of the user.
  /// [diameter] - The size of the avatar in logical pixels
  final String imageUrl;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.red, width: 2),
          shape: BoxShape.circle),
      height: diameter.h,
      width: diameter.h,
      child: ClipOval(
        child: FancyShimmerImage(
          imageUrl: imageUrl,
          errorWidget: const Icon(Icons.error),
        ),
      ),
    );
  }
}

/*
#: Also Add No Image
*/
