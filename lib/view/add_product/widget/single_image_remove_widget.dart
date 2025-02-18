import 'dart:io';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/manage_product_controller.dart';
import '../../../res/apps_color.dart';

class SingleImageRemove extends StatelessWidget {
  const SingleImageRemove({super.key, required this.index});

  final int index;
  @override
  Widget build(BuildContext context) {
    var addProductController = Get.find<ManageProductController>();
    var image = addProductController.selectedImagesList[index];
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 1),
              ),
              child: SizedBox(
                height: 0.25.sh,
                width: 0.25.sh,
                child: image is String
                    ? FancyShimmerImage(imageUrl: image, boxFit: BoxFit.contain)
                    : Image.file(File(image.path), fit: BoxFit.contain),
              )),
        ),
        Positioned(
          top: 2,
          right: 2,
          child: InkWell(
            onTap: () => addProductController.removeProductImageFile(index),
            child: Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: AppColors.red,
                size: 25.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
