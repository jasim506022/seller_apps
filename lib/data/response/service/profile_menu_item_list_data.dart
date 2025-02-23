import 'package:flutter/material.dart';

import '../../../model/profile_menu_item.dart';
import '../../../res/app_string.dart';
import '../../../res/routes/routes_name.dart';

class ProfileMenuItemListData {
  static const List<ProfileMenuItem> profileMenuItems = [
    ProfileMenuItem(
      icon: Icons.person,
      title: AppStrings.aboutTitle,
      route: RoutesName.editProfilePage,
    ),
    ProfileMenuItem(
      icon: Icons.home_outlined,
      title: AppStrings.homeTitle,
      route: RoutesName.mainPage,
      argument: 0,
    ),
    ProfileMenuItem(
      icon: Icons.reorder,
      title: AppStrings.orderTitle,
      route: RoutesName.orderPage,
    ),
    ProfileMenuItem(
      icon: Icons.access_time,
      title: AppStrings.historyTitle,
      route: RoutesName.completeOrderPage,
    ),
    ProfileMenuItem(
      icon: Icons.search,
      title: AppStrings.searchTitle,
      route: RoutesName.mainPage,
      argument: 2,
    ),
  ];
}
