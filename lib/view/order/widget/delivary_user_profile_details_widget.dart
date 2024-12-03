import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/profilemodel.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';

class DeliveryUserProfileDetailsWidget extends StatelessWidget {
  const DeliveryUserProfileDetailsWidget(
      {super.key, required this.userProfile, required this.orderId});
  final ProfileModel userProfile;
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: AppColors.black.withOpacity(.02),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90.h,
              width: 90.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.red, width: 2.h)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.h),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: userProfile.imageurl!,
                  placeholder: (context, url) => CircularProgressIndicator(
                    backgroundColor: AppColors.white,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                      _buildTableRow(context, "Name", userProfile.name!),
                      _buildTableRow(context, "Email", userProfile.email!),
                      _buildTableRow(context, "Phone", userProfile.phone!),
                      _buildTableRow(
                          context, "Order", AppsFunction.formatDate(orderId)),
                    ],
                  )),
            )
          ],
        ),
      ),
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
