import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


import '../../model/profilemodel.dart';
import '../../res/apps_color.dart';
import '../../res/apps_text_style.dart';
import '../../service/database/firebasedatabase.dart';
import '../../widget/empty_widget.dart';
import '../loading_widget/loading_delivery_user_widget.dart';

class DeliveryUserProfileWidget extends StatelessWidget {
  const DeliveryUserProfileWidget({
    super.key,
    required this.userId,
    required this.orderId,
  });

  final String userId, orderId;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('hh:mm a, MMM d, yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(orderId)));
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Text(
            "User Details: ",
            style: AppsTextStyle.largeBoldText.copyWith(color: AppColors.red),
          ),
        ),
        StreamBuilder(
            stream: FirebaseDatabase.userDetailsSnaphots(userId: userId),
            builder: (context, usersnapshots) {
              if (usersnapshots.connectionState == ConnectionState.waiting) {
                return const DeliveryUserLoading();
              } else if (usersnapshots.hasData) {
                ProfileModel userProfile =
                    ProfileModel.fromMap(usersnapshots.data!.data()!);

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Colors.black.withOpacity(.04),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 90.h,
                          width: 90.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: AppColors.red, width: 2.h)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.h),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: userProfile.imageurl!,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                backgroundColor: AppColors.white,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.intrinsicHeight,
                                // Understand this code
                                columnWidths: const {
                                  0: FlexColumnWidth(3),
                                  1: FlexColumnWidth(8),
                                },
                                children: [
                                  _buildTableRow(
                                      context, "Name", userProfile.name!),
                                  _buildTableRow(
                                      context, "Email", userProfile.email!),
                                  _buildTableRow(
                                      context, "Phone", userProfile.phone!),
                                  _buildTableRow(
                                      context, "Order", formattedDate),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                );
              } else if (usersnapshots.hasError) {
                return EmptyWidget(
                  image: 'asset/empty/empty.png',
                  title: 'Error Found: ${usersnapshots.hasError}',
                );
              }
              return const DeliveryUserLoading();
            }),
      ],
    );
  }

  TableRow _buildTableRow(BuildContext context, String title, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Text(
            title,
            style: AppsTextStyle.mediumBoldText,
          ),
        ),
        TableCell(
          child: Text(
            value,
            style: AppsTextStyle.mediumNormalText,
          ),
        ),
      ],
    );
  }
}
