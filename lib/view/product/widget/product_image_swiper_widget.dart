import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/apps_color.dart';

class ProductImageSwiperWidget extends StatelessWidget {
  const ProductImageSwiperWidget({
    super.key,
    required this.imageUrls,
  });

  final List<dynamic> imageUrls;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 200.h,
        width: .9.sw,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return CachedNetworkImage(
              imageUrl: imageUrls[index],
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child:
                    CircularProgressIndicator(value: downloadProgress.progress),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            );
          },
          autoplay: imageUrls.length > 1,// Enable autoplay only if multiple images exist
          itemCount: imageUrls.length,
          pagination: const SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                  color: AppColors.white, activeColor: AppColors.red)),
          control: const SwiperControl(color: Colors.transparent),
        ),
      ),
    );
  }
}
/*
images.length == 1 ? false : true	images.length > 1	Simplifies logic for autoplay toggle
*/