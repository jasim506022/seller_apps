import 'package:flutter/material.dart';
import 'package:seller_apps/const/const.dart';
import '../../res/apps_color.dart';
import '../../res/routes/routes_name.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/profile_controller.dart';
import '../../res/app_function.dart';
import 'widget/profile_custom_list_title_widget.dart';
import 'widget/profile_header_widget.dart';
import 'widget/theme_change_widget.dart';

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
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings_outlined,
                size: 25.h,
                color: Theme.of(context).primaryColor,
              ))
        ],
      ),
      body: Column(
        children: [
          const ProifleHeaderWidget(),
          Expanded(
            child: ListView(
              children: [
                Divider(
                  height: defaulHieighSpace,
                  color: Theme.of(context).hintColor,
                  thickness: 2,
                ),
                _buildProfileMenuItems(context),
                const ThemeChangeWidget(),
                ProfileCustomListTitleWidget(
                  showTrailing: false,
                  icon: Icons.exit_to_app,
                  title: 'Sign Out',
                  iconColor: AppColors.red,
                  onTap: () async {
                    if (!(await AppsFunction.verifyInternetStatus())) {
                      profileController.signOut();
                    }
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
  Widget _buildProfileMenuItems(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        "icon": Icons.person,
        "title": 'About',
        "route": RoutesName.editProfilePage //RoutesName.editProfileScreen
      },
      {
        "icon": Icons.home_outlined,
        "title": 'Home',
        "route": RoutesName.mainPage,
        "argument": 0
      },
      {
        "icon": Icons.reorder,
        "title": 'My Orders',
        "route": RoutesName.orderPage
      },
      {
        "icon": Icons.access_time,
        "title": 'History',
        "route": RoutesName.completeOrderPage //RoutesName.historyPage
      },
      {
        "icon": Icons.search,
        "title": 'Search',
        "route": RoutesName.mainPage,
        "argument": 2
      },
    ];

    return Column(
      children: menuItems.map((item) {
        return ProfileCustomListTitleWidget(
          icon: item['icon'],
          title: item['title'],
          onTap: () async {
            if (!(await AppsFunction.verifyInternetStatus())) {
              if (item['argument'] is int) {
                Get.offAndToNamed(item['route'], arguments: item['argument']);
              } else {
                Get.toNamed(item['route']);
              }
            }
          },
        );
      }).toList(),
    );
  }

  // Build theme switcher widget
}





/*
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    Textstyle textstyle = Textstyle(context);

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
                                    context, RoutesName.mainPage);
                              },
                            ),
                            _buildListTitleMethod(
                              icon: Icons.reorder,
                              title: 'My Orders',
                              funcion: () {
                                Navigator.pushNamed(
                                    context, RoutesName.orderPage);
                              },
                            ),
                            _buildListTitleMethod(
                              icon: Icons.picture_in_picture_alt_rounded,
                              title: 'Shifted Orders',
                              funcion: () {
                                Navigator.pushNamed(
                                    context, RoutesName.shiftPage);
                              },
                            ),
                            _buildListTitleMethod(
                              icon: Icons.access_time,
                              title: 'History',
                              funcion: () {
                                Navigator.pushNamed(
                                    context, RoutesName.completeOrderPage);
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
                                    context, RoutesName.totalSales);
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
                                                            RoutesName.signPage,
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
    var mq = MediaQuery.of(context).size;
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

*/