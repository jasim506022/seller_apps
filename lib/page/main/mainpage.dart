import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../const/cartmethod.dart';
import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../home/homepage.dart';
import '../product/productpage.dart';
import '../profile/profilepage.dart';
import '../search/searchpage.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> bottomNavigatorWidget = <Widget>[
    const HomePage(),
    const ProductPage(),
    const SearchPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    globalMethod.getUsersharedPreference();
    CartMethods.allProduct();
  }

  int currentIndex = 0;
  int? indexValue;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final dynamic data = ModalRoute.of(context)!.settings.arguments;
    indexValue = data;
  }

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
            indexValue = null;
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
