import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/profile_model.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/user_avatar_widget.dart';

/// A card widget displaying details about a delivery agent.
///
/// Shows name, email, phone number, and order date.
/// Uses `UserAvatarWidget` for profile picture display.
class OrderUserDetailsWidget extends StatelessWidget {
  const OrderUserDetailsWidget(
      {super.key, required this.userProfileModel, required this.orderId});

  final ProfileModel userProfileModel;
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: AppColors.black.withOpacity(.02),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// **Profile picture of the User**
          UserAvatarWidget(
            diameter: 90,
            imageUrl: userProfileModel.imageurl!,
          ),
          AppsFunction.horizontalSpacing(15),

          /// **Expanded to ensure proper layout alignment**
          Expanded(
            child: _buildUserDetailsTable(),
          )
        ],
      ),
    );
  }

  /// Builds a table layout displaying the user's information.

  Widget _buildUserDetailsTable() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(8),
          },
          children: [
            _createTableRow(AppStrings.nameLabel, userProfileModel.name!),
            _createTableRow(AppStrings.emailLabel, userProfileModel.email!),
            _createTableRow(
                AppStrings.phoneLabel, "0${userProfileModel.phone!}"),
            _createTableRow(AppStrings.orderDateLabel,
                AppsFunction.formatDate(timestamp: orderId)),
          ],
        ));
  }

  /// Creates a single row in the table with a title and value.
  TableRow _createTableRow(String title, String value) {
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

/*
#: No Image Add:
#: Understand Clearly Table Cell and Full
#: Null Safety
*/
