import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seller_apps/auth/forgetpasswordscreen.dart';
import 'package:seller_apps/auth/signupscreen.dart';
import 'package:seller_apps/main/mainscreen.dart';
import 'package:seller_apps/widget/loadingwidget.dart';
import '../const/global.dart';
import '../widget/passwordtextfieldwidget.dart';
import '../widget/textfieldformwidget.dart';

class SignInScrren extends StatefulWidget {
  const SignInScrren({super.key});

  @override
  State<SignInScrren> createState() => _SignInScrrenState();
}

class _SignInScrrenState extends State<SignInScrren> {
  TextEditingController passwordET = TextEditingController();
  TextEditingController emailET = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    passwordET.dispose();
    emailET.dispose();
    super.dispose();
  }

  void loginForm() async {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return const LoadingWidget(message: "Checking User");
        },
      );

      User? currentUser;

      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailET.text.trim(), password: passwordET.text.trim())
          .then((userCredential) async {
        currentUser = userCredential.user;

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ));
      }).catchError((error) {
        Navigator.pop(context);
        flutterToast(msg: 'Error Occured: $error');
      });
    }
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
                  "Welcome Back!",
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Check our fresh viggies from Jasim Grocery",
                  style: GoogleFonts.poppins(
                      fontSize: 16, color: const Color(0xff686874)),
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFieldFormWidget(
                        hintText: 'Mobile Number',
                        controller: emailET,
                        textInputType: TextInputType.emailAddress,
                      ),
                      PaswordTextFieldWidget(
                        hintText: "Password",
                        controller: passwordET,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgetPasswordScreen(),
                            ));
                      },
                      child: Text(
                        "Forget Password",
                        style: GoogleFonts.poppins(
                            color: const Color(0xff686874),
                            fontWeight: FontWeight.w500),
                      ),
                    )),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    loginForm();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: const Color(0xff00b761),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Sign in",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 2.5,
                      width: 70,
                      color: const Color(0xffc8c8d5),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "with Or",
                        style: TextStyle(color: Color(0xffc8c8d5)),
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 70,
                      color: const Color(0xffc8c8d5),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "asset/image/facebook.png",
                              height: 35,
                              width: 35,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Facebook",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "asset/image/gmail.png",
                              height: 35,
                              width: 35,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Gmail",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "Don't Have An Account? ",
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
                                builder: (context) => const SignUpScreen(),
                              ));
                        },
                      text: "Create Account",
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
