import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seller_apps/auth/signinscreen.dart';
import 'package:seller_apps/page/main/mainscreen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  splashScreenTimer() {
    Timer(
      const Duration(seconds: 4),
      () async {
        if (FirebaseAuth.instance.currentUser != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInScrren(),
              ));
        }
      },
    );
  }

  @override
  void initState() {
    splashScreenTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Image.asset(
            "asset/image/splash.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          Positioned(
            bottom: 0,
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "asset/image/icon.png",
                  height: 150,
                  width: 150,
                ),
                Text(
                  "Grocery Apps",
                  style: GoogleFonts.poppins(
                      color: const Color(0xff00b761),
                      fontSize: 22,
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
