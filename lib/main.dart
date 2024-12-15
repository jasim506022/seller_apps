import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/res/routes/app_routes.dart';

import 'package:seller_apps/service/provider/imageaddremoveprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'binding/initial_binding.dart';
import 'res/app_constants.dart';
import 'res/apps_color.dart';
import 'res/routes/routes_name.dart';

import 'service/provider/dropvalueselectallprovider.dart';

import 'service/provider/loadingprovider.dart';
import 'service/provider/searchprovider.dart';
import 'service/provider/theme_provider.dart';
import 'service/provider/totalamountprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AppConstants.sharedPreference = await SharedPreferences.getInstance();
  FirebaseMessaging.onBackgroundMessage(firebaseMessingbackground);
  AppConstants.isViewed = AppConstants.sharedPreference!.getInt('onBoarding');
  runApp(const MyApp());
}

Future<void> firebaseMessingbackground(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message ${message.data}");
    print("Handling a background message ${message.notification!.title}");
    print("Handling a background message ${message.notification!.body}");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(450, 851), //582
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) {
              return CateoryDropValueProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return SearchProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return ImageAddRemoveProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return ThemeProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return TotalAmountProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return LoadingProvider();
            },
          ),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvder, child) {
            return GetMaterialApp(
              initialBinding: InitialBinding(),
              debugShowCheckedModeBanner: false,
              theme: themeData(themeProvder),
              initialRoute: RoutesName.initailRoutes,
              getPages: AppRoutes.appRoutes(),
            );
          },
        ),
      ),
    );
  }

  ThemeData themeData(ThemeProvider themeProvder) {
    return ThemeData(
        iconTheme: IconThemeData(
            color:
                themeProvder.getDarkTheme ? AppColors.white : AppColors.black),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
              color: themeProvder.getDarkTheme
                  ? AppColors.white
                  : AppColors.black),
          backgroundColor: themeProvder.getDarkTheme
              ? AppColors.backgroundDarkColor
              : AppColors.backgroundLightColor,
          titleTextStyle: GoogleFonts.roboto(
              color:
                  themeProvder.getDarkTheme ? AppColors.white : AppColors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          centerTitle: true,
        ),
        // Scaffold Background Color
        scaffoldBackgroundColor: themeProvder.getDarkTheme
            ? AppColors.backgroundDarkColor
            : AppColors.backgroundLightColor,
        //Card Color
        cardColor: themeProvder.getDarkTheme
            ? AppColors.cardDarkColor
            : AppColors.white,
        //CanvasColor
        canvasColor: themeProvder.getDarkTheme
            ? AppColors.cardDarkColor
            : AppColors.searchLightColor,
        // Indicator Color
        indicatorColor: themeProvder.getDarkTheme
            ? AppColors.indicatorColorDarkColor
            : AppColors.indicatorColorightColor,

        // Hint Color
        hintColor: themeProvder.getDarkTheme
            ? AppColors.hintDark
            : AppColors.hintLight,
        //brightness
        // brightness:
        //     themeProvder.getDarkTheme ? Brightness.light : Brightness.dark,
        // Primary
        primaryColor:
            themeProvder.getDarkTheme ? AppColors.white : AppColors.black);
  }
}



