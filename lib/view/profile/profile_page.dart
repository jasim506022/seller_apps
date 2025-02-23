import 'package:flutter/material.dart';
import '../../data/response/service/profile_menu_item_list_data.dart';
import '../../res/app_string.dart';
import '../../res/apps_color.dart';
import '../../res/network_utilis.dart';
import 'package:get/get.dart';
import '../../controller/profile_controller.dart';
import 'widget/profile_option_tile_widget.dart';
import 'widget/profile_header_widget.dart';
import 'widget/theme_toggle_switch_widget.dart';

/// This screen displays the **user profile**, including:
/// Uses `ProfileController` for managing profile-related actions.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  /// Controller for handling Profile-related logic
  late final ProfileController profileController;

  @override
  void initState() {
    /// Get the `ProfileController` instance for managing Profile.
    profileController = Get.find<ProfileController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profileTitle),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings_outlined,
              ))
        ],
      ),
      body: Column(
        children: [
          // Displays profile header with user info
          const ProfileHeaderWidget(),
          Expanded(
            child: ListView(
              children: [
                const Divider(),
                // Generates profile menu options dynamically
                _buildProfileMenuItems(),
                // Allows switching between dark and light themes
                const ThemeToggleSwitchWidget(),
                ProfileMenuItemTileWidget(
                  hasTrailingIcon: false,
                  icon: Icons.exit_to_app,
                  title: AppStrings.signOutLabel,
                  iconColor: AppColors.red,
                  // Handles sign-out action with an internet check
                  onTap: () async {
                    await NetworkUtils.executeWithInternetCheck(
                        action: () => profileController.signOut());
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// **Builds the list of profile menu items dynamically.**
  ///
  /// - Iterates over `ProfileMenuItemListData.profileMenuItems` to generate menu options.
  /// - Navigates to the selected menu item's route.
  Widget _buildProfileMenuItems() {
    return Column(
      children: ProfileMenuItemListData.profileMenuItems.map((profileMenuItem) {
        return ProfileMenuItemTileWidget(
          icon: profileMenuItem.icon,
          title: profileMenuItem.title,
          onTap: () async {
            NetworkUtils.executeWithInternetCheck(action: () {
              if (profileMenuItem.argument is int) {
                Get.offAndToNamed(profileMenuItem.route,
                    arguments: profileMenuItem.argument);
              } else {
                Get.toNamed(profileMenuItem.route);
              }
            });
          },
        );
      }).toList(),
    );
  }
}


// Undersstand Construct and Map with List, is
