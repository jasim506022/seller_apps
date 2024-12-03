import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seller_apps/res/apps_color.dart';
import 'package:seller_apps/res/apps_text_style.dart';
import 'package:seller_apps/widget/background_shape_widget.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.onTap,
  });

  final String imageAsset;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Image.asset(
            imageAsset,
            height: .2.sh,
            width: 1.sw,
          ),
          SizedBox(height: 15.h),
          InkWell(
              onTap: () {
                onTap();
              },
              child: BackgroundShapeWidget(
                backgroundColor: AppColors.deepGreen,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: AppsTextStyle.largeBoldText
                        .copyWith(color: AppColors.white),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
