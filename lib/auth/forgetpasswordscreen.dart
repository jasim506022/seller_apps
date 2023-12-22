import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seller_apps/auth/signinscreen.dart';
import '../const/const.dart';
import '../widget/textfieldformwidget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailET = TextEditingController();

  @override
  void dispose() {
    emailET.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Material(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Image.asset(
                  "asset/image/logo.png",
                  height: 150,
                  width: 150,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Forget Your Password?",
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "Please Enter your mail address to reset you password",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: const Color(0xff686874)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldFormWidget(
                  hintText: 'Email Address',
                  controller: emailET,
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: emailET.text)
                        .then((value) {
                      globalMethod.flutterToast(msg: "Please Check Your mail");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScrren(),
                          ));
                    }).catchError((error) {
                      globalMethod.flutterToast(msg: "Error Occured: $error");
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: const Color(0xff00b761),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Reset Passord",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "If you don't want to reset Password? ",
                    style: GoogleFonts.poppins(
                        color: const Color(0xff686874),
                        fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInScrren(),
                              ));
                        },
                      text: "Sign In",
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          color: const Color(0xff00B761),
                          fontWeight: FontWeight.w800))
                ])),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