/*

class GlobalMethod {

// Text Form Field Decoration
  InputDecoration textFormFielddecoration({
    bool isShowPassword = false,
    required String hintText,
    bool obscureText = false,
    required Function function,
    bool profileTextForm = false,
  }) {
    final OutlineInputBorder defaultOutlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: profileTextForm ? Colors.black : Colors.transparent,
        width: profileTextForm ? 1 : 0,
      ),
      borderRadius: BorderRadius.circular(15),
    );
    return InputDecoration(
      labelStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      fillColor: searchLightColor,
      filled: true,
      hintText: hintText,
      border: defaultOutlineInputBorder,
      enabledBorder: defaultOutlineInputBorder,
      focusedBorder: defaultOutlineInputBorder,
      suffixIcon: isShowPassword
          ? IconButton(
              onPressed: () {
                function();
              },
              icon: Icon(
                Icons.password,
                color: obscureText ? hintLightColor : red,
              ))
          : null,
      contentPadding: EdgeInsets.symmetric(
          horizontal: 15.w, vertical: 20.h),
      hintStyle: const TextStyle(
        color: Color(0xffc8c8d5),
      ),
    );
  }

// Elevate Button Style
  ButtonStyle elevateButtonStyle() => ElevatedButton.styleFrom(
        backgroundColor: greenColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 10.w, vertical: 10.h),
      );

// Rich Text
  RichText buldRichText(
      {required BuildContext context,
      required String simpleText,
      required String colorText,
      required Function function}) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: simpleText,
        style: GoogleFonts.poppins(
            color: cardDarkColor, fontWeight: FontWeight.w500),
      ),
      TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              function();
            },
          text: colorText,
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                decoration: TextDecoration.underline,
              ),
              color: deepGreen,
              fontWeight: FontWeight.w800))
    ]));
  }

// Flutter Toast
  flutterToast({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: greenColor,
        textColor: white,
        fontSize: 16.0);
  }

// IsValidEmail
  bool isValidEmail(String email) {
    // Regular expression for a more comprehensive email validation
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)*[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

// Get User Share Preference

  getUsersharedPreference() async {
    try {
      await FirebaseDatabase.currentUserDataSnapshot().then((snapshot) async {
        if (snapshot.exists) {
          ProfileModel profileModel = ProfileModel.fromMap(snapshot.data()!);
          if (profileModel.status == "approved") {
            await AppConstants. sharedPreference!.setString("uid", profileModel.uid!);
            await AppConstants.sharedPreference!.setString("email", profileModel.email!);
            await AppConstants. sharedPreference!.setString("name", profileModel.name!);
            await AppConstants.sharedPreference!
                .setString("imageurl", profileModel.imageurl!);
            await AppConstants.sharedPreference!
                .setString("phone", profileModel.phone ?? "+088");
          } else {
            flutterToast(msg: "User Doesn't Exist");
          }
        }
      });
    } catch (error) {
      flutterToast(msg: "Error Ocurred: $error");
    }
  }

  void handleError(
    BuildContext context,
    dynamic e,
    LoadingProvider loadingProvider,
  ) {
    Navigator.pop(context);

    String title;
    String message;

    switch (e.code) {
      case 'email-already-in-use':
        title = 'Email Already in Use';
        message = 'Email Already In User. Please Use Another Email';
        break;
      case 'invalid-email':
        title = 'Invalid Email Address';
        message = 'Invalid Email address. Please put Valid Email Address';
        break;
      case 'weak-password':
        title = 'Invalid Password';
        message = 'Invalid Password. Please Put Valid Password';
        break;
      case 'too-many-requests':
        title = 'Too Many Requests';
        message = 'Too many requests';
        break;
      case 'operation-not-allowed':
        title = 'Operation Not Allowed';
        message = 'Operation Not Allowed';
        break;
      case 'user-disabled':
        title = 'User Disabled';
        message = 'User Disable';
        break;
      case 'user-not-found':
        title = 'User Not Found';
        message = 'User Not Found';
        break;
      case 'wrong-password':
        title = 'Incorrect password';
        message = 'Password Incorrect. Please Check your Password';
        break;
      default:
        title = 'Error Occurred';
        message = 'Please check your internet connection or other issues.';
        break;
    }

    showDialog(
      context: context,
      builder: (context) =>
          ShowErrorDialogWidget(title: title, message: message),
    );

    loadingProvider.setLoading(loading: false);
  }

  String getFormateDate(
      {required BuildContext context, required String datetime}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(datetime));
    return DateFormat("MMM d, yyyy").format(date);
  }

  double discountedPrice(double productprice, double discount) {
    double discountPrice = productprice - (productprice * discount / 100);

    return double.parse(discountPrice.toStringAsFixed(2));
  }

// Drop Down Button Decoration
  InputDecoration decorationDropDownButtonForm(BuildContext context) {
    return InputDecoration(
      fillColor: Theme.of(context).cardColor,
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(15)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
    );
  }

  Container buildShimmerTextContainer(Color color, double height) {
    return Container(
      height: height,
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
    );
  }
}

*/