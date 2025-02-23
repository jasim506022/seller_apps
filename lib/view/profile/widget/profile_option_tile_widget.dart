import 'package:flutter/material.dart';

import '../../../res/apps_text_style.dart';

/// **ProfileMenuItemTile**
///
/// A reusable **list tile widget** used in the profile menu to display different options.
/// - Handles **tap actions** for navigation or other interactions.
class ProfileMenuItemTileWidget extends StatelessWidget {
  const ProfileMenuItemTileWidget(
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
      ),
      title: Text(title,
          style: AppsTextStyle.largeBold.copyWith(color: defaultColor)),

      /// **Trailing Arrow (Optional)**
      trailing: hasTrailingIcon
          ? IconButton(
              onPressed: onTap,
              icon: const Icon(
                Icons.arrow_forward_ios,
              ))
          : null,
    );
  }
}

/*
#: Why onTap Work propperly Without use ();
*/