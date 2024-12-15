import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/res/app_string.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'binding/initial_binding.dart';
import 'res/app_constants.dart';
import 'res/apps_color.dart';
import 'res/routes/app_routes.dart';
import 'res/routes/routes_name.dart';

import 'service/provider/theme_provider.dart';

void main() async {
  // Ensures Flutter widgets are properly initialized before using them
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  // Get shared preferences instance for local storage
  AppConstants.sharedPreference = await SharedPreferences.getInstance();
  // Set up a handler for Firebase background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // Retrieve onboarding view status from shared preferences
  AppConstants.isViewed =
      AppConstants.sharedPreference!.getInt(AppString.onBoarding);
  // Launch the application
  runApp(const MyApp());
}

// Handles Firebase background messages

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
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
      // Set the design size for responsive layout
      designSize: const Size(450, 851), //582
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) {
              return ThemeProvider();
            },
          ),
        ],
        child: Consumer<ThemeProvider>(
          // Use Consumer to rebuild the app when the theme changes

          builder: (context, themeProvder, child) {
            return GetMaterialApp(
              // Set up initial bindings for dependency injection

              initialBinding: InitialBinding(),
              debugShowCheckedModeBanner: false,
              // Dynamically apply themes based on ThemeProvider

              theme: _buildAppTheme(themeProvder),
              // Set the initial route of the application

              initialRoute: RoutesName.initailRoutes,
              // Define all application routes

              getPages: AppRoutes.appRoutes(),
            );
          },
        ),
      ),
    );
  }

// Helper method to configure the app theme
  ThemeData _buildAppTheme(ThemeProvider themeProvider) {
    // Determine if the app is in dark theme mode
    var isDarkTheme = themeProvider.getDarkTheme;

    return ThemeData(
      // Configure icon colors based on the theme
      iconTheme: IconThemeData(
        color: isDarkTheme ? AppColors.white : AppColors.black,
      ),

      // Configure AppBar styling
      appBarTheme: AppBarTheme(
        // Set icon colors for the AppBar
        iconTheme: IconThemeData(
          color: isDarkTheme ? AppColors.white : AppColors.black,
        ),
        // Set background color for the AppBar
        backgroundColor:
            isDarkTheme ? AppColors.backgroundDark : AppColors.backgroundLight,
        // Set title text styling
        titleTextStyle: GoogleFonts.roboto(
          color: isDarkTheme ? AppColors.white : AppColors.black,
          fontSize: 18.sp, // Responsive font size using ScreenUtil
          fontWeight: FontWeight.bold,
        ),
        // Center the AppBar title
        centerTitle: true,
      ),

      // Configure scaffold background color
      scaffoldBackgroundColor:
          isDarkTheme ? AppColors.backgroundDark : AppColors.backgroundLight,

      // Configure card color
      cardColor: isDarkTheme ? AppColors.cardDark : AppColors.white,

      // Configure canvas color (e.g., for dialogs and sidebars)
      canvasColor:
          isDarkTheme ? AppColors.cardDark : AppColors.searchLightColor,

      // Configure indicator color (e.g., progress indicators)
      indicatorColor: isDarkTheme
          ? AppColors.indicatorColorDarkColor
          : AppColors.indicatorColorightColor,

      // Configure hint text color (e.g., placeholder text)
      hintColor: isDarkTheme ? AppColors.hintDark : AppColors.hintLight,

      // Configure the primary color (e.g., buttons and highlights)
      primaryColor: isDarkTheme ? AppColors.white : AppColors.black,
    );
  }
}


///Benefits of Comments:
/*
Better Understanding: Developers can quickly grasp the purpose of each block.
Maintainability: Easier to modify or extend the functionality.
Clarity: Clearly highlights the role of third-party integrations like Firebase, SharedPreferences, and providers.

Organized the ThemeData setup into its own private _buildAppTheme method for better separation of concerns

Added safe access (?) for shared preferences initialization.




*/
///



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