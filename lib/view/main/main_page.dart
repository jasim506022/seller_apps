import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../const/cart_function.dart';
import '../../controller/profile_controller.dart';
import '../../res/app_string.dart';
import '../../res/apps_color.dart';
import '../home/home_page.dart';
import '../other/local_service.dart';
import '../other/pushnotification.dart';
import '../product/product_page.dart';
import '../profile/profile_screen.dart';
import '../search/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var prifleController = Get.find<ProfileController>();
  List<Widget> bottomNavigatorWidget = <Widget>[
    const HomePage(),
    const ProductPage(),
    const SearchPage(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

    _initializeNotifications();
    _initializeIndex();
    // globalMethod.getUsersharedPreference();
    prifleController.fetchUserProfile();

    /*
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFormMessage = message.data['routes'];
        print(routeFormMessage);
      }
    });
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }

      LocalServiceNotification.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFormMessage = message.data['routes'];
      print(routeFormMessage);
    });
    
    */

    CartFunctions.allProduct();
  }

  void _initializeNotifications() {
    LocalServiceNotification.initializeuser(context);
    PushNotification message = PushNotification();
    message.requestNotificationPermission();
    message.initMessageInforUser(context);
    // message.getFcmToken();
    // FirebaseDatabase.iniNotification();
    // LocalServiceNotification.initialize(context);
  }

  int _currentIndex = 0;
  // int? indexValue;

  void _initializeIndex() {
    int? data = Get.arguments;
    if (data != null) {
      setState(() => _currentIndex = data);
    } else {
      _currentIndex = 0;
    }
  }

  @override
  void didChangeDependencies() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.green,
        statusBarIconBrightness: Theme.of(context).brightness));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Theme.of(context).cardColor,
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() => _currentIndex = i);
        },
        items: _buildBottomBarItemsList(),
      ),
      body: bottomNavigatorWidget[_currentIndex],
    );
  }

  List<SalomonBottomBarItem> _buildBottomBarItemsList() {
    return [
      _buildBottomBarItem(
          activeIcon: Icons.home,
          icon: Icons.home_outlined,
          title: AppString.home),
      _buildBottomBarItem(
        activeIcon: Icons.favorite_border,
        icon: Icons.favorite_border_outlined,
        title: AppString.products,
      ),
      _buildBottomBarItem(
        activeIcon: Icons.search,
        icon: Icons.search_outlined,
        title: AppString.search,
      ),
      _buildBottomBarItem(
        activeIcon: Icons.person,
        icon: Icons.person_outline,
        title: AppString.profile,
      ),
    ];
  }

  SalomonBottomBarItem _buildBottomBarItem({
    required IconData activeIcon,
    required IconData icon,
    required String title,
  }) {
    return SalomonBottomBarItem(
        activeIcon: Icon(
          activeIcon,
          color: AppColors.green,
        ),
        icon: Icon(icon),
        title: Text(
          title,
        ),
        selectedColor: AppColors.green,
        unselectedColor: Theme.of(context).unselectedWidgetColor);
  }
}
