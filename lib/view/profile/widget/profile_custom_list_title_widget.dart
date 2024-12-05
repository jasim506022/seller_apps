import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/apps_text_style.dart';

class ProfileCustomListTitleWidget extends StatelessWidget {
  const ProfileCustomListTitleWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      this.iconColor,
      this.showTrailing = true});

  final String title;
  final IconData icon;
  final VoidCallback onTap; // understand this code clear
  final Color? iconColor;
  final bool showTrailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: iconColor ?? Theme.of(context).primaryColor,
        size: 25.h,
      ),
      trailing: showTrailing
          ? IconButton(
              onPressed: onTap,
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).primaryColor,
                size: 20.h,
              ))
          : null,
      title: Text(title,
          style: AppsTextStyle.mediumBoldText
              .copyWith(color: iconColor ?? Theme.of(context).primaryColor)),
    );
  }
}
