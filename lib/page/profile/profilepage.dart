import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/page/order/shiftedorderpage.dart';

import '../auth/signinpage.dart';
import '../../const/const.dart';
import '../../const/global.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../service/provider/theme_provider.dart';
import '../completeorder/totalsellerpage.dart';
import '../main/mainpage.dart';

import '../order/completeorderpage.dart';
import '../order/orderpage.dart';
import 'editprofilepage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    mq = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Theme.of(context).brightness));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          _buildSellerProfile(textstyle),
          Divider(
            height: MediaQuery.of(context).size.width * .015,
            color: grey,
            thickness: 2,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildListTitleMethod(
                    icon: Icons.person,
                    title: 'About',
                    funcion: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const EditProfilePage(isEdit: false),
                          ));
                    },
                  ),
                  _buildListTitleMethod(
                    icon: Icons.home_outlined,
                    title: 'Home',
                    funcion: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ));
                    },
                  ),
                  _buildListTitleMethod(
                    icon: Icons.reorder,
                    title: 'My Orders',
                    funcion: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderPage(),
                          ));
                    },
                  ),
                  _buildListTitleMethod(
                    icon: Icons.picture_in_picture_alt_rounded,
                    title: 'Shifted Orders',
                    funcion: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShiftedOrderPage(),
                          ));
                    },
                  ),
                  _buildListTitleMethod(
                    icon: Icons.access_time,
                    title: 'History',
                    funcion: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CompleteOrderPage(),
                          ));
                    },
                  ),
                  _buildListTitleMethod(
                    icon: Icons.money,
                    title: 'Earn',
                    funcion: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TotalSellPage(),
                          ));
                    },
                  ),
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, child) {
                      return _buildSwitchListTile(themeProvider, context);
                    },
                  ),
                  _buildListTitleMethod(
                      icon: Icons.exit_to_app,
                      title: "Sign Out",
                      funcion: () async {
                        try {
                          final result =
                              await InternetAddress.lookup('google.com');
                          if (result.isNotEmpty &&
                              result[0].rawAddress.isNotEmpty) {
                            if (mounted) {
                              globalMethod.logoutOrDeleteScreen(
                                  context: context,
                                  title: "Are you want to Logout?",
                                  content: "Are you want to Logout this Apps",
                                  function: () {
                                    FirebaseAuth.instance
                                        .signOut()
                                        .then((value) async {
                                      await GoogleSignIn().signOut();
                                    });
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => const SigninPage()),
                                      (route) => false,
                                    );
                                  });
                            }
                          }
                        } on SocketException {
                          globalMethod.flutterToast(
                              msg: "Please Check your Internet");
                        }
                      },
                      color: red),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildSellerProfile(Textstyle textstyle) {
    return Container(
        height: mq.height * .18,
        width: mq.width,
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              SizedBox(
                height: mq.width * .266,
                width: mq.width * .266,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(mq.width * .133),
                  child: CachedNetworkImage(
                    imageUrl: sharedPreference!.getString("imageurl") ??
                        "https://www.cricbuzz.com/a/img/v1/152x152/i1/c170899/tamim-iqbal.jpg",
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: mq.width * .08,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          sharedPreference!.getString("name") ??
                              "Md Jasim Uddin",
                          style: textstyle.largeText.copyWith(
                              fontSize: 20,
                              color: Theme.of(context).primaryColor)),
                      Text(sharedPreference!.getString("email") ?? "md Jasim",
                          style: textstyle.mediumText600.copyWith(
                              fontSize: 15,
                              color: Theme.of(context).hintColor)),
                      SizedBox(
                        height: mq.width * .011,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(greenColor),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 12)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfilePage(isEdit: true),
                                ));
                          },
                          child: Text(
                            "Edit Profile",
                            style: GoogleFonts.poppins(
                              color: white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  SwitchListTile _buildSwitchListTile(
      ThemeProvider themeProvider, BuildContext context) {
    return SwitchListTile(
      secondary: themeProvider.getDarkTheme
          ? Icon(
              Icons.dark_mode,
              color: white,
              size: 25,
            )
          : const Icon(Icons.light_mode),
      title: Text(
        themeProvider.getDarkTheme ? "Dark" : "Light",
        style: GoogleFonts.poppins(
          color: Theme.of(context).primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      activeColor: white,
      onChanged: (bool value) {
        themeProvider.setDarkTheme = value;
        setState(() {});
      },
      value: themeProvider.getDarkTheme,
    );
  }

  ListTile _buildListTitleMethod(
      {required String title,
      required IconData icon,
      required VoidCallback funcion,
      Color? color}) {
    return ListTile(
      onTap: color != null ? funcion : () {},
      leading: Icon(
        icon,
        color: color ?? Theme.of(context).primaryColor,
        size: 25,
      ),
      trailing: IconButton(
          onPressed: funcion,
          icon: Icon(
            Icons.arrow_forward_ios,
            color: color ?? Theme.of(context).primaryColor,
            size: 20,
          )),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: color ?? Theme.of(context).primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
