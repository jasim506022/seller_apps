import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/order_controller.dart';
import '../../../model/profile_model.dart';
import '../../../res/app_asset/image_asset.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/single_empty_widget.dart.dart';
import '../../loading_widget/loading_user_details_widget.dart';
import 'order_user_details_widget.dart';

class OrderUserDetailsStream extends StatelessWidget {
  const OrderUserDetailsStream({
    super.key,
    required this.userId,
    required this.orderId,
  });

  final String userId, orderId;

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find<OrderController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5).r,
          child: Text(
            AppStrings.userDetails,
            style: AppsTextStyle.largeBoldText.copyWith(color: AppColors.red),
          ),
        ),

        /// StreamBuilder to Fetch User Details
        StreamBuilder(
            stream: orderController.fetchUserDetails(userId: userId),
            builder: (context, snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting) {
                return const UserDetailsLoadingWidget();
              }
              if (snapshots.hasError) {
                return SingleEmptyWidget(
                  image: AppImage.singleError,
                  title: '${AppStrings.errorOccurred} ${snapshots.error}',
                );
              }

              if (!snapshots.hasData || snapshots.data?.data() == null) {
                return SingleEmptyWidget(
                  image: AppImage.singleError,
                  title: AppStrings.noDataAvaiable,
                );
              }

              /// Convert snapshot data to `ProfileModel`
              ProfileModel userProfile =
                  ProfileModel.fromMap(snapshots.data!.data()!);
              return OrderUserDetailsWidget(
                userProfileModel: userProfile,
                orderId: orderId,
              );
            }),
      ],
    );
  }
}

/*
 When to Use FutureBuilder vs. StreamBuilder?
Feature	FutureBuilder	StreamBuilder
Type of Data	One-time async result (Future)	Continuous async updates (Stream)
Use Case	Fetching data once (API call, DB fetch)	Real-time updates (Firebase Firestore, WebSockets)
Rebuilding	UI rebuilds only once when future completes	UI rebuilds every time new data arrives
✅ Use FutureBuilder when fetching one-time data.
✅ Use StreamBuilder when you need real-time updates.

#: Used const where possible	✅ Optimizes widget tree rebuild performance
*/