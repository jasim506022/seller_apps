import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/auth/signinscreen.dart';
import 'package:seller_apps/const/global.dart';
import 'package:seller_apps/main/mainscreen.dart';
import 'package:seller_apps/service/provider/dropvalueselectallprovider.dart';
import 'package:seller_apps/service/provider/searchtextprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreference = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return DropValuesAllProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return SearchTextProvider();
          },
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: FirebaseAuth.instance.currentUser == null
            ? const SignInScrren()
            : MainScreen(),
      ),
    );
  }
}
