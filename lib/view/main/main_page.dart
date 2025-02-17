import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../controller/profile_controller.dart';
import '../../res/app_string.dart';
import '../../res/apps_color.dart';
import '../home/home_page.dart';
import '../other/local_service.dart';
import '../other/pushnotification.dart';
import '../product/product_page.dart';
import '../profile/profile_screen.dart';
import '../search/search_page.dart';

/// /// Main application page with a bottom navigation bar.
/// Handles user profile fetching and notification setup.
class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
// Using late Because ensure that profileController is initialized only after the widget is create.
  late ProfileController profileController;

  /// Stores the currently selected bottom navigation index. (The _currentIndex use means that _currentIndex is private and cann't access outside of this class)
  int _currentIndex = 0;

  /// List of screens associated with each bottom navigation item. (using final const because Can be assigned only once?)
  final List<Widget> _bottomNavigationWidgets = const [
    HomePage(),
    ProductPage(),
    SearchPage(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    profileController = Get.find<ProfileController>();
    _initializeNotifications();
    _initializeIndex();
    profileController.fetchUserProfile();
    // CartFunctions.allProduct();
  }

  void _initializeNotifications() {
    LocalServiceNotification.initializeuser(context);
    PushNotification pushNotification = PushNotification();
    pushNotification.requestNotificationPermission();
    pushNotification.initMessageInforUser(context);
  }

  /// Loads the initial bottom navigation index if passed via arguments.
  void _initializeIndex() {
    final int selectedIndex = Get.arguments ?? 0;
    if (selectedIndex >= 0 && selectedIndex < _bottomNavigationWidgets.length) {
      setState(() => _currentIndex = selectedIndex);
    }
  }

  @override
  void didChangeDependencies() {
    /// Updates the system UI style (status bar color & icon brightness).
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.green,
        statusBarIconBrightness: Theme.of(context).brightness));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      //controls whether the user can navigate back or exit the app
      onPopInvoked: (didPop) => profileController.exitApps(didPop),
      child: Scaffold(
        bottomNavigationBar: SalomonBottomBar(
          backgroundColor: Theme.of(context).cardColor,
          currentIndex: _currentIndex,

          /// Updates the selected tab when the user taps a navigation item.
          onTap: (i) => setState(() => _currentIndex = i),

          /// Displays the currently selected screen.
          items: _createBottomNavItems(),
        ),
        body: _bottomNavigationWidgets[_currentIndex],
      ),
    );
  }

  /// Creates the list of bottom navigation items.
  List<SalomonBottomBarItem> _createBottomNavItems() {
    return [
      _buildBottomBarItem(
          activeIcon: Icons.home,
          icon: Icons.home_outlined,
          title: AppStrings.homeTitle),
      _buildBottomBarItem(
        activeIcon: Icons.favorite_border,
        icon: Icons.favorite_border_outlined,
        title: AppStrings.productsTitle,
      ),
      _buildBottomBarItem(
        activeIcon: Icons.search,
        icon: Icons.search_outlined,
        title: AppStrings.searchTitle,
      ),
      _buildBottomBarItem(
        activeIcon: Icons.person,
        icon: Icons.person_outline,
        title: AppStrings.profileTitle,
      ),
    ];
  }

  /// Creates an individual bottom navigation bar item.
  SalomonBottomBarItem _buildBottomBarItem({
    required IconData activeIcon,
    required IconData icon,
    required String title,
  }) {
    return SalomonBottomBarItem(
        activeIcon: Icon(activeIcon, color: AppColors.green),
        icon: Icon(icon),
        title: Text(title),
        selectedColor: AppColors.green,
        unselectedColor: Theme.of(context).unselectedWidgetColor);
  }
}


/*
#: Why do we use const:
#: why do we use final 
#: When use page and home
#: final ProfileController profileController = Get.find<ProfileController>(); is better way to declar 
#: why do we use static 
#: Profile Controllder (Doesn't Work)
*/

  