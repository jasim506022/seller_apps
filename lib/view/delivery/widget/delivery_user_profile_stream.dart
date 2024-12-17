import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/delivary_controller.dart';
import '../../../model/profile_model.dart';
import '../../../res/app_asset/image_asset.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/single_empty_widget.dart.dart';
import '../../loading_widget/loading_delivery_user_widget.dart';
import 'delivary_user_profile_details_widget.dart';

class DeliveryUserProfileStream extends StatelessWidget {
  const DeliveryUserProfileStream({
    super.key,
    required this.userId,
    required this.orderId,
  });

  final String userId, orderId;

  @override
  Widget build(BuildContext context) {
    var delivaryController = Get.find<DeliveryController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: Text(
            "User Details: ",
            style: AppsTextStyle.largeBoldText.copyWith(color: AppColors.red),
          ),
        ),
        StreamBuilder(
            stream:
                delivaryController.delivaryUserDetailsSnaphots(userId: userId),
            builder: (context, usersnapshots) {
              if (usersnapshots.connectionState == ConnectionState.waiting) {
                return const DeliveryUserLoading();
              } else if (usersnapshots.hasData) {
                ProfileModel userProfile =
                    ProfileModel.fromMap(usersnapshots.data!.data()!);

                return DeliveryUserProfileDetailsWidget(
                  userProfile: userProfile,
                  orderId: orderId,
                );
              } else if (usersnapshots.hasError) {
                return SingleEmptyWidget(
                  image: ImagesAsset.singleError,
                  title: 'Error Found: ${usersnapshots.error}',
                );
              }
              return const DeliveryUserLoading();
            }),
      ],
    );
  }
}
