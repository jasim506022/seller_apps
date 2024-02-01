import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../const/approutes.dart';
import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../model/profilemodel.dart';
import '../../service/database/firebasedatabase.dart';
import '../../service/provider/theme_provider.dart';
import '../../widget/custom_show_dialog_widget.dart';
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
        automaticallyImplyLeading: false,
        title: const Text("Profile"),
      ),
      body: FutureBuilder(
          future: FirebaseDatabase.profileSnapshot(),
          builder: (context, snapshot) {
            try {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                ProfileModel profileModel =
                    ProfileModel.fromMap(snapshot.data!.data()!);
                return Column(
                  children: [
                    _buildSellerProfile(textstyle, profileModel),
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
                                      builder: (context) => EditProfilePage(
                                        isEdit: false,
                                        profileModel: profileModel,
                                      ),
                                    ));
                              },
                            ),
                            _buildListTitleMethod(
                              icon: Icons.home_outlined,
                              title: 'Home',
                              funcion: () {
                                Navigator.pushNamed(
                                    context, AppRouters.mainPage);
                              },
                            ),
                            _buildListTitleMethod(
                              icon: Icons.reorder,
                              title: 'My Orders',
                              funcion: () {
                                Navigator.pushNamed(
                                    context, AppRouters.orderPage);
                              },
                            ),
                            _buildListTitleMethod(
                              icon: Icons.picture_in_picture_alt_rounded,
                              title: 'Shifted Orders',
                              funcion: () {
                                Navigator.pushNamed(
                                    context, AppRouters.shiftPage);
                              },
                            ),
                            _buildListTitleMethod(
                              icon: Icons.access_time,
                              title: 'History',
                              funcion: () {
                                Navigator.pushNamed(
                                    context, AppRouters.completeOrderPage);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           const CompleteOrderPage(),
                                //     ));
                              },
                            ),
                            _buildListTitleMethod(
                              icon: Icons.money,
                              title: 'Earn',
                              funcion: () {
                                Navigator.pushNamed(
                                    context, AppRouters.totalSales);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           const TotalSellPage(),
                                //     ));
                              },
                            ),
                            Consumer<ThemeProvider>(
                              builder: (context, themeProvider, child) {
                                return _buildSwitchListTile(
                                    themeProvider, context);
                              },
                            ),
                            _buildListTitleMethod(
                                icon: Icons.exit_to_app,
                                title: "Sign Out",
                                funcion: () async {
                                  try {
                                    final result = await InternetAddress.lookup(
                                        'google.com');
                                    if (result.isNotEmpty &&
                                        result[0].rawAddress.isNotEmpty) {
                                      if (mounted) {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              CustomDialogWidget(
                                                  title:
                                                      "Are you want to Logout?",
                                                  content:
                                                      "Are you want to Logout this Apps",
                                                  onOkayPressed: () {
                                                    FirebaseAuth.instance
                                                        .signOut()
                                                        .then((value) async {
                                                      await GoogleSignIn()
                                                          .signOut();
                                                    });
                                                    Navigator
                                                        .pushNamedAndRemoveUntil(
                                                            context,
                                                            AppRouters.signPage,
                                                            (route) => false);
                                                  }),
                                        );
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
                );
              } else if (snapshot.hasError) {
                return globalMethod.flutterToast(
                    msg: "Error: ${snapshot.error}");
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            } catch (error) {
              return globalMethod.flutterToast(msg: "Unexpected Error: $error");
            }
          }),
    );
  }

  Container _buildSellerProfile(
      Textstyle textstyle, ProfileModel profileModel) {
    return Container(
        height: mq.height * .18,
        width: mq.width,
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .044),
          child: Row(
            children: [
              Container(
                height: mq.width * .266,
                width: mq.width * .266,
                decoration: BoxDecoration(
                    border: Border.all(color: red), shape: BoxShape.circle),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(mq.width * .133),
                  child: CachedNetworkImage(
                    imageUrl: profileModel.imageurl!,
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
                      Text(profileModel.name!,
                          style: textstyle.largeText.copyWith(
                              fontSize: 20,
                              color: Theme.of(context).primaryColor)),
                      Text(profileModel.email!,
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
                                  builder: (context) => EditProfilePage(
                                      isEdit: true, profileModel: profileModel),
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
