import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/apps_text_style.dart';

/// A customizable profile list tile with an icon, title, and optional trailing icon.
class ProfileOptionTileWidget extends StatelessWidget {
  const ProfileOptionTileWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      this.iconColor,
      this.hasTrailingIcon = true});

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final bool hasTrailingIcon;

  @override
  Widget build(BuildContext context) {
    final Color defaultColor = iconColor ?? Theme.of(context).primaryColor;
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: defaultColor,
        size: 25.h,
      ),
      trailing: hasTrailingIcon
          ? IconButton(
              onPressed: onTap,
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 20.h,
              ))
          : null,
      title: Text(title,
          style: AppsTextStyle.mediumBoldText.copyWith(color: defaultColor)),
    );
  }
}

/*
#: Why onTap Work propperly Without use ();
*/