import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:seller_apps/page/completeorder/totalsellerpage.dart';
import '../../const/cartmethod.dart';
import '../../const/const.dart';
import '../../const/global.dart';
import '../../const/gobalcolor.dart';
import '../home/homepage.dart';
import '../product/productpage.dart';
import '../profile/profilepage.dart';
import '../search/searchpage.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  MainScreen({super.key, this.index});
  int? index;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
//  bool? isApproved;

  List<Widget> widgetOptions = <Widget>[
    const HomePage(),
    const ProductPage(),
    const TotalSellPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();

    globalMethod.getUser();
    CartMethods.allProduct();
    FirebaseFirestore.instance
        .collection("seller")
        .doc(sharedPreference!.getString("uid"))
        .get()
        .then((value) {
      previousEarning = value.data()!["earnings"];
    });
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Theme.of(context).brightness));
    return Scaffold(
        bottomNavigationBar: SalomonBottomBar(
          backgroundColor: Theme.of(context).cardColor,
          currentIndex: widget.index == null ? currentIndex : widget.index!,
          onTap: (i) => setState(() {
            currentIndex = i;
            widget.index = null;
          }),
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
        body: widget.index == null
            ? widgetOptions[currentIndex]
            : widgetOptions[widget.index!]);
  }
}
