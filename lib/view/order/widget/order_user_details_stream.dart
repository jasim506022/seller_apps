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

/// A widget that displays user details in an order using a real-time `StreamBuilder`.
///
/// This widget listens for changes in the user's details and updates the UI dynamically.

/// This widget utilizes the `OrderController` to fetch user details based on `userId`.
class OrderUserDetailsStream extends StatelessWidget {
  const OrderUserDetailsStream({
    super.key,
    required this.userId,
    required this.orderId,
  });

  /// Unique identifiers for the user and order
  final String userId, orderId;

  @override
  Widget build(BuildContext context) {
    // Retrieve the OrderController instance using GetX
    final OrderController orderController = Get.find<OrderController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// **Section Title: User Details**
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5).r,
          child: Text(
            AppStrings.userDetailsTitle,
            style: AppsTextStyle.largeBold.copyWith(color: AppColors.red),
          ),
        ),

        /// **StreamBuilder: Fetch User Details in Real Time**
        StreamBuilder(
            stream: orderController.fetchUserDetails(userId: userId),
            builder: (context, snapshot) {
              // **Loading State:** Show a loading widget while data is being fetched
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingUserDetailsWidget();
              }
              // **Error Handling:** Display an error message if the stream encounters an error
              if (snapshot.hasError) {
                return SingleEmptyWidget(
                  image: AppImage.singleError,
                  title: '${AppStrings.errorOccurred} ${snapshot.error}',
                );
              }

              // **No Data Case:** Handle the scenario where no user details are found
              if (!snapshot.hasData || snapshot.data?.data() == null) {
                return SingleEmptyWidget(
                  image: AppImage.singleError,
                  title: AppStrings.noDataAvaiableError,
                );
              }

              /// **Convert Firestore snapshot data to a `ProfileModel` instance**
              ProfileModel userProfile =
                  ProfileModel.fromMap(snapshot.data!.data()!);
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