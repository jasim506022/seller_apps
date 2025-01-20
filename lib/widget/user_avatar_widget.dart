
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/apps_color.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({
    super.key,
    required this.imageUrl,
    required this.height,
  });

  final String imageUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.red, width: 2),
          shape: BoxShape.circle),
      height: height.h,
      width: height.h,
      child: ClipOval(
        child: ClipOval(
          child: FancyShimmerImage(
          
            imageUrl: imageUrl,
            errorWidget: const Icon(Icons.error),
          ),
        )
        
        
        
      ),
    );
  }
}
