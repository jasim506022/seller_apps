import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:seller_apps/controller/profile_controller.dart';
import '../../const/cart_function.dart';
import '../../const/gobalcolor.dart';
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
    LocalServiceNotification.initializeuser(context);
    PushNotification message = PushNotification();
    message.requestNotificationPermission();
    message.initMessageInforUser(context);
    // message.getFcmToken();
    // FirebaseDatabase.iniNotification();
    // LocalServiceNotification.initialize(context);
    _initializeIndex();
    // globalMethod.getUsersharedPreference();
    prifleController.getUserInformationSnapshot();
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

  int currentIndex = 0;
  int? indexValue;

  void _initializeIndex() {
    int? data = Get.arguments;
    if (data != null) {
      setState(() {
        currentIndex = data;
      });
    }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final dynamic data = ModalRoute.of(context)!.settings.arguments;
  //   indexValue = data;
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Theme.of(context).brightness));
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Theme.of(context).cardColor,
        currentIndex: indexValue ?? currentIndex,
        onTap: (i) {
          setState(() {
            currentIndex = i;
          });
        },
        items: [
          SalomonBottomBarItem(
              activeIcon: Icon(
                Icons.home,
                color: greenColor,
              ),
              icon: const Icon(Icons.home_outlined),
              title: const Text(
                "Home",
              ),
              selectedColor: greenColor,
              unselectedColor: Theme.of(context).indicatorColor),
          SalomonBottomBarItem(
              activeIcon: Icon(
                Icons.favorite_border,
                color: greenColor,
              ),
              icon: const Icon(Icons.favorite_border_outlined),
              title: const Text("Likes"),
              unselectedColor: Theme.of(context).indicatorColor,
              selectedColor: greenColor),
          SalomonBottomBarItem(
              activeIcon: Icon(
                Icons.search,
                color: greenColor,
              ),
              icon: const Icon(Icons.search_outlined),
              title: const Text("Search"),
              unselectedColor: Theme.of(context).indicatorColor,
              selectedColor: greenColor),
          SalomonBottomBarItem(
              activeIcon: Icon(
                Icons.person,
                color: greenColor,
              ),
              icon: const Icon(Icons.person_outline),
              unselectedColor: Theme.of(context).indicatorColor,
              title: const Text("Profile"),
              selectedColor: greenColor),
        ],
      ),
      body: bottomNavigatorWidget[indexValue ?? currentIndex],
    );
  }
}
