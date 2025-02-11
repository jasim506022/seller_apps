import 'package:flutter/material.dart';
import '../../res/app_string.dart';
import '../../res/apps_color.dart';
import '../../res/network_utilis.dart';
import '../../res/routes/routes_name.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/profile_controller.dart';
import 'widget/profile_option_tile_widget.dart';
import 'widget/profile_header_widget.dart';
import 'widget/theme_switch_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.profile),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings_outlined,
                size: 25.h,
              ))
        ],
      ),
      body: Column(
        children: [
          const ProfileHeaderWidget(),
          Expanded(
            child: ListView(
              children: [
                const Divider(),
                _buildProfileOptions(),
                const ThemeSwitchWidget(),
                ProfileOptionTileWidget(
                  hasTrailingIcon: false,
                  icon: Icons.exit_to_app,
                  title: AppString.signOut,
                  iconColor: AppColors.red,
                  onTap: () async {
                    NetworkUtils.executeWithInternetCheck(action: () {
                      profileController.signOut();
                      profileController.dispose();
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Dynamically build list of profile menu items
  Widget _buildProfileOptions() {
    final List<Map<String, dynamic>> menuItems = [
      {
        "icon": Icons.person,
        "title": AppString.about,
        "route": RoutesName.editProfilePage
      },
      {
        "icon": Icons.home_outlined,
        "title": AppString.home,
        "route": RoutesName.mainPage,
        "argument": 0
      },
      {
        "icon": Icons.reorder,
        "title": AppString.myOrder,
        "route": RoutesName.orderPage
      },
      {
        "icon": Icons.access_time,
        "title": AppString.historyPage,
        "route": RoutesName.completeOrderPage
      },
      {
        "icon": Icons.search,
        "title": AppString.search,
        "route": RoutesName.mainPage,
        "argument": 2
      },
    ];

    return Column(
      children: menuItems.map((item) {
        return ProfileOptionTileWidget(
          icon: item['icon'],
          title: item['title'],
          onTap: () async {
            NetworkUtils.executeWithInternetCheck(action: () {
              if (item['argument'] is int) {
                Get.offAndToNamed(item['route'], arguments: item['argument']);
              } else {
                Get.toNamed(item['route']);
              }
            });
          },
        );
      }).toList(),
    );
  }
}
