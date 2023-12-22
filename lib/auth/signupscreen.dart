import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:seller_apps/auth/signinscreen.dart';
import 'package:seller_apps/const/global.dart';
import 'package:seller_apps/widget/loadingwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const/const.dart';
import '../widget/passwordtextfieldwidget.dart';
import '../widget/textfieldformwidget.dart';
import 'forgetpasswordscreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void dispose() {
    phoneET.dispose();
    nameET.dispose();
    emailET.dispose();
    passwordET.dispose();
    confirmpasswordET.dispose();

    super.dispose();
  }

  TextEditingController phoneET = TextEditingController();
  TextEditingController nameET = TextEditingController();
  TextEditingController emailET = TextEditingController();
  TextEditingController passwordET = TextEditingController();
  TextEditingController confirmpasswordET = TextEditingController();

  String? number;

  final ImagePicker picker = ImagePicker();
  var formKey = GlobalKey<FormState>();
  XFile? imageFile;

  String? imageDownloadUrl;

  getImageFromGaller() async {
    imageFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile;
    });
  }

  signUpForm() async {
    if (imageFile != null) {
      if (formKey.currentState!.validate()) {
        showDialog(
          context: context,
          builder: (context) {
            return const LoadingWidget(message: "Registration Processing");
          },
        );
        if (passwordET.text.trim() == confirmpasswordET.text.trim()) {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();

          //create instance
          Reference storageRef =
              FirebaseStorage.instance.ref().child("userImage").child(fileName);
          //upload file
          UploadTask uploadTask = storageRef.putFile(File(imageFile!.path));

          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

          taskSnapshot.ref.getDownloadURL().then((downloadurl) {
            imageDownloadUrl = downloadurl;
          });
          // Save  information Database
          User? currentUser;
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailET.text.trim(), password: passwordET.text.trim())
              .then((user) {
            currentUser = user.user;
          }).catchError((error) {
            Navigator.pop(context);
            globalMethod.flutterToast(msg: 'Error $error');
          });
          if (currentUser != null) {
            FirebaseFirestore.instance
                .collection("seller")
                .doc(currentUser!.uid)
                .set({
              "uid": currentUser!.uid,
              "email": currentUser!.email,
              "name": nameET.text.trim(),
              "phone": phoneET.text.trim(),
              "imageurl": imageDownloadUrl,
              "status": "approved",
              "earnings": 0.0,
            });

            // save local
            sharedPreference = await SharedPreferences.getInstance();
            await sharedPreference!.setString("uid", currentUser!.uid);
            await sharedPreference!.setString("email", currentUser!.email!);
            await sharedPreference!.setString("name", nameET.text.trim());
            await sharedPreference!.setString("imageurl", imageDownloadUrl!);

// ignore: use_build_context_synchronously
            Navigator.pop(context);
            globalMethod.flutterToast(msg: 'Registration Successfully');

            // ignore: use_build_context_synchronously
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInScrren(),
                ));
          }
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          globalMethod.flutterToast(
              msg: "Password and Confirm Password Doesn't Equal");
        }
      }
    } else {
      // ignore: use_build_context_synchronously
      globalMethod.flutterToast(msg: 'Please Select An Image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                InkWell(
                  onTap: () {
                    getImageFromGaller();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 3)),
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * .2,
                      backgroundImage: imageFile == null
                          ? null
                          : FileImage(File(imageFile!.path)),
                      backgroundColor: const Color.fromARGB(255, 229, 228, 228),
                      foregroundColor: Colors.black,
                      child: imageFile == null
                          ? Icon(
                              Icons.add_photo_alternate,
                              size: MediaQuery.of(context).size.width * .2,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Registration",
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
                        hintText: 'Name',
                        controller: nameET,
                      ),
                      TextFieldFormWidget(
                        hintText: 'Email',
                        controller: emailET,
                        textInputType: TextInputType.emailAddress,
                      ),
                      PaswordTextFieldWidget(
                        hintText: 'Password',
                        controller: passwordET,
                      ),
                      PaswordTextFieldWidget(
                        hintText: 'Confirm Password',
                        controller: confirmpasswordET,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      IntlPhoneField(
                        controller: phoneET,
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          hintStyle: GoogleFonts.poppins(
                              color: const Color(0xffc8c8d5)),
                          labelStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(),
                          ),
                        ),
                        languageCode: "en",
                        initialCountryCode: 'BD',
                        onChanged: (phone) {
                          number = phone.completeNumber;
                          setState(() {});
                        },
                        onCountryChanged: (country) {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
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
                    if (kDebugMode) {
                      print("Hello");
                    }
                    signUpForm();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: const Color(0xff00b761),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Sign Up",
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
                    text: "Already Create An Account? ",
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
