import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/profile_model.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/user_avatar_widget.dart';

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
            UserAvatarWidget(
              size: 90,
              imageUrl: userProfile.imageurl!,
            ),
            AppsFunction.horizontalSpace(15),
            Expanded(
              child: _buildProfileTable(),
            )
          ],
        ),
      ),
    );
  }

  /// Builds the profile details in a table format
  Padding _buildProfileTable() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
          // Understand this code
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(8),
          },
          children: [
            _buildTableRow(AppString.name, userProfile.name!),
            _buildTableRow(AppString.email, userProfile.email!),
            _buildTableRow(AppString.phone, userProfile.phone!),
            _buildTableRow(
                AppString.orderDate, AppsFunction.formatDate(orderId)),
          ],
        ));
  }

  TableRow _buildTableRow(String title, String value) {
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
