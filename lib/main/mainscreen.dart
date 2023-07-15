import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:seller_apps/auth/signinscreen.dart';
import 'package:seller_apps/home/homescreen.dart';
import 'package:seller_apps/product/allproduct.dart';
import 'package:seller_apps/product/searchscreen.dart';

import '../const/global.dart';
import '../profile/profilescreen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key, this.index});
  int? index;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool? isApproved;

  List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    AllProducts(),
    SearchScreen(),
    ProfileScreen(),
  ];

  getUser() async {
    User currentUser = FirebaseAuth.instance.currentUser!;
    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection("seller")
          .doc(currentUser.uid)
          .get()
          .then((snapshot) async {
        if (snapshot.exists) {
          if (snapshot.data()!["status"] == "approved") {
            print("Bangladesh");
            print(snapshot.data()!["status"] == "approved");
            await sharedPreference!.setString("uid", snapshot.data()!["uid"]);
            await sharedPreference!
                .setString("email", snapshot.data()!["email"]);
            await sharedPreference!.setString("name", snapshot.data()!["name"]);
            await sharedPreference!
                .setString("imageurl", snapshot.data()!["imageurl"]!);
            await sharedPreference!
                .setString("phone", snapshot.data()!["phone"]!);
            isApproved = true;
          } else {
            isApproved = false;
          }
        }
      });
    }
    isApproved = false;
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return

        //isApproved == true
        //?
        Scaffold(
            bottomNavigationBar: SalomonBottomBar(
              currentIndex: widget.index == null ? currentIndex : widget.index!,
              onTap: (i) => setState(() {
                currentIndex = i;
                widget.index = null;
              }),
              items: [
                /// Home
                SalomonBottomBarItem(
                  icon: Icon(Icons.home),
                  title: Text("Home"),
                  selectedColor: Colors.purple,
                ),

                /// Likes
                SalomonBottomBarItem(
                  icon: Icon(Icons.favorite_border),
                  title: Text("Likes"),
                  selectedColor: Colors.pink,
                ),

                /// Search
                SalomonBottomBarItem(
                  icon: Icon(Icons.search),
                  title: Text("Search"),
                  selectedColor: Colors.orange,
                ),

                /// Profile
                SalomonBottomBarItem(
                  icon: Icon(Icons.person),
                  title: Text("Profile"),
                  selectedColor: Colors.teal,
                ),
              ],
            ),
            body: widget.index == null
                ? widgetOptions[currentIndex]
                : widgetOptions[widget.index!]);
    // : Scaffold(
    //     appBar: AppBar(
    //       automaticallyImplyLeading: false,
    //       backgroundColor: Colors.white,
    //       title: const Text(
    //         "Jasim Gegorcy",
    //         style:
    //             TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    //       ),
    //       centerTitle: true,
    //       actions: [
    //         IconButton(
    //             onPressed: () async {
    //               await FirebaseAuth.instance.signOut();
    //               // ignore: use_build_context_synchronously
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => const SignInScrren(),
    //                   ));
    //             },
    //             icon: const Icon(
    //               Icons.logout,
    //               color: Colors.black,
    //             ))
    //       ],
    //     ),
    //     body: Container(
    //       alignment: Alignment.center,
    //       child: const Text(
    //         "Block By User.\n Contract With Admin for unlock",
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //             fontSize: 24,
    //             fontWeight: FontWeight.bold,
    //             color: Colors.red),
    //       ),
    //     ));
  }
}
